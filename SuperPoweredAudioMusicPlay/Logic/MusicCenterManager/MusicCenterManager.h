//
//  MusicCenterManager.h
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 16/12/23.
//  Copyright © 2016年 岳克奎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicCenterManager : NSObject
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

@end
