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
@end
@interface PlayerUIView : UIView
@property (weak, nonatomic) IBOutlet UIButton *effectAdjustBtn;    //音效调节btn
@property (weak, nonatomic) IBOutlet UIButton *closeMusicBtn;     //关闭整个音乐盒界面
@property (weak, nonatomic) IBOutlet UIButton *controlMusicBtn;   // 控制播放暂停

@end
