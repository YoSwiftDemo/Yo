//
//  SuperPlayerSoundEffectVC.m
//  FanweApp
//
//  Created by 岳克奎 on 16/12/19.
//  Copyright © 2016年 xfg. All rights reserved.
//

#import "SuperPlayerSoundEffectVC.h"

@interface SuperPlayerSoundEffectVC ()<UIGestureRecognizerDelegate>

@end

@implementation SuperPlayerSoundEffectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}


#pragma mark - 代理方法
#pragma mark - 代理实现 恢复默认音效
-(void)resumeDefaultValueOfSoundEffectPrama{
    //恢复默认音效

        //伴奏Value
        self.soundEffectSliderView.accompanySlider.value = 0.5f;
        //人声Value
        self.soundEffectSliderView.voiceSlider.value = 1.0f;
        //pitchValueShowLab  音调归0
        self.soundEffectPitchView.pitchValueShowLab.text = @"0";
        // 音效

}
#pragma mark - 代理实现 音效 伴奏 更变
-(void)accompanySliderHaveChangeValue:(CGFloat)accompanyValue{
    self.soundEffectSliderView.accompanySlider.value = accompanyValue;
    if (self.delegate &&[self.delegate respondsToSelector:@selector(changeAccompanyValueByAccompanySliderOfValue:)]) {
        [self.delegate changeAccompanyValueByAccompanySliderOfValue:accompanyValue];
    }

}
#pragma mark - 实现 音效 人声 变更
-(void)voiceSliderHaveChangeValue:(CGFloat)voiceValue{
       self.soundEffectSliderView.voiceSlider.value = voiceValue;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(changeMicValueByVoiceSliderOfValue:)]) {
        [self.delegate changeMicValueByVoiceSliderOfValue:voiceValue];
    }
}
#pragma mark - 代理实现 音效效果 调节
-(void)changeEffectOfBtnTag:(int)selectedEffectBtnTag{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(changeSuperPlayerBandEQOfSlectedBtnTag:)]) {
        [self.delegate changeSuperPlayerBandEQOfSlectedBtnTag:selectedEffectBtnTag];
    }
}
#pragma mark - 代理实现  关闭 音效调节
-(void)closeSoundEffectViewController{
   [UIView animateWithDuration:1.0 animations:^{
       self.view.transform = CGAffineTransformMakeTranslation(0, SCREEN_HEIGHT);
   } completion:^(BOOL finished) {
       if (finished) {
           // 移除
           [self.view removeFromSuperview];
           [self removeFromParentViewController];
       }
   }];
}
#pragma mark - 代理实现 音调调节
-(void)changeSoundEffectOfPitchValue:(NSInteger)pitchValue{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(changeSuperPlayerSoundEffectPitchValue:)]) {
        [self.delegate changeSuperPlayerSoundEffectPitchValue:pitchValue];
    }
}


#pragma mark -public  methods  公有方法区域
#pragma mark -创建new 音效界面
+(void)showSuperPlayerSoundEffectVCOnSuperView:(UIViewController *)superViewController
                                                            complete:(void(^)(BOOL finished,SuperPlayerSoundEffectVC *effectVC))block{
    //创建 音效调节View
    SuperPlayerSoundEffectVC *effectVC =[[SuperPlayerSoundEffectVC alloc]initWithNibName:@"SuperPlayerSoundEffectVC"
                                                                                  bundle:nil];
    // 将音效View添加到直播间上
    [superViewController addChildViewController:effectVC];
    [superViewController.view addSubview:effectVC.view];
    [superViewController.view bringSubviewToFront:effectVC.view];
    //初始frame 放在屏幕下面
    effectVC.view.frame =CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    //代理  实现恢复默认音效
    effectVC.soundEffectTitleView.delegate = effectVC;
    //代理 slider 实现对 伴奏 人声 控制
    effectVC.soundEffectSliderView.deleagte = effectVC;
    //代理 音效btn 选择  音效效果
    effectVC.soundEffectBtnsView.delegate = effectVC;
    //代理 音调
    effectVC.soundEffectPitchView.delegate = effectVC;


    //动画加载
//    [UIView animateWithDuration:0.8
//                     animations:^{
//     effectVC.view.frame =CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT);
//        
//    }
//                     completion:^(BOOL finished) {
//    //动画完成后返回 effectVC
//                         if (finished&&block) {
//                             block(finished,effectVC);
//                         }
//        
//    }];
    if (block) {
        block(YES,effectVC);
    }
    
}
#pragma mark - 手势：处理只点击调节区域外地方，才tap退出音效调节
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch{
    if (![touch.view isDescendantOfView:self.soundEffectBGView]) {
        return YES;
    }
    return NO;
}
#pragma mark -private methods  私人方法区域
#pragma mark - 移除音效调节界面（UI）
- (IBAction)closeSoundEffectVCOfTapGesture:(UITapGestureRecognizer *)sender {
    // 移除
    [self closeSoundEffectViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
