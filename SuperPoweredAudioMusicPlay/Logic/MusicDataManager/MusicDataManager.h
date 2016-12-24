//
//  MusicDataManager.h
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 16/12/23.
//  Copyright © 2016年 岳克奎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicDataManager : NSObject
#pragma mark -life cycle ------------------------------------生 命 周 期 区 域 -----------------------------------
#pragma mark -MusicDataManager 单利
/**
 *  @brief:MusicDataManager 单利
 *
 *  @use:找到brief:MusicDataManager
 */
+ (MusicDataManager *)shareManager;










#pragma mark  ----------------------------------------------- 音 乐 数据相关区域  ---------------------------------
#pragma mark - 音乐 歌词 处理
@end
