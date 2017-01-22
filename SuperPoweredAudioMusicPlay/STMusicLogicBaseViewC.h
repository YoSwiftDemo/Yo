//
//  STMusicLogicBaseViewC.h
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 17/1/19.
//  Copyright © 2017年 岳克奎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STMusicLogicBaseViewC : UIViewController
@property(strong,nonatomic)UIViewController *recordSuperViewC;
+( STMusicLogicBaseViewC *)showSTMusicLogicOnSuperViewC:(STMusicBaseViewC *)superViewC
                                            ofFrameRect:(CGRect)frameRect
                                        newViewCNameStr:(NSString *)newViewCNameStr
                                               complete:(void(^)(BOOL finished,
                                                                 STMusicLogicBaseViewC *newViewC))block;
@end
