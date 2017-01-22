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
 * return: NSMutableDictionary   key1:  lrcModelDataSourceArray  key2:lrcTimePointDataArray
 */
-(NSMutableDictionary *)st_parsingLrcStr;
/**
 * @brief: 时间转S处理（
 *
 * @use:将 秒s 转为  01：07.45
 */
-(NSString *)st_timeTypeOfSToTimeTypeOfMS;

- (BOOL)st_isEmpty;
@end
