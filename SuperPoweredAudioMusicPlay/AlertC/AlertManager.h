//
//  AlertManager.h
//  FanweApp
//
//  Created by 岳克奎 on 16/12/3.
//  Copyright © 2016年 xfg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^AlertAction)(UIAlertAction *action);

typedef NS_ENUM(NSInteger, ActionStyle) {
    Default = 0, //默认样式
    Cancel,//取消样式，一个UIAlertController中只能有一个,且排在所以按钮后面
    Destructive //警告(字体红色)，一般用于删除按钮等
};

@protocol AlertManagerDelegate <NSObject>
/**
 *  输入框代理方法,在此代理中只是对输入框进行配置,不进行赋值的传递
 *
 *  @param textField 输入框
 *  @param index     区分哪一个输入框
 *  @param tag       区分哪一个弹出框的输入框代理
 */

- (void)textField:(UITextField *)textField textFieldAtIndex:(NSInteger)index tag:(NSInteger)tag;

/**
 *  按钮事件代理方法
 *
 *  @param action 按钮
 *  @param index  区分哪一个按钮
 *  @param tag    区分哪一个弹出框的按钮代理
 */
@optional
- (void)action:(UIAlertAction *)action handlerForActionAtIndex:(NSInteger)index tag:(NSInteger)tag;



@end


@interface AlertManager : NSObject

//按钮事件代理
@property (nonatomic, assign) id<AlertManagerDelegate>delegate;

@property (nonatomic, strong) UIAlertController *alertController;
+ (AlertManager *)shareManager;

/**
 *  只有提示框--中间
 *
 *  @param controllerTitle 提示标题
 *  @param message         提示信息
 *  @param afterDelay      消失延迟时间
 */
- (void)showSingleAlertWithTitle:(NSString *)title
                         message:(NSString *)message
               dismissAfterDelay:(CGFloat)afterDelay;
/**
 *  只有提示框--底部
 *
 *  @param title      提示标题
 *  @param message    提示信息
 *  @param afterDelay 消失延迟时间
 */
- (void)showSingleActionSheetWithTitle:(NSString *)title
                               message:(NSString *)message
                     dismissAfterDelay:(CGFloat)afterDelay;


/**
 *  一个按钮--中间
 *
 *  @param title           提示标题
 *  @param message         提示信息
 *  @param tag             区分哪一个提示框
 *  @param delegate        代理人，主要是配置输入框
 *  @param textFieldNumber 输入框个数
 *  @param actionTitle     按钮标题
 *  @param actionStyle     按钮样式
 *  @param alertViewAction 按钮响应事件
 */
- (void)showOneAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                          tag:(NSInteger)tag
                     delegate:(id<AlertManagerDelegate>)delegate
              textFieldNumber:(NSUInteger)textFieldNumber
                  actionTitle:(NSString *)actionTitle
                  actionStyle:(ActionStyle)actionStyle
                  alertAction:(AlertAction)alertAction;



/**
 *  一个按钮--底部
 *
 *  @param title           提示标题
 *  @param message         提示信息
 *  @param actionTitle     按钮标题
 *  @param actionStyle     按钮样式
 *  @param alertViewAction 按钮响应事件
 */
- (void)showOneActionSheetWithTitle:(NSString *)title
                            message:(NSString *)message
                        actionTitle:(NSString *)actionTitle
                        actionStyle:(ActionStyle)actionStyle
                        alertAction:(AlertAction)alertAction;


/**
 *  两个按钮--中间
 *
 *  @param title                提示标题
 *  @param message              提示信息
 *  @param tag                  区分哪一个提示框
 *  @param delegate             代理人，主要是配置输入框
 *  @param textFieldNumber      输入框个数
 *  @param actionTitle          按钮标题
 *  @param actionStyle          按钮样式
 *  @param alertViewAction      按钮响应事件
 *  @param otherActionTitle     其他按钮标题
 *  @param otherActionStyle     其他按钮样式
 *  @param otherAlertViewAction 其他按钮事件
 */
- (void)showTwoAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                          tag:(NSInteger)tag
                     delegate:(id<AlertManagerDelegate>)delegate
              textFieldNumber:(NSUInteger)textFieldNumber
                  actionTitle:(NSString *)actionTitle
                  actionStyle:(ActionStyle)actionStyle
                  alertAction:(AlertAction)alertAction
             otherActionTitle:(NSString *)otherActionTitle
             otherActionStyle:(ActionStyle)otherActionStyle
             otherAlertAction:(AlertAction)otherAlertAction;

/**
 *  两个按钮--底部
 *
 *  @param title                提示标题
 *  @param message              提示信息
 *  @param actionTitle          按钮标题
 *  @param actionStyle          按钮样式
 *  @param alertViewAction      按钮响应事件
 *  @param otherActionTitle     其他按钮标题
 *  @param otherActionStyle     其他按钮样式
 *  @param otherAlertViewAction 其他按钮事件
 */
- (void)showTwoActionSheetWithTitle:(NSString *)title
                            message:(NSString *)message
                        actionTitle:(NSString *)actionTitle
                        actionStyle:(UIAlertActionStyle)actionStyle
                        alertAction:(AlertAction)alertAction
                   otherActionTitle:(NSString *)otherActionTitle
                   otherActionStyle:(ActionStyle)otherActionStyle
                   otherAlertAction:(AlertAction)otherAlertAction;



/**
 *  多个按钮--中间
 * （按钮多余两个的话推荐使用此方法）
 *  @param title           提示标题
 *  @param message         提示信息
 *  @param tag             区分哪一个提示框
 *  @param delegate        代理人,主要是配置输入框,实现按钮点击事件
 *  @param textFieldNumber 输入框个数
 *  @param actionNumber    按钮个数
 *  @param actionTitle     按钮标题（字符串）
 *  @param actionStyle     按钮样式（数字0，1，2，以NSNumber格式存入字典）0代表默认样式，1代表取消样式(这种样式的按钮只能有一种,它会自动排在所有按钮最后)，2警示样式（字体是红色）
 */
- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
                       tag:(NSInteger)tag
                  delegate:(id<AlertManagerDelegate>)delegate
           textFieldNumber:(NSUInteger)textFieldNumber
              actionNumber:(NSUInteger)actionNumber
               actionTitle:(NSArray <NSString *> *)actionTitle
               actionStyle:(NSArray <NSNumber *> *)actionStyle;

/**
 *  多个按钮--底部
 * （按钮多余两个的话推荐使用此方法）
 *  @param title           提示标题
 *  @param message         提示信息
 *  @param tag             区分哪一个提示框
 *  @param delegate        代理人,主要是实现按钮点击事件
 *  @param actionNumber    按钮个数
 *  @param actionTitle     按钮标题（字符串）
 *  @param actionStyle     按钮样式（数字0，1，2，以NSNumber格式存入字典）0代表默认样式，1代表取消样式(这种样式的按钮只能有一种,它会自动排在所有按钮最后)，2警示样式（字体是红色）
 */
- (void)showActionSheetWithTitle:(NSString *)title
                         message:(NSString *)message
                             tag:(NSInteger)tag
                        delegate:(id<AlertManagerDelegate>)delegate
                    actionNumber:(NSUInteger)actionNumber
                     actionTitle:(NSArray <NSString *> *)actionTitle
                     actionStyle:(NSArray <NSNumber *> *)actionStyle;
@end
