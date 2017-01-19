//
//  STDoubleLRCLabShowView.h
//  FanweApp
//
//  Created by 岳克奎 on 17/1/12.
//  Copyright © 2017年 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class STLrcLab;
#import "XXNibBridge.h"
@interface STDoubleLRCLabShowView : UIView<XXNibBridge>

//@property (weak, nonatomic) IBOutlet STLrcLab *lrcUpLab;
//@property (weak, nonatomic) IBOutlet STLrcLab *lrcDowmLab;
@property (weak, nonatomic) IBOutlet STLrcLab *lrcUpLab;
@property (weak, nonatomic) IBOutlet STLrcLab *lrcDowmLab;

@property(weak,nonatomic)NSMutableArray       *lrcModelDataSoueceMArray;
@property(weak,nonatomic)NSMutableArray       *lrcTimePointDataMArray;
@property (nonatomic,assign) int              lineIndex;                     // 数组里的index
@property (nonatomic,assign) CGFloat          recordCurrentTime;             //记录当前时间
@property (nonatomic,assign) CGFloat          recordCurrentModelStartTime;   // 记录当前行model 的开始执行这行的起点时间
@property (nonatomic,assign) CGFloat          recordNextModelStartTime;      // 记录当下行model 的开始执行这行的起点时间
-(void)showMusicPlayerPlayingOfcurrentTime:(CGFloat)musicCurrentTime andMusicTotalTime:(CGFloat)musicTotalTime andMusicProgress:(CGFloat)msuicProgress;
@end
