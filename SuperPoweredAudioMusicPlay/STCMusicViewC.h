//
//  STCMusicViewC.h
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 17/1/19.
//  Copyright © 2017年 岳克奎. All rights reserved.
//

#import "STMusicBaseViewC.h"
#import "STMusicLogicViewC.h"


@protocol STCMusicViewCDeleagte <NSObject>

@optional
//UI的UI处理
-(void)sendDataFromSTCMusicViewCToSTCMusicUIViewCOfSTMusicModel:(STMusicModel *)stMusicModel;

@end
@interface STCMusicViewC : STMusicBaseViewC  <STMusicLogicViewCDelegate>
@property(weak,nonatomic)id<STCMusicViewCDeleagte>delegate;

@end
