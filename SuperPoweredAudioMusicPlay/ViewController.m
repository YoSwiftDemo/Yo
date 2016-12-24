//
//  ViewController.m
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 16/12/23.
//  Copyright © 2016年 岳克奎. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 去音乐管理中心调加载音乐播放功能界面的代码
    [[MusicCenterManager shareManager] showMusicPlayerPlayViewControllerOnSuperViewController:nil
                                                                                  inSuperView:nil
                                                                           musicPlayerVCFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                                                                                     complete:^(BOOL finished,
                                                                                                MusicPlayerPlayVC *musicPlayerPlayViewController) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
