//
//  MusicCenterManager.m
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 16/12/23.
//  Copyright © 2016年 岳克奎. All rights reserved.
//

#import "MusicCenterManager.h"

@implementation MusicCenterManager



#pragma mark -life cycle ------------------------------ 生 命 周 期 管 控 区 域 ------------------------------------------
/**
 * @brief: 单利
 *
 * @discussion:我的想法是，用单利管理，以后把DataModel里面的操作都移除出来、、关于music的数据层单独成模块。放在msuic大分类里。这样看着就合理
 */
static MusicCenterManager *signleton = nil;
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        signleton = [super allocWithZone:zone];
    });
    return signleton;
}
+ (MusicCenterManager *)shareManager
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


#pragma mark -------------------------------------- 音乐 UI 控 制 区域 ----------------------------------------------------
#pragma mark -MusicDataManager 单利
/**
 *  @brief:MusicDataManager 单利
 *
 *  @use:找到brief:MusicDataManager
 */
-(void)showMusicPlayerPlayViewControllerOnSuperViewController:(UIViewController *)superViewController
                                                  inSuperView:(UIView *)superView
                                           musicPlayerVCFrame:(CGRect)musicPlayerVCFrame
                                                     complete:(void(^)(BOOL finished,MusicPlayerPlayVC *musicPlayerPlayViewController))block{
        [MusicPlayerPlayVC showMusicPlayerPlayVCOnSuperViewController:superViewController
                                                          inSuperView:superView
                                                   musicPlayerVCFrame:musicPlayerVCFrame
                                                             complete:^(BOOL finished,
                                                                        MusicPlayerPlayVC *musicPlayerPlayViewController) {
                                                                 if (block) {
                                                                     block(finished,musicPlayerPlayViewController);
                                                                 }
    
        }];
    
}
@end
