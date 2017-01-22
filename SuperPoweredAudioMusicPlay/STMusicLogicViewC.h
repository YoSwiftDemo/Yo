//
//  STMusicLogicViewC.h
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 17/1/19.
//  Copyright © 2017年 岳克奎. All rights reserved.
//

#import "STMusicLogicBaseViewC.h"

@protocol STMusicLogicViewCDelegate <NSObject>
@optional
-(void)sendDataForSTMusicViewCOfSTMusicModel:(STMusicModel *)stMusicModel;
-(BOOL)sendForSTMusicViewCOfSTMusicPlayerPlayingState:(BOOL)stMusicPlayerPlingState;
-(BOOL)sendDataForSTMusicViewCOfSTMusicViewCShowControllerState:(BOOL)stMusicViewCShowControllerState;
-(BOOL)sendDataForSTMusicViewCOfShowSTMusicSoundEffectViewCState:(BOOL)showSTMusicEffectViewCState;
#pragma mark - SE (sound effect ViewC )(data)
-(BOOL)sendDataForSTMusicViewCOfResumeSEViewCDefaultValueSet:(BOOL)resumeSEViewCDefaultValueSet;
-(void)sendDataForSTMusicViewCOfRecordSEBGMValue:(CGFloat)recordSEBGMValue;
-(void)sendDataForSTMusicViewCOfRecordSEMicValue:(CGFloat)recordSEMicValue;
-(void)sendDataForSTMusicViewCOfRecordSEPitchValue:(CGFloat)recordSEPitchValue;
-(void)sendDataForSTMusicViewCOfRecordSEEffectTypeValue:(CGFloat)recordSEEffectTypeValue;
@end

@interface STMusicLogicViewC : STMusicLogicBaseViewC <STMusicCenterManagerDelegate>
@property(weak,nonatomic)id<STMusicLogicViewCDelegate>delegate;
@end
