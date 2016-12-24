//
//  MusicPlayerPlayVC.h
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 16/12/23.
//  Copyright © 2016年 岳克奎. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MusicPlayUIViewController.h"
#import "MusicPlayLogicViewController.h"
@interface MusicPlayerPlayVC : UIViewController
@property(nonatomic,strong)MusicPlayLogicViewController    *recordMusicPlayLogicViewController;       //记录子VC logic层   记着要比UI层先加，放在UI层下面

#pragma mark -  创建新的音乐播放VC
/**
 * @brief: 创建新的音乐播放VC
 *
 * @prama: superViewController
 * @prama: superView
 * @prama: musicPlayerVCFrame
 * @prama: blcok
 *
 * @discussion: 1. superViewController == nil     superView == nil         --》rootVC
 *             2. superViewController ！= nil     superView == nil         -->子VC 子View 归属于同一个父VC
 *             3.  2. superViewController ！= nil superView ！= nil         --> 因为logic下的子VC是UI层，可以把View放到UI层VC，VC放到logic层VC
 *
 *
 * @use: 控制中心需要加载音乐播放VC
 */
+(void)showMusicPlayerPlayVCOnSuperViewController:(UIViewController *)superViewController
                                      inSuperView:(UIView *)superView
                               musicPlayerVCFrame:(CGRect)musicPlayerVCFrame
                                         complete:(void(^)(BOOL finished,
                                                           MusicPlayerPlayVC *musicPlayerPlayViewController))block;
@end
