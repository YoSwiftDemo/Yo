//
//  MusicPlayUIViewController.h
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 16/12/23.
//  Copyright © 2016年 岳克奎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavView.h"
#import "PlayerUIView.h"
@interface MusicPlayUIViewController : UIViewController 
@property (weak, nonatomic) IBOutlet NavView        *navView;
@property (weak, nonatomic) IBOutlet PlayerUIView   *playerFunctionUIView;

#pragma mark -public  methods ------------------------------------------ 公有方法区域  -----------------------------------------
#pragma mark -  加载 承载音乐UI层的控制器  UI VC
/**
 * @brief: 加载 承载音乐UI层的控制器  UI VC
 *
 * @discussion：父子关系 音乐VC>logic>UI
 *
 * @use:音乐lodicVC创建的同时，需要加载 承载音乐UI层的控制器
 */
+(void)showMusicPlayUIViewControllerOnSuperViewController:(UIViewController *)superViewController
                                 LogicViewControllerFrame:(CGRect)LogicViewControllerFrame
                                                 complete:(void(^)(BOOL finished,MusicPlayUIViewController *musicPlayUIViewController))block;
@end
