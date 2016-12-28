//
//  LrcLabel.h
//  FanweApp
//
//  Created by 岳克奎 on 16/12/16.
//  Copyright © 2016年 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LrcLabel : UILabel
/**
 * @brief: 当前某行歌词播放进度
 
 * @prama:progress （0-1）
 *
 * @use: 某一行歌词的进度传入进来  逐字播放
 *
 * @discussion:某一行的进度。因为要渲染歌词 从左到右
 *
 */
@property (nonatomic,assign) CGFloat progress;
@end
