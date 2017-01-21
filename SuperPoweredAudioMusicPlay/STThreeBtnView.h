//
//  STThreeBtnView.h
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 17/1/21.
//  Copyright © 2017年 岳克奎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STUnderLineBtn.h"
@class STThreeBtnView;
typedef NS_ENUM(NSUInteger, STThreeBtnViewSelectedBtn) {
    selectLeftBtnView   = 0,
    selectMiddleBtnView = 1,
    selectRightBtnView  = 1,
};
@protocol STThreeBtnViewDelegate <NSObject>

@optional
-(void)showSelectedOfSTThreeBtnView:(STThreeBtnView *)stThreeBtnView;

@end
@interface STThreeBtnView : UIView<STUnderLineBtnDelegate>
//left
@property (weak, nonatomic) IBOutlet STUnderLineBtn  *leftBtnView;
//middle
@property (weak, nonatomic) IBOutlet STUnderLineBtn  *middleBtnView;
//right
@property (weak, nonatomic) IBOutlet STUnderLineBtn  *rightBtnView;

@property(strong,nonatomic)UIView                    *recordSuperView;

@property(assign,nonatomic)STThreeBtnViewSelectedBtn stThreeBtnViewSelectedBtn;
//
@property(strong,nonatomic)UIViewController          *recordSuperViewC;
//deleagte
@property(weak,nonatomic)id<STThreeBtnViewDelegate>delegate;
@end
