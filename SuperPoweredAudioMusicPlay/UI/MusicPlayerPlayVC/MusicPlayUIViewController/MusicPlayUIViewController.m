//
//  MusicPlayUIViewController.m
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 16/12/23.
//  Copyright © 2016年 岳克奎. All rights reserved.
//

#import "MusicPlayUIViewController.h"
#import "MusicSuperPlayer.h"
@interface MusicPlayUIViewController ()<MusicSuperPlayerSendValueDelegate>

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
#pragma mark -public  methods ------------------------------------------ 公有方法区域  -----------------------------------------
#pragma mark -  加载 承载音乐UI层的控制器  UI VC
/**
 * @brief: 加载 承载音乐UI层的控制器  UI VC
 *
 * @prama: superViewController           音乐logic VC----->MusicPlayLogicViewController
 * @prama: LogicViewControllerFrame
 * @prama: finished
 * @prama: musicPlayUIViewController
 *
 * @discussion：父子关系 音乐VC>logic>UI
 *
 * @use:音乐lodicVC创建的同时，需要加载 承载音乐UI层的控制器
 */
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
    [superViewController.view addSubview:musicPlayUIViewController.view];
    //frme
    musicPlayUIViewController.view.frame = LogicViewControllerFrame;
    
    
    
    // 因为播放器管理中心是个单利 ，所以他的代理方法 通过单利  直接找调度中心把
    MusicCenterManager *musicCenterManager = [MusicCenterManager shareManager];
    __weak MusicPlayUIViewController *weak_musicUIVC = musicPlayUIViewController;
    musicCenterManager.superPlayer.musicSuperPlayerSendValueDelegate = weak_musicUIVC;   //代理写成self 报错  可以研究下
    musicCenterManager.superPlayer.musicSuperPlayerInfoBlock = ^(CGFloat musicTotalTime,
                                                                 CGFloat musicCurrentTime,
                                                                 CGFloat MusicPersent){
             // 把播放器的信息 给功能View 上的子控件
         //总时间 这些数据总是需要开启定时器才行
        weak_musicUIVC.playerFunctionUIView.totalTimeLab.text = [NSString stringWithFormat:@"%.f",musicTotalTime];
        weak_musicUIVC.playerFunctionUIView.currentTimeLab.text = [NSString stringWithFormat:@"%f",musicCurrentTime];
        weak_musicUIVC.playerFunctionUIView.progressSlider.value = MusicPersent;
        NSLog(@"eqewqew-----------------------------------------------------------------------");
        
        
        
    };
    
    
    
    //返回
    if (block) {
        block(YES,musicPlayUIViewController);
    }
    
}
-(void)senderCurrentSuperMusicPramaOftotalTimeValue:(CGFloat)musicTotalTime
                                   currentTimeValue:(CGFloat)currentTimeValue
                                currentPersentvalue:(CGFloat)currentPersentvalue{
    
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
