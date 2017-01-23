//
//  STCMusicViewC.m
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 17/1/19.
//  Copyright © 2017年 岳克奎. All rights reserved.
//

#import "STCMusicViewC.h"

@interface STCMusicViewC ()

@end

@implementation STCMusicViewC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark ------------------------------------------------  delegate
/**
 * @brief:传入音乐信息model
 *
 * @discussion：1.处理UI变化
 *              2.传入C++播放器控制中心
 *
 */
-(void)sendDataForSTMusicViewCOfSTMusicModel:(STMusicModel *)stMusicModel{
    //拿到了数据 歌词路径传下去
    [ST_MUSIC_PLAYER_CENTER_MANAGER setRecordSTCMusicFilePathStr:stMusicModel.musicFilePathStr];
    if (_delegate &&[_delegate respondsToSelector:@selector(sendDataFromSTCMusicViewCToSTCMusicUIViewCOfSTMusicModel:)]) {
        [_delegate sendDataFromSTCMusicViewCToSTCMusicUIViewCOfSTMusicModel:stMusicModel];
    }
    //UI的变化继续传下去吧
    
    //    self.stMusicModel = stMusicModel;
    //    ST_MUSIC_PLAYER_CENTER_MANAGER.recordSTCMusicFilePathStr = stMusicModel.musicFilePathStr;
    //    self.stCMusicUIViewC.musicLrcShowView.lrcModelDataSoueceMArray = stMusicModel.lrcModelDataSourceArray;
    //    self.stCMusicUIViewC.musicLrcShowView.lrcTimePointDataMArray = stMusicModel.lrcTimePointDataArray;
    //    self.stCMusicUIViewC.musicInfoShowLab.text = [NSString stringWithFormat:@"%@ %@",[stMusicModel.musicNameStr isEmpty]?@"":stMusicModel.musicNameStr,[stMusicModel.musicSingerNameStr isEmpty]?@"":stMusicModel.musicSingerNameStr];
    
    //player  play new music
    //    __weak typeof(self)weak_Self = self;
    //    ST_MUSIC_PLAYER_CENTER_MANAGER.stCMusicPlayerCenterManagerBlock = ^(CGFloat stCMusicPlyerOfTotalTime,
    //                                                                        CGFloat stCMusicPlyerOfCurrentTime,
    //                                                                        CGFloat stCMusicPlyerOfALLProgress){
    //
    //        //surplus time
    //        weak_Self.stCMusicUIViewC.musicSurplusTimeValue = stCMusicPlyerOfTotalTime- stCMusicPlyerOfCurrentTime;
    //        [weak_Self.stCMusicUIViewC.musicLrcShowView showMusicPlayerPlayingOfcurrentTime:stCMusicPlyerOfCurrentTime
    //                                                                      andMusicTotalTime:stCMusicPlyerOfTotalTime
    //                                                                       andMusicProgress:stCMusicPlyerOfALLProgress];
    //    };
    //test
    
}
#pragma mark -
/**
 * @brief：调节音乐播放状态
 *
 * @prama: stMusicPlayerPlingState  音乐状态（播放+暂停）
 *
 *
 * @discussion:1.从子 logicViewC 拿到变化数据
 *             2.当播放器加载音乐ok并且播放成功后，才让驱动层的音乐状态改变
 *             3.
 *
 *
 */
// 音乐state
-(BOOL)sendForSTMusicViewCOfSTMusicPlayerPlayingState:(BOOL)stMusicPlayerPlingState{
    //需要调  音乐管理中心 状态属性管理 管理的结果返回给驱动层
    ST_MUSIC_PLAYER_CENTER_MANAGER.recordSTCMusicPlayerState = stMusicPlayerPlingState;
    //把最后得到的状态下传给UI层
    if (_delegate &&[_delegate respondsToSelector:@selector(sendDataFromSTCMusicViewCToSTCMusicUIViewCOfSTSMusicState:)]) {
        [_delegate sendDataFromSTCMusicViewCToSTCMusicUIViewCOfSTSMusicState:ST_MUSIC_PLAYER_CENTER_MANAGER.recordSTCMusicPlayerState ];
    }
    return ST_MUSIC_PLAYER_CENTER_MANAGER.recordSTCMusicPlayerState;
    
}

