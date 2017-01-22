//
//  NSString+Common.h
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 17/1/22.
//  Copyright © 2017年 岳克奎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)
/**
 * @brief:lrc字符串转lrc数据源数组
 *
 */
-(void)lrcStringToLrcSoureDataArrayComplete:(void(^)(NSMutableArray *lrcModelDataSoureMArray,
                                                     NSMutableArray *lrcPointDurationMArray))block;
@end
