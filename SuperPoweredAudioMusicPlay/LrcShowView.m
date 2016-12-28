//
//  LrcShowView.m
//  FanweApp
//
//  Created by 岳克奎 on 16/12/16.
//  Copyright © 2016年 xfg. All rights reserved.
//

#import "LrcShowView.h"

@implementation LrcShowView 

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark -self
/**
 *  @brief:LrcShowView 承载上下两行歌词
 *
 * @discussion： 1.歌词也算是数据吧。。所以简历数据层处理数据
 *
 */
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        //因没实力化，子控件要在from nib 写
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
}

#pragma mark - 歌词lab数据更新
/**
 * @brief:歌词lab数据更新(C++player的代理不断向外传输数据)
 *
 * @ prama : currentTime
 * @ prama : totalTime
 * @ prama :  presnet
 *
 * @discussion：1.小于 10行 的歌词 默认木有歌词  只是显示  歌曲信息
 *              2.不能每次都要去数据源找数据   当去取数据的时候，记录下当前行 开始时间+结束时间 每次依据这个判断 是不是要更新数据
 *              3.数据的取法： 根据当前时间 判断再哪一个 时间区间-->得到index-->直接取出对应的lrcModel -->更新记录+更新数据
 */
 dispatch_source_t timer;//开启定时器 赋值必须在定时器里
-(void)setCurrentTime:(CGFloat)currentTime
       musicTotalTime:(CGFloat)totalTime
              present:(CGFloat)present{
    // 默认歌词小于十行的，显示 歌手+歌曲 已经够意思了
    if (self.lrcModelMArray.count<10) {
        NSDictionary *dic = self.lrcTimePointMArray[0];
        if (![dic valueForKey:@"lrcContentStr"]) {
            self.lrcUpLab.text = dic[@"lrcContentStr"];
        }
        return;
    }
    //如果播放完毕。以为C++播放器的一直走，代理也一直走，导致这个方法也一直走。播放完毕销毁再重新建吧
    if (currentTime+1 >totalTime) {
        self.lineIndex = 0;
        self.recordCurrentTime = 0;
        self.recordCurrentModelStartTime = 0;
        self.recordNextModelStartTime = 0;
        if (timer) {
            dispatch_cancel(timer);
            timer = nil;
        }
        return;//结束
    }
    
    //记录 当前歌词进度的时间点
    __weak typeof(self)weak_Self = self;
    weak_Self.recordCurrentTime = present*totalTime;
    //开GCD定时器
    dispatch_queue_t queue =dispatch_get_main_queue();
    if (timer) {
        dispatch_cancel(timer);
        timer = nil;}
    timer =dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0, 0, queue);
    dispatch_time_t start =dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(0.01f *NSEC_PER_SEC);
    dispatch_source_set_timer(timer , start, interval,0);
    dispatch_source_set_event_handler(timer, ^{
    // 根据 下一次开始的时间  来判断 要不要执行更迭model  不能每次取数据 只有当前时间不在 当前行了，要去下一样，才去取数据
        // 当前时间 小于 下下一次开始时间
        if (weak_Self.recordNextModelStartTime>= weak_Self.recordCurrentTime) {
            // 当第一个model加载 进度  必定是上面lab
            // 某行 时间间隔
            float lineTotalTime =self.recordNextModelStartTime-weak_Self.recordCurrentModelStartTime;
            float linePlayTime =self.recordCurrentTime-weak_Self.recordCurrentModelStartTime;
            // 根据 lineIndex判断要显示上行还是下行，给lrcLab传入进度
                if (weak_Self.lineIndex%2==0) {
                    weak_Self.lrcUpLab.progress =  linePlayTime/lineTotalTime;
                }else{
                    weak_Self.lrcDowmLab.progress =  linePlayTime/lineTotalTime;
                }
        }else{
        //某行 数据的取法
            //判断当前的时间  是否 在 model 的区间里面        时间点我可以全部返回 回来
            for (int i = 0; i< _lrcTimePointMArray.count; i++) {
                CGFloat lrctimePoint = (CGFloat)[_lrcTimePointMArray[i] integerValue];
                // 注意 取到最后一个的时候，i+1是我自己加的，然后记录最后次数据没必要，因为最后一次不就是totalTime么
                CGFloat nextLrctimePoint;
                if(_lrcTimePointMArray.count-1 == i){
                    nextLrctimePoint = totalTime;
                }else{
                    nextLrctimePoint = (CGFloat)[_lrcTimePointMArray[i+1] integerValue];
                }
                if (weak_Self.recordCurrentTime>=lrctimePoint && weak_Self.recordCurrentTime< nextLrctimePoint) {
                    //符合时间段   得到index
                    self.lineIndex = i;
                    // 得到 正在播放区间
                    LrcModel *model =  weak_Self.lrcModelMArray[weak_Self.lineIndex];
                    LrcModel *nextModel = weak_Self.lrcModelMArray[weak_Self.lineIndex+1];

                    //记录下个开始的时间 当前model开始的时间
                    weak_Self.recordNextModelStartTime = (CGFloat)nextModel.lrcStartTimeStr.integerValue;
                    weak_Self.recordCurrentModelStartTime = (CGFloat)model.lrcStartTimeStr.integerValue;
                    
                    //确保一开始进度是0
                    weak_Self.lrcUpLab.progress = 0;
                    weak_Self.lrcDowmLab.progress = 0;
                    // 根据 lineIndex 判断。每次进来更新数据  要更新2行的数据，上下行都要更新 不要考虑下一行是否为空，数据源创建时候已经处理
                    if (weak_Self.lineIndex%2 == 0) {
                        weak_Self.lrcUpLab.text = model.lrcContentStr;
                        weak_Self.lrcDowmLab.text = nextModel.lrcContentStr;
                    }else{
                        weak_Self.lrcDowmLab.text = model.lrcContentStr;
                        weak_Self.lrcUpLab.text = nextModel.lrcContentStr;
                    }
                    return ;
                }

            }
        }
        if (totalTime == currentTime) {
            // 数据归0
            self.lineIndex = 0;
            self.recordCurrentTime = 0;
            self.recordCurrentModelStartTime = 0;
            self.recordNextModelStartTime = 0;
            //定时器销毁
            dispatch_cancel(timer);
             timer = nil;
        }
    });
    // 启动定时器 GO！Go！
    dispatch_resume(timer);
}

#pragma mark -  set/get
// 歌词每行model 的数据源数组
-(void)setLrcModelMArray:(NSMutableArray *)lrcModelMArray{
    _lrcModelMArray = lrcModelMArray;
}
//记录当前时间
-(void)setRecordCurrentTime:(CGFloat)recordCurrentTime{
    _recordCurrentTime = recordCurrentTime;
}
// 记录当前行model 的开始执行这行的起点时间
-(void)setRecordCurrentModelStartTime:(CGFloat)recordCurrentModelStartTime{
    _recordCurrentModelStartTime =recordCurrentModelStartTime;
}
 // 记录当下行model 的开始执行这行的起点时间
-(void)setRecordNextModelStartTime:(CGFloat)recordNextModelStartTime{
    _recordNextModelStartTime = recordNextModelStartTime;
}

@end
