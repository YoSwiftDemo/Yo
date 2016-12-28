//
//  NavView.h
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 16/12/26.
//  Copyright © 2016年 岳克奎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XXNibBridge.h> 
@class NavView;
@protocol NavViewDelegate <NSObject>
@optional
//left btn click event
-(void)leftBtnClicOfNavView:(NavView *)navView complete:(void(^)(BOOL finished))block;
//right btn click event
-(void)rightBtnClicOfNavView:(NavView *)navView complete:(void(^)(BOOL finished))block;
@end
@interface NavView : UIView<XXNibBridge>
@property (weak, nonatomic) IBOutlet UIButton *navLeftBtn;  //左btn
@property (weak, nonatomic) IBOutlet UIButton *navRightBtn; //右btn
@property (weak, nonatomic) IBOutlet UILabel  *navTitleLab; //中间的title
@property(weak,nonatomic)id<NavViewDelegate>deleagte;       //代理
@end
