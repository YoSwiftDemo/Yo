//
//  SuperPlayerSoundEffectBtnsView.h
//  FanweApp
//
//  Created by 岳克奎 on 16/12/19.
//  Copyright © 2016年 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SuperPlayerSoundEffectBtnsViewDeleagte <NSObject>
@optional
-(void)changeEffectOfBtnTag:(int)selectedEffectBtnTag;
@end
@interface SuperPlayerSoundEffectBtnsView : UIView<XXNibBridge>
@property (weak, nonatomic) IBOutlet UIView                        *soundEffectBtnsView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnsArray;
@property(assign,nonatomic) int                                    selectBtnTag;
@property(assign,nonatomic) id<SuperPlayerSoundEffectBtnsViewDeleagte>delegate;
@end
