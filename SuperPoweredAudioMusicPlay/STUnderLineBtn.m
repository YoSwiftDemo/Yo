//
//  STUnderLineBtn.m
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 17/1/21.
//  Copyright © 2017年 岳克奎. All rights reserved.
//

#import "STUnderLineBtn.h"

@implementation STUnderLineBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark ---------------------------------  setter/getter
-(void)setStUnderLineBtnSelectState:(STUnderLineBtnSelectState)stUnderLineBtnSelectState{
    _stUnderLineBtnSelectState = stUnderLineBtnSelectState;
    if (_delegate && [_delegate respondsToSelector:@selector(showSelectStateOfSTUnderLineBtn:)]) {
        [_delegate showSelectStateOfSTUnderLineBtn:self];
    }
}

#pragma mark - get  - tapGapGestureRecognizer
-(UITapGestureRecognizer *)tapGapGestureRecognizer{
    if (!_tapGapGestureRecognizer) {
        _tapGapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                          action:@selector(tapGapGestureRecognizerClick:)];
        _tapGapGestureRecognizer.delegate = self;
        [self addGestureRecognizer:_tapGapGestureRecognizer];
    }
    return _tapGapGestureRecognizer;
}
#pragma mark - private methods
#pragma mark - tap click
/**
 * @brief:点击自定义btn（）
 *
 *
 *
 */
-(void)tapGapGestureRecognizerClick:(UITapGestureRecognizer *)tapGapGestureRecognizer{
    //select
    [self setStUnderLineBtnSelectState:stUnderLineBtnSelected];
  
}
#pragma mark - system  delegate
#pragma mark - UIGestureRecognizer
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]&&[touch.view isKindOfClass:[self class]])?YES:NO;
}
@end
