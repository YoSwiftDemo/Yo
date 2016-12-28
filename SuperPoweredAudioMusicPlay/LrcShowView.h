//
//  LrcShowView.h
//  FanweApp
//
//  Created by 岳克奎 on 16/12/16.
//  Copyright © 2016年 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXNibBridge.h"
@interface LrcShowView : UIView <XXNibBridge>

@property (weak, nonatomic) IBOutlet LrcLabel *lrcUpLab;                    //上行歌词lab
@property (weak, nonatomic) IBOutlet LrcLabel *lrcDowmLab;                  //上行歌词lab
@property(strong,nonatomic)NSMutableArray    *lrcModelMArray;               // 歌词每行model 的数据源数组
@property(strong,nonatomic)NSMutableArray    *lrcTimePointMArray;           // 歌词每行model 的数据源数组
@property (nonatomic,assign) int             lineIndex;                     // 数组里的index
@property (nonatomic,assign) CGFloat         recordCurrentTime;             //记录当前时间
@property (nonatomic,assign) CGFloat         recordCurrentModelStartTime;   // 记录当前行model 的开始执行这行的起点时间
@property (nonatomic,assign) CGFloat         recordNextModelStartTime;      // 记录当下行model 的开始执行这行的起点时间
#pragma mark - 歌词lab数据更新
/**
 * @brief:歌词lab数据更新(C++player的代理不断向外传输数据)
 *
 * @use：在C++代理执行音乐管理中心的代理方法时候，让音乐管理中心把数据再传给对应的LrcView（C++控制器-->音乐管理中心-->UI层）
 */
-(void)setCurrentTime:(CGFloat)currentTime
       musicTotalTime:(CGFloat)totalTime
              present:(CGFloat)present;
@end