// 加载和 退出 C++音乐 界面
-(BOOL)sendDataForSTMusicViewCOfSTMusicViewCShowControllerState:(BOOL)stMusicViewCShowControllerState{
    //播放状态为 播放  进一步控制  外部走set方法
    ST_MUSIC_PLAYER_CENTER_MANAGER.recordSTCMusicPlayerState = stMusicViewCShowControllerState;
    //yes  open self
    if (stMusicViewCShowControllerState) {
        //animate
        self.view.layer.transform = CATransform3DMakeScale(1, 0.1, 1);
        self.view.x = 0;
        [UIView animateWithDuration:0.36
                         animations:^{
                             //                             self.view.x = 0;
                             self.view.layer.transform = CATransform3DMakeScale(1, 1, 1);
                         } completion:^(BOOL finished) {
                             
                         }];
    }else{
        //animate
        [UIView animateWithDuration:0.36
                         animations:^{
                             //                             self.view.x = SCREEN_WIDTH;
                             self.view.layer.transform = CATransform3DMakeScale(1, 0.01, 1);
                         } completion:^(BOOL finished) {
                             [self removeFromParentViewController];
                             [self.view removeFromSuperview];
                         }];
    }
    return stMusicViewCShowControllerState;

    
    
    return YES;
}
//音效调节显示和移除
-(BOOL)sendDataForSTMusicViewCOfShowSTMusicSoundEffectViewCState:(BOOL)showSTMusicEffectViewCState{
    //    //open
    //    if (showSTMusicEffectViewCState) {
    //        [STCMusicSEViewC showSTCMusicSEViewCOnSuperViewC:self.recordSuperViewC
    //                                            andFrameRect:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    //                                                complete:^(BOOL finished, STCMusicSEViewC *stCMusicSEViewC) {
    //                                                    //animate  load
    //                                                    stCMusicSEViewC.view.layer.transform = CATransform3DMakeScale(1, 0.001, 1);
    //                                                    [UIView animateWithDuration:0.36
    //                                                                     animations:^{
    //                                                                         stCMusicSEViewC.view.layer.transform = CATransform3DMakeScale(1, 1, 1);
    //                                                                     }
    //                                                                     completion:^(BOOL finished) {
    //
    //                                                                     }];
    //                                                    //child  logic
    //                                                    stCMusicSEViewC.recordSTMusicSELogicViewC =  [STMusicSELogicViewC showSTMusicSELogicViewCOnSuperViewC:stCMusicSEViewC
    //                                                                                                                                             andFrameRect:stCMusicSEViewC.view.frame
    //                                                                                                                                                 complete:^(BOOL finished, STMusicSELogicViewC *stMusicSELogicViewC) {
    //                                                                                                                                                     //deleagte
    //                                                                                                                                                 }];
    //                                                    //delegate
    //                                                    [stCMusicSEViewC.recordSTMusicSELogicViewC setDelegate:stCMusicSEViewC];
    //
    //                                                    [ST_MUSIC_CENTER_MANAGER setSeDelegate:stCMusicSEViewC.recordSTMusicSELogicViewC];
    //
    //                                                    stCMusicSEViewC.recordSTCMusicSEUIViewC =  [STCMusicSEUIViewC showSTCMusicSEUIViewCOnSuperView:stCMusicSEViewC
    //                                                                                                                                       ofFrameRect:stCMusicSEViewC.view.frame
    //                                                                                                                                          complete:^(BOOL finished, STCMusicSEUIViewC *stCMusicSEUIViewC) {
    //                                                                                                                                              //音效数据初始化  并不需要走 SDK  只是走UI
    //
    //                                                                                                                                              stCMusicSEUIViewC.stMusicSESliderView.micSlider.value = ST_MUSIC_CENTER_MANAGER.recordSEMicValue;
    //                                                                                                                                              stCMusicSEUIViewC.stMusicSESliderView.bgmSlider.value = ST_MUSIC_CENTER_MANAGER.recordSEBGMValue;
    //                                                                                                                                              stCMusicSEUIViewC.stMusicSESliderView.micValueShowLab.text = [NSString stringWithFormat:@"人声%.f%%",100*ST_MUSIC_CENTER_MANAGER.recordSEMicValue];
    //                                                                                                                                              stCMusicSEUIViewC.stMusicSESliderView.bgmValueShowLab.text = [NSString stringWithFormat:@"伴奏%.f%%",100*ST_MUSIC_CENTER_MANAGER.recordSEBGMValue];
    //                                                                                                                                              stCMusicSEUIViewC.stMusicSEPitchView.showPitchValueLab.text = [NSString stringWithFormat:@"%d",(int)ST_MUSIC_CENTER_MANAGER.recordSEPitchValue];
    //                                                                                                                                              for (UIButton *btn in   stCMusicSEUIViewC.stMusicSEEffectTypeView.effectBtnArray) {
    //                                                                                                                                                  if (btn.tag == (NSInteger)ST_MUSIC_CENTER_MANAGER.recordSEEffectTypeNum) {
    //                                                                                                                                                      btn.backgroundColor = [[UIColor  grayColor]colorWithAlphaComponent:0.2];
    //                                                                                                                                                  }else{
    //                                                                                                                                                      btn.backgroundColor = [UIColor whiteColor];
    //                                                                                                                                                  }
    //                                                                                                                                                  btn.layer.cornerRadius = btn.frame.size.width/2;
    //                                                                                                                                                  btn.layer.masksToBounds = YES;
    //                                                                                                                                              }
    //
    //                                                                                                                                          }];
    //
    //                                                }];
    //
    //
    //    }
    //    //cloase
    //    else{
    //        for (UIViewController *oneViewC in self.recordSuperViewC.childViewControllers) {
    //            if ([oneViewC isKindOfClass:[STCMusicSEViewC class]]) {
    //
    //                [UIView animateWithDuration:0.36
    //                                 animations:^{
    //                                     oneViewC.view.layer.transform = CATransform3DMakeScale(1, 0.001, 1);
    //                                 }
    //                                 completion:^(BOOL finished) {
    //                                     [oneViewC removeFromParentViewController];
    //                                     [oneViewC.view removeFromSuperview];
    //                                 }];
    //
    //
    //            }
    //        }
    //
    //    }
    //    return showSTMusicEffectViewCState;
    
    
    
    
    
    return YES;
}

