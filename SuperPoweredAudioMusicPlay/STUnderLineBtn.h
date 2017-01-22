//
//  STUnderLineBtn.h
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 17/1/21.
//  Copyright © 2017年 岳克奎. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, STUnderLineBtnSelectState) {
    
    stUnderLineBtnSelected   = 0,
    stUnderLineBtnUnSelected = 1,
};
@class STUnderLineBtn;
@protocol STUnderLineBtnDelegate <NSObject>
@required
@optional
-(void)showSelectStateOfSTUnderLineBtn:(STUnderLineBtn *)stUnderLineBtn;
@end
@interface STUnderLineBtn : UIView<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *showTitleLab;

@property (weak, nonatomic) IBOutlet UILabel *underLineLab;

//tap
@property(strong,nonatomic)UITapGestureRecognizer *tapGapGestureRecognizer;

//delegate
@property(weak,nonatomic)id<STUnderLineBtnDelegate>delegate;
//select sate
@property(assign,nonatomic)STUnderLineBtnSelectState stUnderLineBtnSelectState;
@end
