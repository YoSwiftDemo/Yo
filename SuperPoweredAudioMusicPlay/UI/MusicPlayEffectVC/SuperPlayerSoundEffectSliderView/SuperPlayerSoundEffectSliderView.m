//
//  SuperPlayerSoundEffectSliderView.m
//  FanweApp
//
//  Created by 岳克奎 on 16/12/19.
//  Copyright © 2016年 xfg. All rights reserved.
//

#import "SuperPlayerSoundEffectSliderView.h"

@implementation SuperPlayerSoundEffectSliderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    // UI的变更写在这里，为啥不能写上面改天研究下
    _accompanySlider.transform = CGAffineTransformMakeRotation(-M_PI/2);
    _voiceSlider.transform = CGAffineTransformMakeRotation(-M_PI/2);
}
#pragma mark -伴奏Value改变
- (IBAction)accompanyChangeValueClick:(UISlider *)sender {
    if (self.deleagte &&[self.deleagte respondsToSelector:@selector(accompanySliderHaveChangeValue:)]) {
        [self.deleagte accompanySliderHaveChangeValue:sender.value];
    }
}
#pragma mark -人生Value改变
- (IBAction)voiceValueChangeClick:(UISlider *)sender {
    if (self.deleagte&&[self.deleagte respondsToSelector:@selector(voiceSliderHaveChangeValue:)]) {
        [self.deleagte voiceSliderHaveChangeValue:sender.value];
    }
}


@end
