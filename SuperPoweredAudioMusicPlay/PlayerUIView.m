//
//  PlayerUIView.m
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 16/12/27.
//  Copyright © 2016年 岳克奎. All rights reserved.
//

#import "PlayerUIView.h"

@implementation PlayerUIView
#pragma mark -life cycle -----------------------------------控 制 生 命 周 期 区 域 ---------------------------------
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        //因没实力化，子控件要在from nib 写
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
}
#pragma mark -evebt response --------------------------------- 事件响应区域 -----------------------------------------
#pragma mark -音效调节
/**
 * @brief:音效调节（弹出音效控制界面）
 *
 * @dicussion:
 *
 */
- (IBAction)effectAdjustBtn:(UIButton *)sender {
    if(self.delegate&&[self.delegate respondsToSelector:@selector(showSoundEffectViewcontrollerWithPlayerUIView:)]){
        [self.delegate showSoundEffectViewcontrollerWithPlayerUIView:self];
    }
}
#pragma mark - 音乐关闭
/**
 * @brief: 音乐关闭
 *
 * @dicussion:
 *
 */
- (IBAction)closeMusicClick:(UIButton *)sender {
    if(self.delegate&&[self.delegate respondsToSelector:@selector(closeMusicPlayandUIWithPlayerUIView:)]){
        [self.delegate closeMusicPlayandUIWithPlayerUIView:self];
    }
}
#pragma mark -
/**
 * @brief:
 *
 * @dicussion:
 *
 */
- (IBAction)resumeOrPasueMusicClick:(UIButton *)sender {
    
}

#pragma mark -音乐音量调节
/**
 * @brief: 音乐音量调节
 *
 * @dicussion:
 *
 */
- (IBAction)bgmSliderValeChange:(UISlider *)sender {
    if(self.delegate &&[self.delegate respondsToSelector:@selector(changeMusicControlSliderValueWithPlayerUIView:bgmValue:micValue:)]){
        // 感觉也可以直接用slider
        [self.delegate changeMusicControlSliderValueWithPlayerUIView:self
                                                            bgmValue:self.recordBGMValue
                                                            micValue:self.recordMicValue];
    }
}
#pragma mark -
/**
 * @brief:
 *
 * @dicussion:
 *
 */
- (IBAction)micSliderValueChange:(UISlider *)sender {
}
#pragma mark -
/**
 * @brief:
 *
 * @dicussion:
 *
 */
- (IBAction)progressSliderValueChange:(UISlider *)sender {
}
#pragma mark- get+Set -------------------------------------------------- get+Se方法区域 ---------------------------------------------------
//音乐音量变化 0-1.0f
-(void)setRecordBGMValue:(CGFloat)recordBGMValue{
    _recordBGMValue = recordBGMValue;
}
//音乐麦克风变化0-1.0f
-(void)setRecordMicValue:(CGFloat)recordMicValue{
    _recordMicValue = recordMicValue;
}
//音乐进度大小变化0-1.0f
-(void)setRecordProgressValue:(CGFloat)recordProgressValue{
    _recordProgressValue = recordProgressValue;
}
@end
