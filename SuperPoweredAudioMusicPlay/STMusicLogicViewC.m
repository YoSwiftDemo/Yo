//
//  STMusicLogicViewC.m
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 17/1/19.
//  Copyright © 2017年 岳克奎. All rights reserved.
//

#import "STMusicLogicViewC.h"

@interface STMusicLogicViewC ()

@end

@implementation STMusicLogicViewC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)setDelegate:(id<STMusicLogicViewCDelegate>)delegate{
    _delegate = delegate;
}
#pragma mark ------------------------------------- custom delegate
/**
 *
 * @discussion:从调度中心下发的数据，然后通过代理告诉不同的ViewC 处理数据和UI变化
 *
 */

-(BOOL)sendDataForSTMusicLogicViewCSTMusicPlayerPlayingState:(BOOL)stMusicPlayerPlingState{
    if (_delegate &&[_delegate respondsToSelector:@selector(sendForSTMusicViewCOfSTMusicPlayerPlayingState:)]) {
        return  [_delegate sendForSTMusicViewCOfSTMusicPlayerPlayingState:stMusicPlayerPlingState];
    }
    return NO;
}
-(void)sendDataForSTMusicLogicViewCOfSTMusicModel:(STMusicModel *)stMusicModel{
    if (_delegate &&[_delegate respondsToSelector:@selector(sendDataForSTMusicViewCOfSTMusicModel:)]) {
        [_delegate sendDataForSTMusicViewCOfSTMusicModel:stMusicModel];
    }
}
-(BOOL)sendDataForSTMusicLogicViewCOfSTMusicViewCShowControllerState:(BOOL)musicViewCShowControllerState{
    if(_delegate && [_delegate respondsToSelector:@selector(sendDataForSTMusicViewCOfSTMusicViewCShowControllerState:)]){
        return [_delegate sendDataForSTMusicViewCOfSTMusicViewCShowControllerState:musicViewCShowControllerState];
    }
    return !musicViewCShowControllerState;
}
-(BOOL)sendDataForSTmusicLogicViewCOfOpneSTMusicSoundEffectViewC:(BOOL)openSTMusicSoundEffectViewC{
    if (_delegate &&[_delegate respondsToSelector:@selector(sendDataForSTMusicViewCOfShowSTMusicSoundEffectViewCState:)]) {
        return [_delegate sendDataForSTMusicViewCOfShowSTMusicSoundEffectViewCState:openSTMusicSoundEffectViewC];
    }
    return NO;
}



#pragma mark ------------------------------- delegate of  SE (sound effect ViewC data)
//恢复默认数据
-(BOOL)sendDataForSTMusicLogicViewCOfResumeSEViewCDefaultValueSet:(BOOL)resumeSEViewCDefaultValueSet{
    if (_delegate &&[_delegate respondsToSelector:@selector(sendDataForSTMusicViewCOfResumeSEViewCDefaultValueSet:)]) {
        return [_delegate sendDataForSTMusicViewCOfResumeSEViewCDefaultValueSet:resumeSEViewCDefaultValueSet];
    }
    return !resumeSEViewCDefaultValueSet;
}
//伴奏
-(void)sendDataForSTMusicLogicViewCOfRecordSEBGMValue:(CGFloat)recordSEBGMValue{
    if(_delegate &&[_delegate respondsToSelector:@selector(sendDataForSTMusicViewCOfRecordSEBGMValue:)]){
        [_delegate sendDataForSTMusicViewCOfRecordSEBGMValue:recordSEBGMValue];
    }
}
//麦克风
-(void)sendDataForDataSTMusicLogicViewCOfRecordSEMicValue:(CGFloat)recordSEMicValue{
    if (_delegate &&[_delegate respondsToSelector:@selector(sendDataForSTMusicViewCOfRecordSEMicValue:)]) {
        [_delegate sendDataForSTMusicViewCOfRecordSEMicValue:recordSEMicValue];
    }
}
//C++独有
//音调
-(void)sendDataForDataSTMusicLogicViewCOfRecordSEPitchValue:(CGFloat)recordSEPitchValue{
    if (_delegate &&[_delegate respondsToSelector:@selector(sendDataForSTMusicViewCOfRecordSEPitchValue:)]) {
        [_delegate sendDataForSTMusicViewCOfRecordSEPitchValue:recordSEPitchValue];
    }
}
//
//音乐类型
-(void)sendDataForDataSTMusicLogicViewCOfRecordSEEffectTypeValue:(CGFloat)recordSEEffectTypeValue{
    if (_delegate &&[_delegate respondsToSelector:@selector(sendDataForSTMusicViewCOfRecordSEEffectTypeValue:)]) {
        [_delegate sendDataForSTMusicViewCOfRecordSEEffectTypeValue:recordSEEffectTypeValue];
    }
}
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