#pragma mark --------------------------------------------- delegate of SE SDK
/**
 -------->Yun--->
 操作 SE UI层控件 子控件-- >delegate 变化数据传给父 SE UIViewC -->驱动层属性变化-->set-->delegate SE    logic
 -------->C++--->
 -->delegate Music Logic
 
 
 
 一定分清楚。同一个数据，发送到2个lodgic  在2个ViewC里执行。一个执行UI处理  一个执行SDK 不准超出自己职责。。处理UI就不准处理SDK 处理 别混了
 */
//SDK

//麦克风
-(void)sendDataForSTMusicViewCOfRecordSEMicValue:(CGFloat)recordSEMicValue{
    //    ST_MUSIC_PLAYER_CENTER_MANAGER.recordSTCMusicPlyerOfBGMValue
    
    NSLog(@"       暂 时 我 还 没 处 理        ");
}
//音乐伴奏
-(void)sendDataForSTMusicViewCOfRecordSEBGMValue:(CGFloat)recordSEBGMValue{
    // ST_MUSIC_PLAYER_CENTER_MANAGER.recordSTCMusicPlyerOfBGMValue = recordSEBGMValue;
    
}
//音调
-(void)sendDataForSTMusicViewCOfRecordSEPitchValue:(CGFloat)recordSEPitchValue{
    
    //ST_MUSIC_PLAYER_CENTER_MANAGER.recordSTCMusicPlyerOfPitchValue = recordSEPitchValue;
}
//音效类型
-(void)sendDataForSTMusicViewCOfRecordSEEffectTypeValue:(CGFloat)recordSEEffectTypeValue{
    //ST_MUSIC_PLAYER_CENTER_MANAGER.recordSTCMusicPlyerOfEffectTypeValue = recordSEEffectTypeValue;
}

#pragma mark -set/get
//-(UIViewController *)recordChildLogicViewC{
//    if (self.recordChildLogicViewC) {
//        self.recordChildLogicViewC = [STMusicLogicViewC showSTMusicLogicOnSuperViewC:self
//                                                                         ofFrameRect:CGRectMake(0, 0 , 100,200) newViewCNameStr:@"STMusicLogicViewC"
//                                                                            complete:^(BOOL finished,
//                                                                                       STMusicLogicBaseViewC *newViewC) {
//                                                                            }];
//    }
//    return self.recordChildLogicViewC;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
