//
//  STMusicBaseViewC.h
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 17/1/19.
//  Copyright © 2017年 岳克奎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STMusicBaseViewC : UIViewController

@property(strong,nonatomic)UIViewController *recordSuperViewC;
@property(strong,nonatomic)UIViewController *recordChildUIViewC;
@property(strong,nonatomic)UIViewController *recordChildLogicViewC;
+(STMusicBaseViewC *)showSTMusicFunctionViewCOnSuperViewC:(UIViewController *)superViewC
                                              ofFrameRect:(CGRect)frameRect
                                          newViewCNameStr:(NSString *)newViewCNameStr
                                                 complete:(void(^)(BOOL finished,
                                                                   STMusicBaseViewC *newViewC))block;
@end
