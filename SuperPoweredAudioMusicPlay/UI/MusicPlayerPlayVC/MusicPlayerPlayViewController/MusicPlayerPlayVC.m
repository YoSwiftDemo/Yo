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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -life cycle ------------------------------ 生 命 周 期 管 控 区 域 ------------------------------------------
-(void)showMusicPlayerPlayVCOnSuperViewController:(UIViewController *)superViewController
                                      inSuperView:(UIView *)superView
                               musicPlayerVCFrame:(CGRect)musicPlayerVCFrame
                                         complete:(void(^)(BOOL finished,MusicPlayerPlayVC *musicPlayerPlayViewController))block{
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
    //如果作为单独一块容器
    if (!superViewController&&!superView) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        delegate.window.rootViewController =  [[UINavigationController alloc]initWithRootViewController:musicPlayerPlayViewController];
    }
    // 加载子VC   logic  和 UI
    
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
