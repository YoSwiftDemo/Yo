//
//  UIView+Animation.m
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 17/1/23.
//  Copyright © 2017年 岳克奎. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)
/**
 * @brief: 常用动画
 *
 */

-(void)st_animationType:(STAimationType)stAimationType
                      andScaleDuration:(CGFloat)scaleDuration
                       andRepeatCount:(STAimationRepeatCount)stAimationRepeatCount
                andRemoveOnCompletion:(BOOL)removedOnCompletion{
    
    // 创建动画组
    CAAnimationGroup *groups =[CAAnimationGroup animation];
    if (stAimationType == stAimationTypeTypeOfSaleSmallAndFull) {
        // 缩放 small 动画
        CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.duration = scaleDuration/3;
        scaleAnimation.repeatCount = stAimationRepeatCount;
        scaleAnimation.autoreverses = YES;
        scaleAnimation.fromValue = [NSNumber numberWithFloat:1.3];
        scaleAnimation.toValue   =[NSNumber numberWithFloat:0.01];
        
        
        //添加到动画组
        groups.animations = @[scaleAnimation];
    }
    //动画组设置
    groups.removedOnCompletion = removedOnCompletion;
    groups.fillMode = kCAFillModeForwards;
    groups.duration = scaleDuration;
    groups.repeatCount = stAimationRepeatCount;
    
    //开启动画
    [self.layer addAnimation:groups forKey:nil];
}


//-(void)st_animationOfSaleSmallFullandAnimationduration:(CGFloat)animationDuration
//                                        andRepeatCount:(STAimationRepeatCount)stAimationRepeatCount{
//    // 缩放 small 动画
//    CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    scaleAnimation.duration = animationDuration/3;
//    scaleAnimation.repeatCount = stAimationRepeatCount;
//    scaleAnimation.autoreverses = YES;
//    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.3];
//    scaleAnimation.toValue   =[NSNumber numberWithFloat:0.01];
//    
//}









/**
 *
 * [self.layer addAnimation:[self st_buttonSelectAimationTypeOfBreathLampGroupsAndAnimationDuration:animationDuration] forKey:nil];
 
 */
- (void)st_aimationTypeOfBreathLampGroupsAndAnimationDuration:(CGFloat)animationDuration  complete:(void(^)(BOOL finished))block{
    //
    self.userInteractionEnabled = NO;
    // 缩放动画
    CABasicAnimation * scaleAnim = [CABasicAnimation animation];
    scaleAnim.keyPath = @"transform.scale";
    scaleAnim.fromValue = @0.01;
    scaleAnim.toValue = @1;
    scaleAnim.duration = animationDuration;
    // 透明度动画
    CABasicAnimation *opacityAnim=[CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.fromValue= @0.01;
    opacityAnim.toValue= @1;
    opacityAnim.duration= animationDuration;
    // 创建动画组
    CAAnimationGroup *groups =[CAAnimationGroup animation];
    groups.animations = @[scaleAnim,opacityAnim];
    groups.removedOnCompletion = NO;
    groups.fillMode = kCAFillModeForwards;
    groups.duration = animationDuration;
    groups.repeatCount = 0;
    
    [self.layer addAnimation:groups forKey:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.userInteractionEnabled = YES;
        [self.layer removeAllAnimations];
    });
}
@end
