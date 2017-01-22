//
//  STMusicUIBaseViewC.h
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 17/1/19.
//  Copyright © 2017年 岳克奎. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol STMusicUIBaseViewCDelegate <NSObject>

@optional

@end
@interface STMusicUIBaseViewC : UIViewController
@property(strong,nonatomic)UIViewController *recordSuperViewC;
@property(weak,nonatomic)id<STMusicUIBaseViewCDelegate>delegate;
+(STMusicUIBaseViewC *)showSTMusicFunctionViewCOnSuperViewC:(UIViewController *)superViewC
                                                ofFrameRect:(CGRect)frameRect
                                            newViewCNameStr:(NSString *)newViewCNameStr
                                                   complete:(void(^)(BOOL finished,
                                                                     STMusicUIBaseViewC *newViewC))block;
@end
