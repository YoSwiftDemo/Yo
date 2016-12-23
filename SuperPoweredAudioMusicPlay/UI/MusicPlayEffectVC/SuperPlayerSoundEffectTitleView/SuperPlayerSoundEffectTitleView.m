//
//  SuperPlayerSoundEffectTitleView.m
//  FanweApp
//
//  Created by 岳克奎 on 16/12/19.
//  Copyright © 2016年 xfg. All rights reserved.
//

#import "SuperPlayerSoundEffectTitleView.h"

@implementation SuperPlayerSoundEffectTitleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        //因没实力化，子控件要在from nib 写
        
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    
}
//
#pragma mark - 恢复默认的Value
- (IBAction)resumeDefaultValueBtnClick:(UIButton *)sender {
    if (self.delegate
        &&[self.delegate respondsToSelector:@selector(resumeDefaultValueOfSoundEffectPrama)]) {
        [self.delegate resumeDefaultValueOfSoundEffectPrama];
    
    }
}
#pragma mark -关闭 音效调节界面
- (IBAction)colseEffectVCBtnClick:(UIButton *)sender {
    if (self.delegate &&[self.delegate respondsToSelector:@selector(closeSoundEffectViewController)]) {
        [self.delegate closeSoundEffectViewController];
    }
    
}



@end
