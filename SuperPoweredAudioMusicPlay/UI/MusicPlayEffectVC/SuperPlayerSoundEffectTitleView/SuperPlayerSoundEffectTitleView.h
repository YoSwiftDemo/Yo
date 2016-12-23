//
//  SuperPlayerSoundEffectTitleView.h
//  FanweApp
//
//  Created by 岳克奎 on 16/12/19.
//  Copyright © 2016年 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SuperPlayerSoundEffectTitleViewDelegate <NSObject>

@optional
//恢复默认音效
-(void)resumeDefaultValueOfSoundEffectPrama;
//关闭 音效调节界面
-(void)closeSoundEffectViewController;
@end
@interface SuperPlayerSoundEffectTitleView : UIView<XXNibBridge>

@property (weak, nonatomic) IBOutlet UIButton *resumeDefaultValueBtn;   //恢复默认btn
@property (weak, nonatomic) IBOutlet UILabel  *effectTitleLab;          // 音效调节标题lab
@property (weak, nonatomic) IBOutlet UIButton *closeEffectBtn;         // 关闭音效调节的 btn
#pragma mark - 恢复默认音效
/**
 * @brief: 恢复默认音效
 *
 *
 * @discussion:现在只是恢复 音乐的伴奏 人声      pitch？ effect?
 
 *
 */
@property(assign,nonatomic)id<SuperPlayerSoundEffectTitleViewDelegate> delegate;


@end
