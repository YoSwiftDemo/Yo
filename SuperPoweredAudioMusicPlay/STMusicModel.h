//
//  STMusicModel.h
//  FanweApp
//
//  Created by 岳克奎 on 17/1/12.
//  Copyright © 2017年 xfg. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface STMusicModel : NSObject

@property(nonatomic,strong)NSString         *musicNameStr;//歌曲民
@property(nonatomic,strong)NSString         *musicSingerNameStr;//歌手名
@property(nonatomic,strong)NSString         *musicLrcContentDataStr;//歌曲内容
@property(nonatomic,strong)NSString         *musicFilePathStr;//歌曲 路径

@property(nonatomic,strong)NSMutableArray   *lrcModelDataSourceArray;
@property(nonatomic,strong)NSMutableArray   *lrcTimePointDataArray;
@end
