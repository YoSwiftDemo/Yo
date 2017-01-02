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
    
    
    
    //一般是这样的。去音乐选择界面，选择了音乐Model，把音乐的一切信息通过block回调。。加载这里，然后启动音乐的UI加载+音乐的播放
    // 去音乐管理中心调加载音乐播放功能界面的代码
     __weak MusicCenterManager *musicCenterManager = [MusicCenterManager shareManager];
    [musicCenterManager showMusicPlayerPlayViewControllerOnSuperViewController:nil
                                                                   inSuperView:nil
                                                            musicPlayerVCFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                                                                      complete:^(BOOL finished,
                                                                    MusicPlayerPlayVC *musicPlayerPlayViewController) {
                                                                    //音乐UI加载完成后，开始启动音乐的加载
                                                                          [musicCenterManager showSuperMusicOfSamplerateNum:MUSIC_SAMPLERATE
                                                                                                           musicFilePathStr:@""];
                                                                          
                                                                                         
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
