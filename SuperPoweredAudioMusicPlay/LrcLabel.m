//
//  LrcLabel.m
//  FanweApp
//
//  Created by 岳克奎 on 16/12/16.
//  Copyright © 2016年 xfg. All rights reserved.
//

#import "LrcLabel.h"

@implementation LrcLabel
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
    [LRC_RENDER_COLOR set]; 
    CGRect fillRect = CGRectMake(0, 0, self.bounds.size.width * self.progress, self.bounds.size.height);
    UIRectFillUsingBlendMode(fillRect, kCGBlendModeSourceIn);
}

@end
