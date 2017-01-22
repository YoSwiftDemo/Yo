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
                                                                                            ofFrameRect:CGRectMake(0, 0 ,SCREEN_WIDTH,200)
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
 
    stCMusicViewC.recordChildLogicViewC = stCMusicUIViewC;
    //delegate
    stCMusicViewC.delegate = stCMusicUIViewC;
    [ST_MUSIC_PLAYER_CENTER_MANAGER setDelegate:stCMusicUIViewC];

    //第一步：处理lrc，生成音乐model
    //拿到歌词str 转为数据源数组
    NSString *lrcFilePath = [[NSBundle mainBundle]pathForResource:@"10405520" ofType:@"lrc"];
    NSString *lrcContent = [NSString stringWithContentsOfFile:lrcFilePath encoding:NSUTF8StringEncoding error:nil];
    
    NSMutableDictionary *musicModelMDic = @{@"musicNameStr":@"传奇",
                                            @"musicSingerNameStr":@"王菲",
                                            @"musicLrcContentDataStr":[[NSBundle mainBundle]pathForResource:@"10405520" ofType:@"lrc"],
                                            @"musicFilePathStr":@"音乐路径播放器暂时用的测试数据",
                                            @"lrcModelDataSourceArray": [[lrcContent st_parsingLrcStr] valueForKey:@"lrcModelDataSourceArray"],
                                            @"lrcTimePointDataArray":[[lrcContent st_parsingLrcStr] valueForKey:@"lrcTimePointDataArray"]}.mutableCopy;
    //STMusicModel
    STMusicModel *stMusicModel =[STMusicModel mj_objectWithKeyValues:musicModelMDic];
    //第二步 驱动层处理
    [ST_MUSIC_CENTER_MANAGER setMusicModel:stMusicModel];
    
    [ST_MUSIC_PLAYER_CENTER_MANAGER setRecordSTCMusicPlayerState:YES];
    
    if(ST_MUSIC_PLAYER_CENTER_MANAGER.recordSTCMusicPlayerState){
        NSLog(@"播放成功");
    }else{
          NSLog(@"播放失败");
    }
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


@end

















