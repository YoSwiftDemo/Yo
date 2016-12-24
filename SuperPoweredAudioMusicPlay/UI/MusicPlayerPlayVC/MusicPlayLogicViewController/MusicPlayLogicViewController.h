//
//  MusicPlayLogicViewController.h
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 16/12/23.
//  Copyright © 2016年 岳克奎. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MusicPlayUIViewController.h"
@interface MusicPlayLogicViewController : UIViewController
@property(nonatomic,strong)MusicPlayUIViewController       *recordMusicPlayUIViewController;          //记录子VC ui层
#pragma mark -life cycle ------------------------------------生 命 周 期 区 域 -----------------------------------
/**
 * @brief: 加载 承载音乐逻辑层的控制器  logic VC
 *
 * @discussion：父子关系 音乐VC>logic>UI
 *
 * @use:音乐播放器创建的同时，需要加载 承载音乐逻辑层的控制器
 */
+(void)showMusicPlayLogicViewControllerOnSuperViewController:(UIViewController *)superViewController
                                    LogicViewControllerFrame:(CGRect)LogicViewControllerFrame
                                                    complete:(void(^)(BOOL finished,MusicPlayLogicViewController *musicPlayLogicViewController))block;
@end
