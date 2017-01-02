//
//  MusicSuperPlayer.h
//  FanweApp
//
//  Created by 岳克奎 on 16/12/6.
//  Copyright © 2016年 xfg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol MusicSuperPlayerSendValueDelegate <NSObject>
@optional
-(void)senderCurrentSuperMusicPramaOftotalTimeValue:(CGFloat)musicTotalTime
                                   currentTimeValue:(CGFloat)currentTimeValue
                                currentPersentvalue:(CGFloat)currentPersentvalue;
@end

@interface MusicSuperPlayer : NSObject
{
@public
            uint64_t                                             maxUnitsPerSecond;                   //预留  这个库这一块我还没看懂呢
            uint64_t                                             avgUnitsPerSecond;                  //预留   后期扩展
}

@property(nonatomic,assign)int                                   samplerate;                         //采样率    这个更多的只是作为记录使用，便于重复播放
@property(nonatomic,assign)BOOL                                  superPlayerPlaying;                //记录 是否在播放
@property(nonatomic,strong)NSString                              *musicFilePathStr;                 //音乐路径 这个更多的只是作为记录使用
@property(nonatomic,assign) CGFloat                              accompanyValue;                    //C++播放器的音量（0-1.0f）
@property(nonatomic,assign) NSInteger                            pitchValue;                        //C++播放器的音调（-12-12）
@property(nonatomic,assign) NSInteger                            selectEffectTag;                   //C++播放器的 音效效果
@property(nonatomic,weak) id<MusicSuperPlayerSendValueDelegate>musicSuperPlayerSendValueDelegate; // 代理block 都可以
@property(nonatomic,copy)  void(^musicSuperPlayerInfoBlock)(CGFloat musicTotalTime,
                                                            CGFloat musicCurrentTime,
                                                            CGFloat MusicPersent);

@property(nonatomic,assign)int                                   recordCurrent;
#pragma mark -left cyle ---------------------------------------生 命 周 期 管 控 区 域 ---------------------------------------
+ (MusicSuperPlayer *)shareManager;
#pragma mark -public  methods ---------------------------------- 公 有 方 法 区 域 ------------------------------------------

#pragma mark -生成C++播放器并开启音乐播放器
/**
 *@brief：播放 某路径下 的音乐，并设置采样率
 *
 *@Step: 需要音乐处理器 开启
 */
-(BOOL)musicSuperPlayerPlayWithMudicPathStr:(NSString *)musicFilePathStr
                                 samplerate:(int)samplerate;
#pragma mark -player stop or resume 音乐播放器的 播放和暂停（混合功能）（Logic）
/**
 * @brief: 音乐播放器的 播放和暂停
 *
 * @discussion： 歌曲得暂停依旧通过音乐控制中心交互
 *
 * @return:  仅仅代表 目前调方法是否 执行得到对应的结果
 *
 * @use：1.播放过程，点击btn控制切换
 *       2.当直播退出时候，考虑音乐的暂停
 *  @discussion: 1. togglePlayback 本来就是单独使用（暂停and 播放），但是为啥不能单独用，我也不清楚啊.
 *               2. togglePlayback 能改变播放的状态 playing 而音乐处理器_superHandles 却不能改变
 *               3. _superHandles 能真正实现 播放 和暂停 但是却改变不了playing的状态 ，真是醉了
 *
 */
-(BOOL)musicSuperPlayerStopOrPlay;
#pragma mark- music play resume 音乐播放器 暂停 （单一功能）（Logic）
/**
 * @brief: 音乐播放暂停
 *
 * @return: YES:代表暂停操作成功 NO:代表操作失败
 *
 * @use: 只是单独需要 暂停
 */
-(BOOL)superPlayerStopPlaying;
#pragma mark- music play resume 音乐播放器恢复 （单一功能）（Logic）
/**
 * @brief: 音乐播放暂停后恢复播放
 *
 * @return: YES:代表暂停操作成功 NO:代表操作失败
 *
 * @use: 只是单独需要 暂停
 */
-(BOOL)superPlayerResumePlaying;
//copy 缓冲数据，推送至服务器
-(int)copyOutBuffer:(char*)buffer buffersize:(int)buffersize;
//-(void)copyMusicPlayDataToSDKHD2;
@end
