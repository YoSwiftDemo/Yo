//
//  STCMusicPlayerCenterManager.m
//  FanweApp
//
//  Created by 岳克奎 on 17/1/16.
//  Copyright © 2017年 xfg. All rights reserved.
//

#import "STCMusicPlayerCenterManager.h"
#import "SuperpoweredAdvancedAudioPlayer.h"
#import "SuperpoweredReverb.h"
#import "SuperpoweredFilter.h"
#import "Superpowered3BandEQ.h"
#import "SuperpoweredEcho.h"
#import "SuperpoweredRoll.h"
#import "SuperpoweredFlanger.h"
#import "SuperpoweredSimple.h"
#import "SuperpoweredIOSAudioIO.h"
#import "Superpowered3BandEQ.h"
#import <mach/mach_time.h>
#import <libkern/OSAtomic.h>
#include <AudioToolbox/AudioConverter.h>

#define MUSIC_SAMPLERATE                44100     //采样率（默认这个吧）
// 音效的宏定义
#define NUMFXUNITS 8
#define TIMEPITCHINDEX 0
#define PITCHSHIFTINDEX 1
#define ROLLINDEX 2
#define FILTERINDEX 3
#define EQINDEX 4
#define FLANGERINDEX 5
#define DELAYINDEX 6
#define REVERBINDEX 7
@interface STCMusicPlayerCenterManager ()  <SuperpoweredIOSAudioIODelegate>
@end
@implementation STCMusicPlayerCenterManager 
{
    SuperpoweredAdvancedAudioPlayer   *_superPlayer;            //播放器
    SuperpoweredIOSAudioIO            *_superHandles;           //player处理器
    Superpowered3BandEQ               *_superBandEQ;            //音乐平衡器(主要控制音效的 高中低效果)
    float                             *_stereoBuffer;           //立体缓存   感觉这应该是当前播放 缓冲区 与进度 音效息息相关
    SuperpoweredFX                    *effects[NUMFXUNITS];
    char *                            _tempBuffer;
    char*                             _outDataBuffer;
    int                               _outBufferSize;
    int                               frame;
    int                               config;
    CADisplayLink                     *displayLink;
    uint64_t                          *superpoweredAvgUnits;
    uint64_t                          *superpoweredMaxUnits;
    uint64_t                          *coreaudioAvgUnits;
    uint64_t                          *coreaudioMaxUnits;
    __volatile int                    _outBufferPushInOffset;
    __volatile int                    _outBufferCopyOutOffset;
    __volatile int                    _outBufferNowSize;//当前有多少
    OSSpinLock                        _outBufferSpinlock;
}
#pragma mark - life cycle------------------------------------- 控制生命周期区域
/**
 * @brief: 单利
 *
 * @discussion:我的想法是，用单利管理，这样能够通过C++的player对应的控制器来控制。播放，暂停。如果不这样，需要频繁的
 */
static STCMusicPlayerCenterManager *signleton = nil;
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        signleton = [super allocWithZone:zone];
    });
    return signleton;
}
+ (STCMusicPlayerCenterManager *)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        signleton = [[self alloc] init];
    });
    
    return signleton;
}
+ (id)copyWithZone:(struct _NSZone *)zone
{
    return signleton;
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return signleton;
}
#pragma mark -private methods ------------------------------------- 私人方法区域 ------------------------------------------
#pragma mark- 生成C++播放器
/**
 * @brief：生成C++播放器.
 *
 * @prama: samplerate         采样率 44100 48000
 * @prama: musicFilePathStr   音乐路径Str
 *
 * @Step: superPlayer         只需要采样率 (需要考虑如果采样率变了，再继续采用懒加载，需要调什么更变采样率)
 * @Step: play(false)         默认不播放状态
 * @Step: setBpm(124.0f)      beat per minute=每分钟节拍数 没有auto-bpm检测内部,你必须设置原始bpm的跟踪与此同步。应该被称为成功后打开()
 * @Step: SuperpoweredFilter  过滤器。暂时理解为设置调节播放器的参数的工具
 * @Step:
 * @Step: SuperpoweredReverb  混响
 * @Step: _superHandles       player处理器.
 *
 * @discussion:1.默认生成的C++播放器尚未加载路径。因为首次在家会走这里，如果播放器存在了，就不走这里了
 */
