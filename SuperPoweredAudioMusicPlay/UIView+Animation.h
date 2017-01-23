//
//  UIView+Animation.h
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 17/1/23.
//  Copyright © 2017年 岳克奎. All rights reserved.
//

#import <UIKit/UIKit.h>
#pragma mark - aniamtion type
typedef NS_ENUM(NSUInteger,STAimationType) {
    stAimationTypeOfDefault                             = 0,      //无动画
    stAimationTypeTypeOfBreathLamp                 = 1,      //呼吸灯效果
    stAimationTypeTypeOfSaleSmallAndFull           = 2,      //先缩小再恢复
} ;
#pragma mark - aniamtion repeatCount
typedef NS_ENUM(NSUInteger,STAimationRepeatCount) {
    stAimationRepeatCountDeault                    = 1,       //0
    stAimationRepeatCountTwo                       = 2,       //2
    stAimationRepeatCountThree                     = 3,       //3
    stAimationRepeatCountMax                       =NSIntegerMax , //无限次数
} ;
@interface UIView (Animation)
/**
 * @brief: 常用动画
 *
 */

-(void)st_animationType:(STAimationType)stAimationType
                      andSaleDuration:(CGFloat)saleDuration
                       andRepeatCount:(STAimationRepeatCount)stAimationRepeatCount
                andRemoveOnCompletion:(BOOL)removedOnCompletion;

- (void)st_aimationTypeOfBreathLampGroupsAndAnimationDuration:(CGFloat)animationDuration  complete:(void(^)(BOOL finished))block;
@end
