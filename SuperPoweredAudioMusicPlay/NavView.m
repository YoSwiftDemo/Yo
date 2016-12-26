//
//  NavView.m
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 16/12/26.
//  Copyright © 2016年 岳克奎. All rights reserved.
//

#import "NavView.h"

@implementation NavView

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
@end
