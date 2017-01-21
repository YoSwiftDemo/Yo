//
//  STThreeBtnView.m
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 17/1/21.
//  Copyright © 2017年 岳克奎. All rights reserved.
//

#import "STThreeBtnView.h"

@implementation STThreeBtnView

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
+(STThreeBtnView *)showSTThreeBtnViewOnSuperView:(UIView *)superView
                                    andFrameRect:(CGRect)frameRect
                                        complete:(void(^)(BOOL finished,STThreeBtnView *stThreeBtnView))block{
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
    STThreeBtnView *stThreeBtnView = [[NSBundle mainBundle]loadNibNamed:@"STThreeBtnView"
                                                                  owner:nil
                                                                options:nil][0];
    //recordSuperView
    stThreeBtnView.recordSuperView =superView;
    //add
    [superView addSubview:stThreeBtnView];
    //deleagte
    stThreeBtnView.leftBtnView.delegate   = stThreeBtnView;
    stThreeBtnView.middleBtnView.delegate = stThreeBtnView;
    stThreeBtnView.rightBtnView.delegate  = stThreeBtnView;
    //block
    if (block) {
        block(YES,stThreeBtnView);
    }
    //return
    return stThreeBtnView;

}
#pragma mark -subView  custom delegate
-(void)showSelectStateOfSTUnderLineBtn:(STUnderLineBtn *)stUnderLineBtn{
  //tag  0 1 3
 
}
#pragma mark ------------------------  getter/setter
-(void)setStThreeBtnViewSelectedBtn:(STThreeBtnViewSelectedBtn)stThreeBtnViewSelectedBtn{
    _stThreeBtnViewSelectedBtn = stThreeBtnViewSelectedBtn;
    if (_delegate &&[_delegate respondsToSelector:@selector(showSelectedOfSTThreeBtnView:)]) {
        [_delegate showSelectedOfSTThreeBtnView:self];
    }
    
}














@end