-(SuperpoweredAdvancedAudioPlayer *)loadSuperPlayerwithSamplerate:(int)samplerate
                                               ofmusicFilePathStr:(NSString *)musicFilePathStr{
    //samplerate =44100;
    
    SuperpoweredAdvancedAudioPlayer *superPlayer = new SuperpoweredAdvancedAudioPlayer(NULL,
                                                                                       NULL,
                                                                                       samplerate,
                                                                                       0);
    //superPlayer->play(false);  这个应该是先默认不要播放+再调播放。目前不需要这样。播放就播放
    superPlayer->setBpm(124.0f);
    
    return superPlayer;
}
-(void)showSuperHanes{
    // 音效调的高中低调节
    _superBandEQ = new Superpowered3BandEQ(_samplerate);
    _superBandEQ->bands[0] = 1.0f;
    _superBandEQ->bands[1] = 1.0f;
    _superBandEQ->bands[2] = 1.0f;
    _superBandEQ->enable(true);
    
    //播放器处理类 负责开启关闭 但是开启关闭并不能改变播放状态，方法获取状态，需要暂停恢复方法来改变
    if (!_superHandles) {
        
        _superHandles =[[SuperpoweredIOSAudioIO alloc]initWithDelegate:(id<SuperpoweredIOSAudioIODelegate>)self
                                                   preferredBufferSize:12
                                            preferredMinimumSamplerate:_samplerate
                                                  audioSessionCategory:AVAudioSessionCategoryPlayAndRecord
                                                              channels:2];
        
    }
    [_superHandles setdelg:self];
}
#pragma mark- 播放器加载歌曲
/**
 *@brief： 播放器加载歌曲
 *
 *@Step: 需要音乐处理器 开启
 */
-(BOOL)musicSuperPlayerPlayWithMudicPathStr:(NSString *)musicFilePathStr
                                 samplerate:(int)samplerate{
    //加锁
    _outBufferSpinlock = OS_SPINLOCK_INIT;
    _outBufferPushInOffset = 0;
    _outBufferPushInOffset = 0;
    //初始化 基本数据
    // 默认音量为6
    _recordSTCMusicPlyerOfBGMValue = 0.5;
    //默认音调为0
    self.recordSTCMusicPlyerOfPitchValue = 0;
    //音效类型
    self.recordSTCMusicPlyerOfEffectTypeValue = 0;
    //采用率
    _samplerate = samplerate;
    //立体缓存 初始化
    if (posix_memalign((void **)&_stereoBuffer, 16, 1024*4 + 128) != 0)
    {
        return false;
    }
    //输出内存 初始化
    _outBufferSize = 1024*4*8;  //
    if (posix_memalign((void **)&_outDataBuffer, 16, _outBufferSize ) != 0 )
    {
        return false;
    }
    // 缓冲内存 初始化
    if (posix_memalign((void **)&_tempBuffer, 16, 1024*4*8 ) != 0 )
    {
        return false;
    }
    //采样率暂时默认 44100
    _samplerate =MUSIC_SAMPLERATE;
    //如果播放器存在就不再创建
    if (!_superPlayer) {
        _superPlayer = [self loadSuperPlayerwithSamplerate:_samplerate
                                        ofmusicFilePathStr:musicFilePathStr];
    }
    if (!_superHandles) {
        [self showSuperHanes];
    }
    //test  测试本地数据
     _superPlayer->open([[[NSBundle mainBundle] pathForResource:@"王菲传奇"
     ofType:@"mp3"] fileSystemRepresentation]);
     
    //加载指定路径
   // _superPlayer->open([musicFilePathStr fileSystemRepresentation]);
 
    return YES;
}
#pragma mark - push buffer  推送数据至缓冲区(Data)
/**
 * @brief: 推送数据至缓冲区
 *
 * @Step:新申请的内存做初始化工作  函数void *memset(void *s, int ch, size_t n);     将s中当前位置后面的n个字节 （typedef unsigned int size_t ）用 ch 替换并返回 s 。作用是在一段内存块中填充某个给定的值，它是对较大的结构体或数组进行清零操作的一种最快方法
 *                                    参数prama：1.s 指定的内存地址 2.   3.指定块的大小
 *
 *
 *
 */
