//
//  SuperPlayerSoundEffectPitchView.m
//  FanweApp
//
//  Created by 岳克奎 on 16/12/19.
//  Copyright © 2016年 xfg. All rights reserved.
//

#import "SuperPlayerSoundEffectPitchView.h"

@implementation SuperPlayerSoundEffectPitchView

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
#pragma mark - 音调调节
- (IBAction)pitchValueChangeBtnClick:(UIButton *)sender {
    if(sender.tag == 0){//add
        if ( self.pitchInt <12) {
            self.pitchInt = self.pitchInt +1;
        }
    }
    if(sender.tag == 1){//reduce
        if (self.pitchInt>-12) {
            self.pitchInt = self.pitchInt -1;
        }
    }
     self.pitchValueShowLab.text = [NSString stringWithFormat:@"%ld",(long)self.pitchInt];
   //
    if (self.delegate&&[self.delegate respondsToSelector:@selector(changeSoundEffectOfPitchValue:)]) {
        [self.delegate changeSoundEffectOfPitchValue:self.pitchInt];
    }
}
-(void)setPitchInt:(NSInteger)pitchInt{
    _pitchInt = pitchInt;
    //
    _pitchValueShowLab.text = [NSString stringWithFormat:@"%ld",(long)_pitchInt];
    //处理默认数据
    if (_delegate&&[_delegate respondsToSelector:@selector(changeSoundEffectOfPitchValue:)]) {
        [_delegate changeSoundEffectOfPitchValue:_pitchInt];
    }
}
@end
