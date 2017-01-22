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
    
    //加载
    STCMusicViewC *stCMusicViewC = (STCMusicViewC *)[STCMusicViewC showSTMusicFunctionViewCOnSuperViewC:self
                                                                                            ofFrameRect:CGRectMake(0, 0 , 100,200)
                                                                                        newViewCNameStr:@"STCMusicViewC"
                                                                                               complete:^(BOOL finished, STMusicBaseViewC *newViewC) {
                                                                                               }];
    //childViewC logicViewC
    STMusicLogicViewC *stMusicLogicViewC = (STMusicLogicViewC *)[STMusicLogicViewC showSTMusicLogicOnSuperViewC:stCMusicViewC
                                                                                                    ofFrameRect:CGRectMake(0, 0 , 100,200) newViewCNameStr:@"STMusicLogicViewC"
                                                                                                       complete:^(BOOL finished,
                                                                                                                  STMusicLogicBaseViewC *newViewC) {
                                                                                                           
    stCMusicViewC.recordChildLogicViewC = stMusicLogicViewC;                                                                                                    }];
    //lodic delegate
    [stMusicLogicViewC setDelegate:stCMusicViewC];
    [ST_MUSIC_CENTER_MANAGER setDelegate:stMusicLogicViewC];
    
    //childViewC UI
    STCMusicUIViewC *stCMusicUIViewC=  (STCMusicUIViewC*) [STCMusicUIViewC showSTMusicFunctionViewCOnSuperViewC:stCMusicViewC
                                                                                                    ofFrameRect:stCMusicViewC.view.frame
                                                                                                newViewCNameStr:@"STCMusicUIViewC"
                                                                                                       complete:^(BOOL finished,
                                                                                                                  STMusicUIBaseViewC *newViewC) {
                                                                                                           
                                                                                                                                                                                            }];
     stCMusicUIViewC.view.tag = 10002;
    stCMusicViewC.recordChildLogicViewC = stCMusicUIViewC;
//    [stCMusicUIViewC setDelegate:stCMusicViewC];
    
    //music  mdoel 需要的基本数据
    ST_MUSIC_CENTER_MANAGER.musicBaseSimpleInfoDic = @{@"musicNameStr":@"音乐名称",
                                                       @"musicSingerNameStr":@"歌手名称",
                                                       @"musicLrcContentDataStr":@"歌词",
                                                       @"musicFilePathStr":@"音乐路径"};
    //music stat play
    if (  ST_MUSIC_CENTER_MANAGER.musicPlayerPlayingState) {
        //open msuic ViewC with animate
        ST_MUSIC_CENTER_MANAGER.musicViewCShowControllerState = YES;
    }else{
        NSLog(@"无法加载音乐");
    }
   //push   && add
    ST_MUSIC_PLAYER_CENTER_MANAGER.recordSTCMusicFilePathStr = @"21312312";
    [ST_MUSIC_PLAYER_CENTER_MANAGER setRecordSTCMusicPlayerState:YES];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


@end

















