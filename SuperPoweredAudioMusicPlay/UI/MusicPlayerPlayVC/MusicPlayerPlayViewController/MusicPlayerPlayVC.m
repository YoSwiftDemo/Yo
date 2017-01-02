//
//  MusicPlayerPlayVC.m
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 16/12/23.
//  Copyright © 2016年 岳克奎. All rights reserved.
//

#import "MusicPlayerPlayVC.h"

@interface MusicPlayerPlayVC ()

@end

@implementation MusicPlayerPlayVC
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -life cycle ------------------------------ 生 命 周 期 管 控 区 域 ------------------------------------------
#pragma mark -  创建新的音乐播放VC
/**
 * @brief: 创建新的音乐播放VC
 *
 * @prama: superViewController
 * @prama: superView
 * @prama: musicPlayerVCFrame
 * @prama: blcok
 *
 * @discussion: 1. superViewController == nil     superView == nil         --》rootVC
 *             2. superViewController ！= nil     superView == nil         -->子VC 子View 归属于同一个父VC
 *             3.  2. superViewController ！= nil superView ！= nil         --> 因为logic下的子VC是UI层，可以把View放到UI层VC，VC放到logic层VC
 *
 *
 * @use: 控制中心需要加载音乐播放VC
 */
+(void)showMusicPlayerPlayVCOnSuperViewController:(UIViewController *)superViewController
                                      inSuperView:(UIView *)superView
                               musicPlayerVCFrame:(CGRect)musicPlayerVCFrame
                                         complete:(void(^)(BOOL finished,
                                                           MusicPlayerPlayVC *musicPlayerPlayViewController))block{
    if(superViewController){
        for (UIViewController *oneViewController in superViewController.childViewControllers) {
            if ([oneViewController isKindOfClass:[MusicPlayerPlayVC class]]) {
                //移除
                [oneViewController removeFromParentViewController];
                [oneViewController.view removeFromSuperview];
            }
        }
    }
    //创建新的musicPlayerPlayViewController
    MusicPlayerPlayVC *musicPlayerPlayViewController = [[MusicPlayerPlayVC alloc]initWithNibName:@"MusicPlayerPlayVC"
                                                                                                   bundle:nil];
    //frame
    musicPlayerPlayViewController.view.frame =musicPlayerVCFrame;
    //加载到superViewController
    if (superViewController) {
        [superViewController addChildViewController:musicPlayerPlayViewController];
    };
    //加载到superView
    if (superView) {
        [superView addSubview:musicPlayerPlayViewController.view];
    }
    //加载逻辑层
    __weak MusicPlayerPlayVC *weak_musicPlayerPlayViewController = musicPlayerPlayViewController;
    [MusicPlayLogicViewController showMusicPlayLogicViewControllerOnSuperViewController:musicPlayerPlayViewController
                                                               LogicViewControllerFrame:musicPlayerPlayViewController.view.frame
                                                                               complete:^(BOOL finished,
                                                                                          MusicPlayLogicViewController *musicPlayLogicViewController) {
                                                                                     //记录逻辑层
                                                                                   if (finished&&musicPlayLogicViewController) {
                                                                                       weak_musicPlayerPlayViewController.recordMusicPlayLogicViewController = musicPlayLogicViewController;
                                                                                
                                                                                   }
                                                                                   
        
    }];
    //如果作为单独一块容器
    if (!superViewController&&!superView) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UINavigationController *nav =  [[UINavigationController alloc]initWithRootViewController:musicPlayerPlayViewController];
        delegate.window.rootViewController =  nav;
        nav.navigationBar.hidden = YES;
    }
    //blcok
    if(block){
        block(YES,musicPlayerPlayViewController);
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
