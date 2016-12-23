//
//  MusicPlayUIViewController.m
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 16/12/23.
//  Copyright © 2016年 岳克奎. All rights reserved.
//

#import "MusicPlayUIViewController.h"

@interface MusicPlayUIViewController ()

@end

@implementation MusicPlayUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -life cycle ------------------------------------生 命 周 期 区 域 -----------------------------------

+(void)showMusicPlayUIViewControllerOnSuperViewController:(UIViewController *)superViewController
                                LogicViewControllerFrame:(CGRect)LogicViewControllerFrame
                                                complete:(void(^)(BOOL finished,MusicPlayUIViewController *musicPlayUIViewController))block{
    if (!superViewController) {
        if (block) {
            block(NO,nil);
        }
    }
    //创建新的逻辑层VC
    MusicPlayUIViewController *musicPlayUIViewController = [[MusicPlayUIViewController alloc]initWithNibName:@"MusicPlayUIViewController"
                                                                                                               bundle:nil];
    //添加到父视图上
    [superViewController addChildViewController:musicPlayUIViewController];
    //返回
    if (block) {
        block(YES,musicPlayUIViewController);
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
