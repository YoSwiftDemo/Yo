//
//  SuperPlayerSoundEffectBtnsView.m
//  FanweApp
//
//  Created by 岳克奎 on 16/12/19.
//  Copyright © 2016年 xfg. All rights reserved.
//

#import "SuperPlayerSoundEffectBtnsView.h"

@implementation SuperPlayerSoundEffectBtnsView

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
    for(UIButton *btn  in _btnsArray){
        btn.layer.cornerRadius = btn.frame.size.width/2.0f;
        btn.layer.masksToBounds = YES;
    }
}

- (IBAction)changeEffectBtnClick:(UIButton *)sender {
    //现把所有的btn 被禁颜色变一下
    for (UIButton *btn in _btnsArray) {
        btn.backgroundColor =[UIColor clearColor];
    }
    //背景颜色更变
    sender.backgroundColor = [UIColor orangeColor];
    // 要把tag 传走通过代理
    if(self.delegate&&[self.delegate respondsToSelector:@selector(changeEffectOfBtnTag:)]){
        [self.delegate changeEffectOfBtnTag:(int)sender.tag];
    }
}
#pragma mark -getters and setters - 属性的初始化，则交给getter去做
-(void)setSelectBtnTag:(int)selectBtnTag{
    _selectBtnTag = selectBtnTag;
    for( UIButton *btn in  _btnsArray) {
        if(btn.tag == selectBtnTag){
          btn.backgroundColor = [UIColor orangeColor];
            [btn setTintColor:[UIColor whiteColor]];
        }else{
                   [btn setTintColor:[UIColor blackColor]];
        }
    }
    // 要把 默认 tag 传走通过代理
    if(_delegate&&[_delegate respondsToSelector:@selector(changeEffectOfBtnTag:)]){
        [_delegate changeEffectOfBtnTag:_selectBtnTag];
    }
    NSLog(@"qweq -----gghggh----------- %d",selectBtnTag);
}

@end
