//
//  SuperPlayerSoundEffectPitchView.h
//  FanweApp
//
//  Created by 岳克奎 on 16/12/19.
//  Copyright © 2016年 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SuperPlayerSoundEffectPitchViewDelegate <NSObject>
@optional
-(void)changeSoundEffectOfPitchValue:(NSInteger)pitchValue;
@end
@interface SuperPlayerSoundEffectPitchView : UIView<XXNibBridge>
@property (weak, nonatomic) IBOutlet UIButton  *pitchAddBtn;     //音调 上调 btn
@property (weak, nonatomic) IBOutlet UIButton  *pitchRedue;      //音调 下调 btn
@property (weak, nonatomic) IBOutlet UILabel   *pitchValueShowLab;//音调 数据显示lab
@property(assign,nonatomic) NSInteger pitchInt;
@property(assign,nonatomic)id<SuperPlayerSoundEffectPitchViewDelegate> delegate;
@end
