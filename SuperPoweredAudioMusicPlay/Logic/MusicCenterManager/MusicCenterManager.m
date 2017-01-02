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
#pragma mark - 加载音乐播放器界面(UI加载+音乐加载)
/**
 *  @brief:加载音乐播放器界面(UI加载)
 *
 *  @use:当点击btn或其他方式 加载音乐界面
 */
-(void)showMusicPlayerPlayViewControllerOnSuperViewController:(UIViewController *)superViewController
                                                  inSuperView:(UIView *)superView
                                           musicPlayerVCFrame:(CGRect)musicPlayerVCFrame
                                                     complete:(void(^)(BOOL finished,MusicPlayerPlayVC *musicPlayerPlayViewController))block{
        //UI加载  方法的具体实现应该在这个MusicPlayerPlayVC对应的m文件里面
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
                    musicFilePathStr:(NSString *)musicFilePathStr{
    //去音乐播放器 调加载音乐方法
    if(!musicFilePathStr){
        return;
    }
    // 加载的是 c++播放器
    [self.superPlayer musicSuperPlayerPlayWithMudicPathStr:musicFilePathStr
                                                samplerate:samplerateNum];
    // 后期再封装系统播放器
    // 必须加输出
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryMultiRoute error:nil];//多种输入输出，例如可以耳机、USB设备同时播放
    //iOS 10下 音乐播放必须需要加
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord
                                           error:nil];
    
}



#pragma mark- get+Set -------------------------------------------------- get+Se方法区域 --------------------------------------------------------
// superPlager  C++播放器管理中心
-(MusicSuperPlayer *)superPlayer{
    if (!_superPlayer) {
        _superPlayer = [MusicSuperPlayer shareManager];
    }
    return _superPlayer;
}
//musicDataManager 数据层管理中心
-(MusicDataManager *)musicDataManager{
    if (!_musicDataManager) {
        _musicDataManager = [MusicDataManager shareManager];
    }
    return _musicDataManager;
}

















@end
