//
//  STMusicDataCenterManager.h
//  FanweApp
//
//  Created by 岳克奎 on 17/1/12.
//  Copyright © 2017年 xfg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STMusicDataCenterManager : NSObject
#pragma mark ----------------------------------------   life cycle
+ (STMusicDataCenterManager *)shareManager;

-(void)analysisLrcDataOfSTMusicBaseSimpleDic:(NSDictionary *)musicBaseDic
                            complete:(void(^)(BOOL finished,
                                              NSMutableArray *stMusicLrcModelDataSourceMArray,
                                              NSMutableArray *stLrcPointTimeStrDataMArray))block;
@end
