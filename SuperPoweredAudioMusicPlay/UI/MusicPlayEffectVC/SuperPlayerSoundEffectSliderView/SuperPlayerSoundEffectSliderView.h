//
//  SuperPlayerSoundEffectSliderView.h
//  FanweApp
//
//  Created by 岳克奎 on 16/12/19.
//  Copyright © 2016年 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  SuperPlayerSoundEffectSliderViewDelage <NSObject>
@optional
-(void)accompanySliderHaveChangeValue:(CGFloat)accompanyValue;
-(void)voiceSliderHaveChangeValue:(CGFloat)voiceValue;
@end

@interface SuperPlayerSoundEffectSliderView : UIView<XXNibBridge>
@property (weak, nonatomic) IBOutlet UISlider *accompanySlider; //伴奏value调节slider
@property (weak, nonatomic) IBOutlet UISlider *voiceSlider;     //人声 Value调节Slider
@property(assign,nonatomic)id<SuperPlayerSoundEffectSliderViewDelage> deleagte;

@end
