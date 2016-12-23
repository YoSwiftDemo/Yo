//
//  SuperPlayerSoundEffectVC.h
//  FanweApp
//
//  Created by 岳克奎 on 16/12/19.
//  Copyright © 2016年 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperPlayerSoundEffectTitleView.h"  //音效调节 标题栏View
#import "SuperPlayerSoundEffectSliderView.h" //音效调节 slider View
#import "SuperPlayerSoundEffectPitchView.h"  //音效调节 音调 View
#import "SuperPlayerSoundEffectBtnsView.h"   //音效调节 音效View
@protocol SuperPlayerSoundEffectVCDeleagte <NSObject>

@optional
// 人声 麦克风
-(void)changeMicValueByVoiceSliderOfValue:(CGFloat)micValue;
//伴奏
-(void)changeAccompanyValueByAccompanySliderOfValue:(CGFloat)accompanyValue;
//关闭 音效界面
//-(void)closeSuperPlayerSoundEffectViewController;
// 音调调节
-(void)changeSuperPlayerSoundEffectPitchValue:(NSInteger)pitchValue;
//音效类型调节
-(void)changeSuperPlayerBandEQOfSlectedBtnTag:(int)selectBtnTag;
@end
@interface SuperPlayerSoundEffectVC : UIViewController  <SuperPlayerSoundEffectTitleViewDelegate,
                                                         SuperPlayerSoundEffectSliderViewDelage,
                                                         SuperPlayerSoundEffectBtnsViewDeleagte,
                                                         SuperPlayerSoundEffectPitchViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *soundEffectBGView;       //音效调节背景view
@property (weak, nonatomic) IBOutlet SuperPlayerSoundEffectTitleView  *soundEffectTitleView;
@property (weak, nonatomic) IBOutlet SuperPlayerSoundEffectSliderView *soundEffectSliderView;
@property (weak, nonatomic) IBOutlet SuperPlayerSoundEffectPitchView  *soundEffectPitchView;
@property (weak, nonatomic) IBOutlet SuperPlayerSoundEffectBtnsView   *soundEffectBtnsView;

@property(assign,nonatomic)id<SuperPlayerSoundEffectVCDeleagte>delegate;
+(void)showSuperPlayerSoundEffectVCOnSuperView:(UIViewController *)superViewController
                                      complete:(void(^)(BOOL finished,SuperPlayerSoundEffectVC *effectVC))block;
@end



// 注意当请求失败  播放器依然启动！！！