-(void)pushBuffer:(char *)inbuffer bufferOfSize:(int)buffersize{
    //枷锁
    OSSpinLockLock(&_outBufferSpinlock);
    
    if( _outBufferPushInOffset + buffersize > _outBufferSize )
    {
        memcpy( &_outDataBuffer[ _outBufferPushInOffset ] , inbuffer, _outBufferSize - _outBufferPushInOffset );
        memcpy( &_outDataBuffer[0] , &inbuffer [ _outBufferSize - _outBufferPushInOffset ] , buffersize - (_outBufferSize - _outBufferPushInOffset) );
        _outBufferPushInOffset = buffersize - (_outBufferSize - _outBufferPushInOffset);
    }
    else
    {
        memcpy( &_outDataBuffer[ _outBufferPushInOffset ] , inbuffer, buffersize );
        _outBufferPushInOffset += buffersize;
    }
    _outBufferNowSize += buffersize;
    if( _outBufferNowSize > _outBufferSize )
    {
    }
    OSSpinLockUnlock(&_outBufferSpinlock);
    
}

#pragma mark -public  methods ------------------------------------------ 公有方法区域  -----------------------------------------

#pragma mark- 获取当前音乐的播放状态
/**
 * @brief: 音乐播放暂停后恢复播放
 *
 * @return: YES:代表正在播放中 NO:代表操木有音乐或播放暂停
 *
 * @use:
 */
-(BOOL)showMusicPlayingState{
    if (!self->_superPlayer) {
        return NO;
    }
    if (self->_superPlayer->playing) {
        return YES;
    }else{
        return NO;
    }
}
#pragma mark - 将内存里的数据copy 推送到腾讯 （Data）
/**
 * @brief:将内存里的数据copy 推送到混音接口 （Data）
 *
 * @prama:buffer C的字符  传入的是 混音需要 透传的 内存地址
 * @prama: buffersize 内存地址大小
 *
 * @discussion:如果没有足够的 buffersize 长度数据,就不拷贝 返回0 ,等着下次,
 *
 * @use: 腾讯互动SDK 混音接口 数据传输
 */
-(int)copyOutBuffer:(char*)buffer
         buffersize:(int)buffersize
{
    //枷锁
    OSSpinLockLock(&_outBufferSpinlock);
    //当前数据太小，等下一次
    if( _outBufferNowSize < buffersize )
    {   //解锁
        OSSpinLockUnlock(&_outBufferSpinlock);
        return 0;
    }
    // _outBufferCopyOutOffset  腾讯的算法里也没个解释，真是醉了。理解成为 内存动态幅度偏移？
    if( _outBufferCopyOutOffset + buffersize > _outBufferSize )
    {
        memcpy( buffer  , &_outDataBuffer[ _outBufferCopyOutOffset ], _outBufferSize - _outBufferCopyOutOffset );
        memcpy( &buffer[ _outBufferSize - _outBufferCopyOutOffset ]  , &_outDataBuffer[ 0 ], buffersize - (_outBufferSize - _outBufferCopyOutOffset) );
        _outBufferCopyOutOffset = buffersize - (_outBufferSize - _outBufferCopyOutOffset);
    }
    else
    {
        memcpy( buffer  , &_outDataBuffer[ _outBufferCopyOutOffset ], buffersize );
        _outBufferCopyOutOffset += buffersize;
    }
    _outBufferNowSize -= buffersize;
    //解锁
    OSSpinLockUnlock(&_outBufferSpinlock);
    //返回的是 int  作为混音memcpy 块的 大小，感觉腾讯给的算法不对劲呢
    return  buffersize;
}

#pragma mark-system  delegate ------------------------------------------ 实现系统代理区域----------------------------------------
#pragma mark-SuperpoweredIOSAudioIODelegate 处理器的代理方法(player delegate)
/**
 *  @brief：音乐处理器的代理方法
 *
 *  @prama: buffers              变化的过程中返回的数据
 *  @prama: inputChannels
 *  @prama: outputChannels
 *  @prama: numberOfSamples
 *  @prama: samplerate
 *  @prama: hostTime
 *
 *
 * @Step：stereoBuffer准备好了,我们把完成音频到所请求的缓冲区。
 */
