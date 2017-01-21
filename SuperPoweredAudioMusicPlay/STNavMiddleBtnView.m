//
//  STNavMiddleBtnView.m
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 17/1/21.
//  Copyright © 2017年 岳克奎. All rights reserved.
//

#import "STNavMiddleBtnView.h"
@implementation STNavMiddleBtnView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
#pragma mark - -------------------------  plubic methods
#pragma mark - new STThreeBtnView
/**
 * @brief: 创建 STThreeBtnView
 *
 *
 *
 */
+(STNavMiddleBtnView *)showSTNavMiddleBtnViewOnSuperView:(UIView *)superView
                                            andFrameRect:(CGRect)frameRect
                                                complete:(void(^)(BOOL finished,
                                                                  STNavMiddleBtnView *stNavMiddleBtnView))block{
    //superView
    if(!superView){
        if(block){
            block(YES,nil);
        }
        return nil;
    }
    //clear
    for (UIView *oneView in superView.subviews) {
        if ([oneView isKindOfClass:[self class]]) {
            [oneView removeFromSuperview];
        }
    }
    //new
    STNavMiddleBtnView *stNavMiddleBtnView = [[NSBundle mainBundle]loadNibNamed:@"STNavMiddleBtnView"
                                                                  owner:nil
                                                                options:nil][0];
    //recordSuperView
    stNavMiddleBtnView.recordSuperView = superView;
    //child
    [superView addSubview:stNavMiddleBtnView];
    //delegate
    stNavMiddleBtnView.stThreeBtnView.delegate = stNavMiddleBtnView;
    //block
    if (block) {
        block(YES,stNavMiddleBtnView);
    }
    //return
    return stNavMiddleBtnView;
}
#pragma mark - STThreeBtnViewDelegate
-(void)showSelectedOfSTThreeBtnView:(STThreeBtnView *)stThreeBtnView{
    if (_delegate && [_delegate respondsToSelector:@selector(showSelectOfSTNavMiddleBtnView:)]) {
        [_delegate showSelectOfSTNavMiddleBtnView:self];
    }
}
@end



















