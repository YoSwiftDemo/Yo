//
//  MusicCenterManager.h
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 16/12/23.
//  Copyright © 2016年 岳克奎. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicSuperPlayer.h"
#import "MusicDataManager.h"
@interface MusicCenterManager : NSObject

@property(nonatomic,strong)MusicSuperPlayer *superPlayer;         //C++播放器控制中心

@property(nonatomic,strong)MusicDataManager *musicDataManager;     //音乐数据处理中心

#pragma mark -life cycle ------------------------ 生 命 周 期 区 域 -----------------------------------

#pragma mark -MusicDataManager 单利
/**
 *  @brief:MusicDataManager 单利
 *
 *  @use:找到brief:MusicDataManager
 */
+ (MusicCenterManager *)shareManager;

#pragma mark -------------------------------------- 音乐 UI 控 制 区域 -------------------------------------------
#pragma mark -MusicPlayerPlayVC 音乐播放界面
/**
 *  @brief:MusicPlayerPlayVC 音乐播放界面
 *
 *  @use:展示音乐播放界面
 */
-(void)showMusicPlayerPlayViewControllerOnSuperViewController:(UIViewController *)superViewController
                                                  inSuperView:(UIView *)superView
                                           musicPlayerVCFrame:(CGRect)musicPlayerVCFrame
                                                     complete:(void(^)(BOOL finished,MusicPlayerPlayVC *musicPlayerPlayViewController))block;
#pragma mark - 启动音乐（采样率+音乐路径）
/**
 * @brief: 启动音乐（采样率+音乐路径）
 *
 * @prama: samplerateNum       采样率 44100 和48000   最好用44100，因为人耳朵识别上限是这个，然而用了48000 导致直播等会卡的很
 * @prama: musicFilePathStr
 *
 *  @use: 启动音乐
 */
-(void)showSuperMusicOfSamplerateNum:(int)samplerateNum
                    musicFilePathStr:(NSString *)musicFilePathStr;
@end
