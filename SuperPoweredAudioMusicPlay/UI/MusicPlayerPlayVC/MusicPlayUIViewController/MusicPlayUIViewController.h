//
//  MusicPlayUIViewController.h
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 16/12/23.
//  Copyright © 2016年 岳克奎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicPlayUIViewController : UIViewController
#pragma mark -life cycle ------------------------------------生 命 周 期 区 域 -----------------------------------

+(void)showMusicPlayUIViewControllerOnSuperViewController:(UIViewController *)superViewController
                                 LogicViewControllerFrame:(CGRect)LogicViewControllerFrame
                                                 complete:(void(^)(BOOL finished,MusicPlayUIViewController *musicPlayUIViewController))block;
@end