-(bool)audioProcessingCallback:(float **)buffers
                 inputChannels:(unsigned int)inputChannels
                outputChannels:(unsigned int)outputChannels
               numberOfSamples:(unsigned int)numberOfSamples
                    samplerate:(unsigned int)samplerate
                      hostTime:(UInt64)hostTime{
    if( !_superPlayer->playing )
    {
        return false;
    }
    if(samplerate!=self->_samplerate){
        _samplerate =samplerate;
        _superPlayer->setSamplerate(samplerate);
        _superBandEQ->setSamplerate(samplerate);
    }
    //设置 silence
    //_accompanyValue  第三个参数0-1.0f  因为代码总是不断走这里 是不是可以 控制音量 通过单利player管理器把playerVC记录的sldier数据传过来。非常爽。
    //numberOfSamples 腾讯混音 音帧 默认48000 但是 采样率这么高，直播卡啊，而且44100 是人耳朵识别极限。那就就统一 44100
    bool silence = !_superPlayer->process(_stereoBuffer,
                                          false,
                                          numberOfSamples,
                                          _recordSTCMusicPlyerOfBGMValue,
                                          0.0f,
                                          -1.0);
    //_superBandEQ 这个类总感觉是在控制 将要播放活正字啊播放 那段内存数据，比如改变音效效果LMH（高中低），真不知道设置音效类型居然改变的是声音的高中低。真是醉了。
    //_stereoBuffer  感觉这应该是当前播放 缓冲区 与进度 音效息息相关 突然感觉 _superBandEQ 处理器 当前进行的功能 跟内存是什么有关系。到底什么关系呢。
    //numberOfSamples  不知道用统一的采用率。会是什么情况、
    _superBandEQ->process(_stereoBuffer, _stereoBuffer, numberOfSamples);
    //buffers  注意
    if (!silence){ SuperpoweredDeInterleave(_stereoBuffer,
                                            buffers[0],
                                            buffers[1],
                                            numberOfSamples);
    }
    //_tempBuffer 临时内存 初始化
    //memset初始化每一块内存 初始化地址 _tempBuffer。 块的大小 1024*8*4--->后期闲暇时候，可以考虑块的更变，能不能解决某些问题。比如观众看了，是不传下去的数据太小咯
    memset(_tempBuffer, 0, 1024*8*4);
    SuperpoweredFloatToShortInt(_stereoBuffer, (short int*)_tempBuffer, numberOfSamples); //播放非必须
    //把当前播放的数据 嫩到推送到临时存储区，之前改变过bufferOfSize，但是 电流声很大。
    [self pushBuffer:_tempBuffer
        bufferOfSize: numberOfSamples *4];

    if (_stCMusicPlayerCenterManagerBlock) {
        _stCMusicPlayerCenterManagerBlock(_superPlayer->durationSeconds, _superPlayer->positionSeconds,_superPlayer->positionPercent);
    }
    
    if (_delegate&&[_delegate respondsToSelector:@selector(sendDataFromSTCMusicPlayerCenterManagerToSTMusicUIViewCOfMusicTotalDuration:andMusicCurrentDuration:andMusicProgress:)]) {
        [_delegate sendDataFromSTCMusicPlayerCenterManagerToSTMusicUIViewCOfMusicTotalDuration:_superPlayer->durationSeconds
                                                                       andMusicCurrentDuration: _superPlayer->positionSeconds
                                                                              andMusicProgress:_superPlayer->positionPercent];
    }
    NSLog(@"hahha");
    return !silence;
}
#pragma mark - App进程打断后回到暂定方法 （player  delegate Method）
/**
 * @brief：音乐打断后回到暂定方法
 *
 * @use: ：音乐进程打断后
 *
 * @discusssion:要告诉调度中心，并且自身要暂停
 */
- (void)interruptionStarted {
    if(_superPlayer){
        _superPlayer->pause(0,1);
//        MUSIC_CENTER_MANAGER.musicPlayingState = NO;
    }
}
#pragma mark - 音乐打断结束后
/**
 * @brief：音乐打断结束后回到暂定方法
 *
 * @discusssion:  _superPlayer->onMediaserverInterrupt(); If the player plays Apple Lossless audio files, then we need this. Otherwise unnecessary.如果玩家扮演苹果无损音频文件,然后我们需要这个。否则没有必要的。
 * @use:打断结束
 */
