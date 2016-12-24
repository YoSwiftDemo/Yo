//
//  MusicDataManager.m
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 16/12/23.
//  Copyright © 2016年 岳克奎. All rights reserved.
//

#import "MusicDataManager.h"

@implementation MusicDataManager
#pragma mark -life cycle ------------------------------ 生 命 周 期 管 控 区 域 ------------------------------------------
/**
 * @brief: 单利
 *
 * @discussion:我的想法是，用单利管理，以后把DataModel里面的操作都移除出来、、关于music的数据层单独成模块。放在msuic大分类里。这样看着就合理
 */
static MusicDataManager *signleton = nil;
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        signleton = [super allocWithZone:zone];
    });
    return signleton;
}
+ (MusicDataManager *)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        signleton = [[self alloc] init];
    });
    return signleton;
}
+ (id)copyWithZone:(struct _NSZone *)zone
{
    return signleton;
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return signleton;
}


@end
