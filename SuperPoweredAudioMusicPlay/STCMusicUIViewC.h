//
//  STCMusicUIViewC.h
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 17/1/19.
//  Copyright © 2017年 岳克奎. All rights reserved.
//

#import "STMusicUIBaseViewC.h"
#import "STDoubleLRCLabShowView.h"
@interface STCMusicUIViewC : STMusicUIBaseViewC<STCMusicViewCDeleagte,STCMusicPlayerCenterManagerDelegate>
@property (weak, nonatomic) IBOutlet UIButton               *musicSoundEffectBtn;
@property (weak, nonatomic) IBOutlet UIButton               *musicCloseBtn;
@property (weak, nonatomic) IBOutlet UIButton               *musicControlStateBtn;
@property (weak, nonatomic) IBOutlet UILabel                *musicInfoShowLab;
@property (weak, nonatomic) IBOutlet UILabel                *musicSurplusTimeShowLab;
@property (weak, nonatomic) IBOutlet STDoubleLRCLabShowView *musicLrcShowView;
@property(assign,nonatomic) CGFloat                         musicSurplusTimeValue;
@end
