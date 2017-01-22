//
//  STMusicCenterManager.m
//  FanweApp
//
//  Created by 岳克奎 on 17/1/12.
//  Copyright © 2017年 xfg. All rights reserved.
//

#import "STMusicCenterManager.h"

@implementation STMusicCenterManager
#pragma mark -------------------------------------life cycle -------------------------------------
#pragma mark - 音乐控制中  单利
/**
 * @brief: 音乐控制中 单利
 *
 * @discussion:我的想法是，用单利管理，这样能够通过C++的player对应的控制器来控制。播放，暂停。如果不这样，需要频繁的
 */
static STMusicCenterManager *signleton = nil;
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        signleton = [super allocWithZone:zone];
    });
    return signleton;
}
+ (STMusicCenterManager *)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        signleton = [[self alloc] init];
    });
    return signleton;
}
+ (id)copyWithZone:(struct _NSZone *)zone
{
    return signleton;
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return signleton;
}
#pragma mark ------------------------------------ set/get ---------------------------------------
#pragma mark -
/**
 * @brief:      音乐播放状态（播放+暂停）
 *
 * @prama:      musicPlayerPlayingState  期望的音乐状态  YES  播放  NO暂停
 *
 * @discussion: 1.一定是给了model，再设置音乐状态
 *              2.
 *
 * @ Function: 驱动层属性变化，set下发数据，logic作为公有层。负责从驱动层接数据。
 */
-(void)setMusicPlayerPlayingState:(BOOL)musicPlayerPlayingState{
    if (_delegate &&[_delegate respondsToSelector:@selector(sendDataForSTMusicLogicViewCSTMusicPlayerPlayingState:)]) {
      _musicPlayerPlayingState= [_delegate sendDataForSTMusicLogicViewCSTMusicPlayerPlayingState:musicPlayerPlayingState];
    }
}
//model
-(void)setMusicModel:(STMusicModel *)musicModel{
       _musicModel = musicModel;
    if(_delegate &&[_delegate respondsToSelector:@selector(sendDataForSTMusicLogicViewCOfSTMusicModel:)]){
        [_delegate sendDataForSTMusicLogicViewCOfSTMusicModel:musicModel];
    }
}
/**
 *
 *
 *
 *
 */
-(void)setMusicViewCShowControllerState:(BOOL)musicViewCShowControllerState{
    if (_delegate &&[_delegate respondsToSelector:@selector(sendDataForSTMusicLogicViewCOfSTMusicViewCShowControllerState:)]) {
        _musicViewCShowControllerState =[_delegate sendDataForSTMusicLogicViewCOfSTMusicViewCShowControllerState:musicViewCShowControllerState];
    }
}
-(void)setOpenSTMusicSoundEffectViewC:(BOOL)openSTMusicSoundEffectViewC{
    if (_delegate &&[_delegate respondsToSelector:@selector(sendDataForSTmusicLogicViewCOfOpneSTMusicSoundEffectViewC:)]) {
      _openSTMusicSoundEffectViewC=  [_delegate sendDataForSTmusicLogicViewCOfOpneSTMusicSoundEffectViewC:openSTMusicSoundEffectViewC];
    }
}

/*
 *
 */
-(void)setDelegate:(id<STMusicCenterManagerDelegate>)delegate{
    _delegate = delegate;
}

#pragma mark - SE (sound effect ViewC) (data)(SE UI)