- (void)interruptionEnded {
    //
}
#pragma mark - 记录允许拒绝（player  delegate Method）
/**
 * @brief：音乐记录允许拒绝
 *
 * @use: ：？？
 */
- (void)recordPermissionRefused {
}
/**
 * @brief：？
 *
 * @use: ：？？
 */
- (void)mapChannels:(multiOutputChannelMap *)outputMap
           inputMap:(multiInputChannelMap *)inputMap
externalAudioDeviceName:(NSString *)externalAudioDeviceName
   outputsAndInputs:(NSString *)outputsAndInputs {
}

#pragma mark- get+Set -------------------------------------------------- get+Se方法区域 ----------------------------------------
#pragma mark - 音乐路径变更
/**
 * @brief:  音乐路径变更
 *
 * @prama:musicFilePathStr
 *
 *@use: 比如切换歌曲
 */
-(void)setRecordSTCMusicFilePathStr:(NSString *)recordSTCMusicFilePathStr{
    //deal with recordMusicFilePathStr
    _recordSTCMusicFilePathStr = [self searchFullFilePathOfMusicFilePathStr:recordSTCMusicFilePathStr];
     [self musicSuperPlayerPlayWithMudicPathStr:_recordSTCMusicFilePathStr
                                     samplerate:MUSIC_SAMPLERATE];
    //默认加载后 就播放
    //[self setRecordSTCMusicPlayerState:YES];
}

-(void)setRecordSTCMusicPlayerState:(BOOL)recordSTCMusicPlayerState{
  
    if (!_superPlayer) {
        return;
    }
        if(recordSTCMusicPlayerState){
            //上面2个不管 状态如何都要走  下面切换 要根据播放器状态  因为第一次加载 获取的状态也是NO
            if (!_superPlayer->playing) {
                _superPlayer->togglePlayback();
                [_superHandles start];
            }
        }else{
            //暂停
            if(_superPlayer->playing){
//                _superPlayer->togglePlayback();
//                [_superHandles stop];
                _superPlayer->pause(0,0);
            }
        }
      _recordSTCMusicPlayerState = _superPlayer->playing;
    if (_recordSTCMusicPlayerState) {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryMultiRoute
                                               error:nil];
        //iOS 10下 音乐播放必须需要加
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord
                                               error:nil];
    }
}




#pragma mark - 音乐路径处理（L）
/**
 * @brief: 音乐路径处理,获取完整的音乐文件地址str
 *
 */
-(NSString*)searchFullFilePathOfMusicFilePathStr:(NSString *)musicFilePathStr
{
    NSString *str = [NSString stringWithFormat:@"/Documents/%@/%@",@"music",musicFilePathStr];
    if (str && ![str isEqualToString:@""]) {
        return [NSHomeDirectory() stringByAppendingString:str];
    }
    return NSHomeDirectory();
}
#pragma mark - 采样率变更
/**
 * @brief:  采样率变更
 *
 * @prama:samplerate
 *
 *@use: 采样率变更，但是目前固定44100
 */
-(void)setSamplerate:(int)samplerate{
    if (_samplerate!= samplerate) {
        _samplerate = samplerate;
    }
}


#pragma mark - C++销毁
/**
 * @brief: C++销毁
 *
 * @discussion: 到底销毁哪些。我也不是很清楚。毕竟对C++不了解。貌似没有主动销毁。到底销毁 这对象变量不？
 *
 @use:当这个单利销毁。那基本是杀死app时候。
 */
-(void)dealloc{
    if( _outDataBuffer )
        free( _outDataBuffer );
    
    if( _stereoBuffer )
        free( _stereoBuffer );
    
    if( _tempBuffer)
        free( _tempBuffer );
}

#pragma mark -音乐管理中心代理方法
//音乐加载
-(BOOL)showMusicPlayOfMusicPathStr:(NSString *)musicPathStr
                   ofSamplerateNum:(int)samplerateNum{
    return  [self musicSuperPlayerPlayWithMudicPathStr:musicPathStr
                                            samplerate:samplerateNum];
    
}
#pragma -音乐 播放 暂停
-(BOOL)musicStartOrStopPlayOfPlayingState:(BOOL)isPlayingSate{
    if (!_superPlayer) {
        // [FanweMessage alert:@"当前音乐播放器不存在"];
        return NO;
    }
    //需要 播放
    if(isPlayingSate){
        //上面2个不管 状态如何都要走  下面切换 要根据播放器状态  因为第一次加载 获取的状态也是NO
        if (!_superPlayer->playing) {
            _superPlayer->togglePlayback();
            [_superHandles start];
        }
    }else{
        //暂停
        if(_superPlayer->playing){
            _superPlayer->togglePlayback();
            [_superHandles stop];
        }
    }
    return _superPlayer->playing;
    
}

