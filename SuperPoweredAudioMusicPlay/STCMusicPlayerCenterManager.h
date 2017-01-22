//
//  STCMusicPlayerCenterManager.h
//  FanweApp
//
//  Created by 岳克奎 on 17/1/16.
//  Copyright © 2017年 xfg. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol STCMusicPlayerCenterManagerDelegate <NSObject>
@optional
-(void)sendDataFromSTCMusicPlayerCenterManagerToSTMusicUIViewCOfMusicTotalDuration:(CGFloat)musicTotalDuration
                                                           andMusicCurrentDuration:(CGFloat)musicCurrentDuration
                                                                  andMusicProgress:(CGFloat)musicProgress;
@end
@interface STCMusicPlayerCenterManager : NSObject
{
@public
    uint64_t                                                      maxUnitsPerSecond;                      //预留  这个库这一块我还没看懂呢
    uint64_t                                                      avgUnitsPerSecond;                      //预留   后期扩展
}
@property(nonatomic,assign)int                                     samplerate;                            //采样率    这个更多的只是作为记录使用，便于重复播放
@property(nonatomic,strong)NSString                                *recordSTCMusicFilePathStr;            //音乐路径 只是配置音乐参数 数据
@property(nonatomic,assign)BOOL                                    recordSTCMusicPlayerState;             //农房控制  播放  暂停
@property(nonatomic,copy)  void(^stCMusicPlayerCenterManagerBlock)(CGFloat stCMusicPlyerOfTotalTime,
                                                                   CGFloat stCMusicPlyerOfCurrentTime,
                                                                   CGFloat stCMusicPlyerOfALLProgress);

@property(nonatomic,assign) CGFloat                                recordSTCMusicPlyerOfBGMValue;          //音乐 C++播放器的音量 音量 0-1.0f）
@property(nonatomic,assign) CGFloat                                recordSTCMusicPlyerOfPitchValue;        //C++播放器的 音效效果
@property(nonatomic,assign) CGFloat                                recordSTCMusicPlyerOfEffectTypeValue;   //音乐 音量
//delegate
@property(nonatomic,weak)id<STCMusicPlayerCenterManagerDelegate>delegate;



#pragma mark -left cyle ---------------------------------------生 命 周 期 管 控 区 域
+ (STCMusicPlayerCenterManager *)shareManager;
#pragma mark -public  methods ---------------------------------- 公 有 方 法 区 域

//copy 缓冲数据，推送至服务器
-(int)copyOutBuffer:(char*)buffer buffersize:(int)buffersize;
@end
