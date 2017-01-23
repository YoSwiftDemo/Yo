//
//  STDoubleLRCLabShowView.m
//  FanweApp
//
//  Created by 岳克奎 on 17/1/12.
//  Copyright © 2017年 xfg. All rights reserved.
//

#import "STDoubleLRCLabShowView.h"

@implementation STDoubleLRCLabShowView


-(void)showMusicPlayerPlayingOfcurrentTime:(CGFloat)musicCurrentTime
                         andMusicTotalTime:(CGFloat)musicTotalTime
                          andMusicProgress:(CGFloat)msuicProgress{
    
    
//    NSLog(@"---------%f -----------------%f----------------------- %f ",musicCurrentTime,musicTotalTime,msuicProgress);
//    
//    NSLog(@"----%ld -----------%ld",_lrcTimePointDataMArray.count,_lrcModelDataSoueceMArray.count);
    
    
    //  least 10 lines lyrics
    if (self.lrcModelDataSoueceMArray.count<10) {
        NSDictionary *dic = self.lrcTimePointDataMArray[0];
        if (![dic valueForKey:@"lrcContentStr"]) {
            self.lrcUpLab.text = dic[@"lrcContentStr"];
        }
        return;
    }
    //如果播放完毕。以为C++播放器的一直走，代理也一直走，导致这个方法也一直走。播放完毕销毁再重新建吧
    if (musicCurrentTime+1 >musicTotalTime) {
        self.lineIndex = 0;
        self.recordCurrentTime = 0;
        self.recordCurrentModelStartTime = 0;
        self.recordNextModelStartTime = 0;
        return;//结束
    }
    //记录 当前歌词进度的时间点
    __weak typeof(self)weak_Self = self;
    weak_Self.recordCurrentTime = msuicProgress*musicTotalTime;
        // 根据 下一次开始的时间  来判断 要不要执行更迭model  不能每次取数据 只有当前时间不在 当前行了，要去下一样，才去取数据
        // 当前时间 小于 下下一次开始时间
        if (weak_Self.recordNextModelStartTime>= weak_Self.recordCurrentTime) {
            // 当第一个model加载 进度  必定是上面lab
            // 某行 时间间隔
            float lineTotalTime =self.recordNextModelStartTime-weak_Self.recordCurrentModelStartTime;
            float linePlayTime =self.recordCurrentTime-weak_Self.recordCurrentModelStartTime;
            // 根据 lineIndex判断要显示上行还是下行，给lrcLab传入进度
            //dispatch_sync(dispatch_get_main_queue(), ^{
            if (weak_Self.lineIndex%2==0) {
                weak_Self.lrcUpLab.progress =  linePlayTime/lineTotalTime;
            }else{
                weak_Self.lrcDowmLab.progress =  linePlayTime/lineTotalTime;
            }
          // });
        }else{
            //某行 数据的取法
            //判断当前的时间  是否 在 model 的区间里面        时间点我可以全部返回 回来
            for (int i = 0; i< _lrcTimePointDataMArray.count; i++) {
                CGFloat lrctimePoint = (CGFloat)[_lrcTimePointDataMArray[i] integerValue];
                // 注意 取到最后一个的时候，i+1是我自己加的，然后记录最后次数据没必要，因为最后一次不就是totalTime么
                CGFloat nextLrctimePoint;
                if(_lrcTimePointDataMArray.count-1 == i){
                    nextLrctimePoint = musicTotalTime;
                }else{
                    nextLrctimePoint = (CGFloat)[_lrcTimePointDataMArray[i+1] integerValue];
                }
                if (weak_Self.recordCurrentTime>=lrctimePoint && weak_Self.recordCurrentTime< nextLrctimePoint) {
                    //符合时间段   得到index
                    self.lineIndex = i;
                    // 得到 正在播放区间
                    STMusicLrcModel  *model =  weak_Self.lrcModelDataSoueceMArray[weak_Self.lineIndex];
                    STMusicLrcModel *nextModel = weak_Self.lrcModelDataSoueceMArray[weak_Self.lineIndex+1];
                    
                    //记录下个开始的时间 当前model开始的时间
                    weak_Self.recordNextModelStartTime = (CGFloat)nextModel.lrcStartTimeStr.integerValue;
                    weak_Self.recordCurrentModelStartTime = (CGFloat)model.lrcStartTimeStr.integerValue;
                    
                 
                    // 根据 lineIndex 判断。每次进来更新数据  要更新2行的数据，上下行都要更新 不要考虑下一行是否为空，数据源创建时候已经处理
                    //dispatch_sync(dispatch_get_main_queue(), ^{
                        //确保一开始进度是0
                        weak_Self.lrcUpLab.progress = 0;
                        weak_Self.lrcDowmLab.progress = 0;
                        if (weak_Self.lineIndex%2 == 0) {
                            weak_Self.lrcUpLab.text = model.lrcContentStr;
                            weak_Self.lrcDowmLab.text = nextModel.lrcContentStr;
                        }else{
                            weak_Self.lrcDowmLab.text = model.lrcContentStr;
                            weak_Self.lrcUpLab.text = nextModel.lrcContentStr;
                        }
                    //});
                  
                    return ;
                }
                
            }
        }
        if (musicCurrentTime+2 >musicTotalTime) {
            // 数据归0
            self.lineIndex = 0;
            self.recordCurrentTime = 0;
            self.recordCurrentModelStartTime = 0;
            self.recordNextModelStartTime = 0;

        }


}
@end