//????   return  BOOL
-(void)setResumeSEViewCDefaultValueSet:(BOOL)resumeSEViewCDefaultValueSet{
    //--->music logic ViewC
//    if (_delegate &&[_delegate respondsToSelector:@selector(sendDataForSTMusicLogicViewCOfResumeSEViewCDefaultValueSet:)]) {
//       _resumeSEViewCDefaultValueSet =  [_delegate sendDataForSTMusicLogicViewCOfResumeSEViewCDefaultValueSet:resumeSEViewCDefaultValueSet];
//    }
//    //---> SE
//    if (_seDelegate &&[_delegate respondsToSelector:@selector(senddataForSTMusicSELogicViewCOfResumeSEViewCDefaultValueSet:)]) {
//        _resumeSEViewCDefaultValueSet =  [_seDelegate senddataForSTMusicSELogicViewCOfResumeSEViewCDefaultValueSet:resumeSEViewCDefaultValueSet];
//    }
//    //基本就是YES
    [self setRecordSEBGMValue:0.5];
    [self setRecordSEMicValue:0.5];
    [self setRecordSEPitchValue:0];
    [self setRecordSEEffectTypeNum:0];
    //HD type  pitch
}
//伴奏
-(void)setRecordSEBGMValue:(CGFloat)recordSEBGMValue{
    _recordSEBGMValue = recordSEBGMValue;
    //--->music logic ViewC  SDK deal
    if (_delegate &&[_delegate respondsToSelector:@selector(sendDataForSTMusicLogicViewCOfRecordSEBGMValue:)]) {
        [_delegate sendDataForSTMusicLogicViewCOfRecordSEBGMValue:recordSEBGMValue];
    }
    //---> SE  UI deal
    if (_seDelegate &&[_seDelegate respondsToSelector:@selector(sendDataForSTMusicSELogicViewCOfRecordSEBGMValue:)]) {
        [_seDelegate sendDataForSTMusicSELogicViewCOfRecordSEBGMValue:recordSEBGMValue];
    }
}
// 麦克风 音量
-(void)setRecordSEMicValue:(CGFloat)recordSEMicValue{
    _recordSEMicValue = recordSEMicValue;
    //--->music logic ViewC
    if (_delegate &&[_delegate respondsToSelector:@selector(sendDataForDataSTMusicLogicViewCOfRecordSEMicValue:)]) {
        [_delegate sendDataForDataSTMusicLogicViewCOfRecordSEMicValue:_recordSEMicValue];
    }
     //---> SE
    if (_seDelegate &&[_seDelegate respondsToSelector:@selector(sendDataForSTMusicSELogicViewCOfRecordSEMicValue:)]) {
        [_seDelegate sendDataForSTMusicSELogicViewCOfRecordSEMicValue:_recordSEMicValue];
    }
}


//C++ 独有 目前
// 音效类型
-(void)setRecordSEEffectTypeNum:(NSInteger)recordSEEffectTypeNum{
    _recordSEEffectTypeNum = recordSEEffectTypeNum;
    //--->music logic ViewC  -->SDK
    if (_delegate && [_delegate respondsToSelector:@selector(sendDataForDataSTMusicLogicViewCOfRecordSEEffectTypeValue:)]) {
        [_delegate sendDataForDataSTMusicLogicViewCOfRecordSEEffectTypeValue:recordSEEffectTypeNum];
    }
    //---> SE --> UI
    if (_seDelegate &&[_seDelegate respondsToSelector:@selector(sendDataForSTMusicSELogicViewCOfRecordSEEffectTypeValue:)]) {
        [_seDelegate sendDataForSTMusicSELogicViewCOfRecordSEEffectTypeValue:recordSEEffectTypeNum];
    }
}
// 音调
-(void)setRecordSEPitchValue:(CGFloat)recordSEPitchValue{
    _recordSEPitchValue = recordSEPitchValue;
    //--->music logic ViewC  -->SDK
    if (_delegate &&[_delegate respondsToSelector:@selector(sendDataForDataSTMusicLogicViewCOfRecordSEPitchValue:)]) {
        [_delegate sendDataForDataSTMusicLogicViewCOfRecordSEPitchValue:recordSEPitchValue];
    }
    //---> SE --> UI
    if (_seDelegate &&[_seDelegate respondsToSelector:@selector(sendDataForSTMusicSELogicViewCOfRecordSEPitchValue:)]) {
        [_seDelegate sendDataForSTMusicSELogicViewCOfRecordSEPitchValue:recordSEPitchValue];
    }
}





























@end
