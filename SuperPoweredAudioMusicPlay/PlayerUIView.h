//
//  PlayerUIView.h
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 16/12/27.
//  Copyright © 2016年 岳克奎. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlayerUIView;//一半写代理方法最好自个嫩进取，以备不时之需
@protocol PlayerUIViewDeleagte <NSObject>
@optional
//音效调节btn  调出   最好Vc改成View吧  暂时没改
-(void)showSoundEffectViewcontrollerWithPlayerUIView:(PlayerUIView *)playerUIView ;
//关闭音乐
-(void)closeMusicPlayandUIWithPlayerUIView:(PlayerUIView *)playerUIView;
//播放恢复和暂停
-(void)changeMusicPlayOfresumeOrWithPlayerUIView:(PlayerUIView *)playerUIView;
// sldier 数据更变 最好 合并在一起 SDK里基本用到时候用一对，很骚单独用
-(void)changeMusicControlSliderValueWithPlayerUIView:(PlayerUIView *)playerUIView bgmValue:(CGFloat)bgmValue  micValue:(CGFloat)micValue;

@end
//桥接
@interface PlayerUIView : UIView<XXNibBridge>

@property (weak, nonatomic) IBOutlet UIButton *effectAdjustBtn;    //音效调节btn
@property (weak, nonatomic) IBOutlet UIButton *closeMusicBtn;      //关闭整个音乐盒界面
@property (weak, nonatomic) IBOutlet UIButton *controlMusicBtn;    // 控制播放暂停
@property (weak, nonatomic) IBOutlet UISlider *bgmSlider;          //音乐 音量slider
@property (weak, nonatomic) IBOutlet UISlider *micSlider;          //麦克风 slider
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;     //歌曲进度Slider
@property (weak, nonatomic) IBOutlet UILabel  *singerLab;          //歌手名lab
@property (weak, nonatomic) IBOutlet UILabel  *musicNameLab;       //歌曲名
@property (weak, nonatomic) IBOutlet UILabel  *totalTimeLab;       //总时间lab
@property (weak, nonatomic) IBOutlet UILabel  *currentTimeLab;     //当前时间lab
@property (weak, nonatomic) IBOutlet UIView   *lrcView;            //承载上下歌词的歌词View
@property(assign,nonatomic)CGFloat            recordBGMValue;      //记录背景音乐 音量0-1.0f
@property(assign,nonatomic)CGFloat            recordMicValue;      //记录麦克风 音量0-1.0f
@property(assign,nonatomic)CGFloat            recordProgressValue; //记录音乐进度 音量0-1.0f
@property (weak,nonatomic) id<PlayerUIViewDeleagte>delegate;       //代理

#pragma mark -public  methods ------------------------------------------ 公有方法区域  -----------------------------------------

@end
