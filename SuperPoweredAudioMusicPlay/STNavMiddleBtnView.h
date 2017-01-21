//
//  STNavMiddleBtnView.h
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 17/1/21.
//  Copyright © 2017年 岳克奎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STThreeBtnView.h"
@class STNavMiddleBtnView;
@protocol STNavMiddleBtnViewDelegate <NSObject>
@optional
-(void)showSelectOfSTNavMiddleBtnView:(STNavMiddleBtnView *)stNavMiddleBtnView;

@end
@interface STNavMiddleBtnView : UIView <STThreeBtnViewDelegate>
@property (weak, nonatomic) IBOutlet STThreeBtnView *stThreeBtnView;
@property(weak,nonatomic)id<STNavMiddleBtnViewDelegate>delegate;
@property(strong,nonatomic)UIView                   *recordSuperView;
@end
