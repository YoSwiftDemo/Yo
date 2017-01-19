//
//  STMusicCenterManager.h
//  FanweApp
//
//  Created by 岳克奎 on 17/1/12.
//  Copyright © 2017年 xfg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STMusicModel.h"
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,STMusicType) {
    isSTCMusic = 1, //C++播放器
    isSTYunMusic = 2,//云 播放器
} ;

@protocol STMusicCenterManagerDelegate <NSObject>
@optional
//（S）--data-->（Logic）
-(void)sendDataForSTMusicLogicViewCOfSTMusicModel:(STMusicModel *)stMusicModel;
-(BOOL)sendDataForSTMusicLogicViewCSTMusicPlayerPlayingState:(BOOL)stMusicPlayerPlingState;
//close music ViewC
-(BOOL)sendDataForSTMusicLogicViewCOfSTMusicViewCShowControllerState:(BOOL)musicViewCShowControllerState;
//open/close sound effect View Controlelr
-(BOOL)sendDataForSTmusicLogicViewCOfOpneSTMusicSoundEffectViewC:(BOOL)openSTMusicSoundEffectViewC;


#pragma mark - SE (sound effect ViewC) (data)(SE UI)
/**
 *
 * @discussion: 其实在 音乐VC里能拿到音效VC 但是为了各司其职，一个处理UI 一个处理SDK 数据   2个VC logic 而且代理一对一
 */
//SE Default Value Set STMusicLogicViewC->SDK data   STMusicSELogicViewC->SEViewC->UI
//--->music logic ViewC
-(BOOL)sendDataForSTMusicLogicViewCOfResumeSEViewCDefaultValueSet:(BOOL)resumeSEViewCDefaultValueSet;
//--->music logic ViewC
-(void)sendDataForSTMusicLogicViewCOfRecordSEBGMValue:(CGFloat)recordSEBGMValue;

//mic value
//--->music logic ViewC
-(void)sendDataForDataSTMusicLogicViewCOfRecordSEMicValue:(CGFloat)recordSEMicValue;
////pitch value
-(void)sendDataForDataSTMusicLogicViewCOfRecordSEPitchValue:(CGFloat)recordSEPitchValue;
//effect value
-(void)sendDataForDataSTMusicLogicViewCOfRecordSEEffectTypeValue:(CGFloat)recordSEEffectTypeValue;


@end
@protocol STMusicCenterManagerSEDelegate <NSObject>
@optional
//--->music logic ViewC
-(BOOL)senddataForSTMusicSELogicViewCOfResumeSEViewCDefaultValueSet:(BOOL)resumeSEViewCDefaultValueSet;
//bgm value
-(void)sendDataForSTMusicSELogicViewCOfRecordSEBGMValue:(CGFloat)recordSEBGMValue;
//mic value
-(void)sendDataForSTMusicSELogicViewCOfRecordSEMicValue:(CGFloat)recordSEMicValue;;
//pitch value
-(void)sendDataForSTMusicSELogicViewCOfRecordSEPitchValue:(CGFloat)recordSEPitchValue;
//effect value
-(void)sendDataForSTMusicSELogicViewCOfRecordSEEffectTypeValue:(CGFloat)recordSEEffectTypeValue;
@end


@interface STMusicCenterManager : NSObject
#pragma mark ----------------------------------------   life cycle
+ (STMusicCenterManager *)shareManager;
@property(nonatomic,strong)NSDictionary   *musicBaseSimpleInfoDic;
@property(nonatomic,assign)BOOL           musicPlayerPlayingState;      //音乐播放器 状态
@property(nonatomic,assign)BOOL           musicViewCShowControllerState;
@property(nonatomic,assign)BOOL           openSTMusicSoundEffectViewC;  //音效ViewC  开关
@property(nonatomic,strong)STMusicModel   *musicModel;
@property(nonatomic,weak)id<STMusicCenterManagerDelegate>delegate;
@property(nonatomic,weak)id<STMusicCenterManagerSEDelegate>seDelegate;
//音效数据的管理
@property(nonatomic,assign)BOOL         resumeSEViewCDefaultValueSet;//     (SDK)(SE UI)
@property(nonatomic,assign)CGFloat      recordSEBGMValue; //  音乐音量                (SDK)(SE UI)
@property(nonatomic,assign)CGFloat      recordSEMicValue; //    麦克风音量             (SDK)(SE UI)
@property(nonatomic,assign)CGFloat      recordSEPitchValue; //音调（-12 ~ 12）
@property(nonatomic,assign)NSInteger    recordSEEffectTypeNum;//  音效类型          (SDK)(HD)(SE UI)

@property(nonatomic,assign)STMusicType stMusicType;
@end
