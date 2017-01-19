//
//  STLrcLab.m
//  FanweApp
//
//  Created by 岳克奎 on 17/1/12.
//  Copyright © 2017年 xfg. All rights reserved.
//

#import "STLrcLab.h"

@implementation STLrcLab

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - 当前这一行歌词的 进度
/**
* @brief: 当前这一行歌词的 进度
 *
 * @prama: progress 0 - 1.0
 *
 */
- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    //绘图  调用drawRect方法
    [self setNeedsDisplay];
}
#pragma mark - 当前这一行歌词的 进度
/**
 * @brief: 歌词根据进度逐字渲染
 *
 * @prama: rect
 *
 */
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    // 绿色
    [[UIColor blueColor] set];
    CGRect fillRect = CGRectMake(0, 0, self.bounds.size.width * self.progress, self.bounds.size.height);
    UIRectFillUsingBlendMode(fillRect, kCGBlendModeSourceIn);
}

@end