//音量大小这样的，，C++代理方法里，有函数方法把_recordSTCMusicPlyerOfBGMValue 加进去
-(void)setRecordSTCMusicPlyerOfBGMValue:(CGFloat)recordSTCMusicPlyerOfBGMValue{
    _recordSTCMusicPlyerOfBGMValue = recordSTCMusicPlyerOfBGMValue;
}
#pragma mark - 音调Value的调节
/**
 * @brief: 音调Value的调节
 *
 * @prama:pitchValue  必须int  -12 ~ 12
 *
 *@use:音效调节音调Value，数据代理传到音效界面，再代理传到播放器 通过单利赋值。内部在让C++播放器改变下就ok
 */

-(void)setRecordSTCMusicPlyerOfPitchValue:(CGFloat)recordSTCMusicPlyerOfPitchValue{
    if (_recordSTCMusicPlyerOfPitchValue>=-12&&_recordSTCMusicPlyerOfPitchValue<=12) {
         _recordSTCMusicPlyerOfPitchValue = recordSTCMusicPlyerOfPitchValue;
        if (_superPlayer != NULL) {
            _superPlayer->setPitchShift((int)_recordSTCMusicPlyerOfPitchValue);
        }
    }
}
#pragma mark - 音调Value的调节
/**
 * @brief: 音效效果 Value的调节
 *
 * @prama: selectEffectTag
 *
 *@discussion:总感觉设置木有意思。还不如让用户自己调节数据。 库里的音效效果比较怪里怪气的，应该处理音效效果滴。但是设计却要处理 高中低音，真是醉了
 *
 *@use:音效的效果类型调节
 */
-(void)setRecordSTCMusicPlyerOfEffectTypeValue:(CGFloat)recordSTCMusicPlyerOfEffectTypeValue{
    _recordSTCMusicPlyerOfEffectTypeValue = recordSTCMusicPlyerOfEffectTypeValue;
    if(_superBandEQ){
        //原声
        if((int)_recordSTCMusicPlyerOfEffectTypeValue == 0){
            self->_superBandEQ->bands[0] = 1.0f;
            self->_superBandEQ->bands[0] = 1.0f;
            self->_superBandEQ->bands[0] = 1.0f;
        }
        //悠扬
        if((int)_recordSTCMusicPlyerOfEffectTypeValue == 1){
            self->_superBandEQ->bands[0] = 1.0f;
            self->_superBandEQ->bands[0] = 1.5f;
            self->_superBandEQ->bands[0] = 1.5f;
        }
        //圆润
        if((int)_recordSTCMusicPlyerOfEffectTypeValue == 2){
            self->_superBandEQ->bands[0] = 1.5f;
            self->_superBandEQ->bands[0] = 1.5f;
            self->_superBandEQ->bands[0] = 1.0f;
        }
        //流行
        if((int)_recordSTCMusicPlyerOfEffectTypeValue == 3){
            self->_superBandEQ->bands[0] = 1.1f;
            self->_superBandEQ->bands[0] = 1.3f;
            self->_superBandEQ->bands[0] = 1.0f;
        }
        //轻松
        if((int)_recordSTCMusicPlyerOfEffectTypeValue == 4){
            self->_superBandEQ->bands[0] = 1.0f;
            self->_superBandEQ->bands[0] = 0.8f;
            self->_superBandEQ->bands[0] = 0.3f;
        }
        //空灵
        if((int)_recordSTCMusicPlyerOfEffectTypeValue == 5){
            self->_superBandEQ->bands[0] = 1.0f;
            self->_superBandEQ->bands[0] = 1.5f;
            self->_superBandEQ->bands[0] = 1.5f;
        }
        
    }
}


-(void)setDelegate:(id<STCMusicPlayerCenterManagerDelegate>)delegate{
    _delegate = delegate;
}




@end
