//
//  AlertManager.m
//  FanweApp
//
//  Created by 岳克奎 on 16/12/3.
//  Copyright © 2016年 xfg. All rights reserved.
//


#import "AlertManager.h"

@implementation AlertManager
static AlertManager *signleton = nil;
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        signleton = [super allocWithZone:zone];
    });
    return signleton;
}

+ (AlertManager *)shareManager
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
//只有提示框--中间
- (void)showSingleAlertWithTitle:(NSString *)title
                         message:(NSString *)message
               dismissAfterDelay:(CGFloat)afterDelay {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [[UIApplication sharedApplication].windows.lastObject.rootViewController presentViewController:alertC animated:YES completion:^{
        [self performSelector:@selector(dismiss:) withObject:alertC afterDelay:afterDelay];
    }];
}
- (void)dismiss:(UIAlertController *)aler {
    [aler dismissViewControllerAnimated:YES completion:nil];
}
//只有提示框--底部
- (void)showSingleActionSheetWithTitle:(NSString *)title
                               message:(NSString *)message
                     dismissAfterDelay:(CGFloat)afterDelay {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    [[UIApplication sharedApplication].windows.lastObject.rootViewController presentViewController:alertC animated:YES completion:^{
        [self performSelector:@selector(dismiss:) withObject:alertC afterDelay:afterDelay];
    }];
    
}
//一个按钮--中间
- (void)showOneAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                          tag:(NSInteger)tag
                     delegate:(id<AlertManagerDelegate>)delegate
              textFieldNumber:(NSUInteger)textFieldNumber
                  actionTitle:(NSString *)actionTitle
                  actionStyle:(ActionStyle)actionStyle
                  alertAction:(AlertAction)alertAction {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    self.alertController = alertC;
    if (textFieldNumber > 0) {
        for (int i = 0; i < textFieldNumber; i++) {
            [alertC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                if ([delegate respondsToSelector:@selector(textField:textFieldAtIndex:tag:)]) {
                    [delegate textField:textField textFieldAtIndex:i tag:tag];
                }
            }];
        }
    }
    
    UIAlertActionStyle style = UIAlertActionStyleDefault;
    switch (actionStyle) {
        case Default:
            style = UIAlertActionStyleDefault;
            break;
        case Cancel:
            style = UIAlertActionStyleCancel;
            break;
        case Destructive:
            style = UIAlertActionStyleDestructive;
            break;
        default:
            break;
    }
    UIAlertAction *alertOne = [UIAlertAction actionWithTitle:actionTitle style:style handler:^(UIAlertAction * _Nonnull action)  {
        alertAction(action);
    }];
    [alertC addAction:alertOne];
    [[UIApplication sharedApplication].windows.lastObject.rootViewController presentViewController:alertC animated:YES completion:nil];
    
}
//一个按钮--底部
- (void)showOneActionSheetWithTitle:(NSString *)title
                            message:(NSString *)message
                        actionTitle:(NSString *)actionTitle
                        actionStyle:(ActionStyle)actionStyle
                        alertAction:(AlertAction)alertAction {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    self.alertController = alertC;
    
    UIAlertActionStyle style = UIAlertActionStyleDefault;
    switch (actionStyle) {
        case Default:
            style = UIAlertActionStyleDefault;
            break;
        case Cancel:
            style = UIAlertActionStyleCancel;
            break;
        case Destructive:
            style = UIAlertActionStyleDestructive;
            break;
        default:
            break;
    }
    UIAlertAction *alertOne = [UIAlertAction actionWithTitle:actionTitle style:style handler:^(UIAlertAction * _Nonnull action)  {
        alertAction(action);
    }];
    [alertC addAction:alertOne];
    
    [[UIApplication sharedApplication].windows.lastObject.rootViewController presentViewController:alertC animated:YES completion:nil];
}
//两个按钮--中间
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
             otherAlertAction:(AlertAction)otherAlertAction {
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    self.alertController = alertC;
    if (textFieldNumber > 0) {
        for (int i = 0; i < textFieldNumber; i++) {
            [alertC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                if ([delegate respondsToSelector:@selector(textField:textFieldAtIndex:tag:)]) {
                    [delegate textField:textField textFieldAtIndex:i tag:tag];
                }
            }];
        }
    }
    
    UIAlertActionStyle style = 0;
    switch (actionStyle) {
        case Default:
            style = UIAlertActionStyleDefault;
            break;
        case Cancel:
            style = UIAlertActionStyleCancel;
            break;
        case Destructive:
            style = UIAlertActionStyleDestructive;
            break;
        default:
            break;
    }
    UIAlertAction *alertOne = [UIAlertAction actionWithTitle:actionTitle style:style handler:^(UIAlertAction * _Nonnull action)  {
        alertAction(action);
    }];
    
    UIAlertActionStyle style1 = 0;
    switch (otherActionStyle) {
        case Default:
            style1 = UIAlertActionStyleDefault;
            break;
        case Cancel:
            style1 = UIAlertActionStyleCancel;
            break;
        case Destructive:
            style1 = UIAlertActionStyleDestructive;
            break;
        default:
            break;
    }
    
    UIAlertAction *alertTwo = [UIAlertAction actionWithTitle:otherActionTitle style:style1 handler:^(UIAlertAction * _Nonnull action)  {
        otherAlertAction(action);
    }];
    [alertC addAction:alertOne];
    [alertC addAction:alertTwo];
    [[UIApplication sharedApplication].windows.lastObject.rootViewController presentViewController:alertC animated:YES completion:nil];
    
}
//两个按钮--底部
- (void)showTwoActionSheetWithTitle:(NSString *)title
                            message:(NSString *)message
                        actionTitle:(NSString *)actionTitle
                        actionStyle:(UIAlertActionStyle)actionStyle
                        alertAction:(AlertAction)alertAction
                   otherActionTitle:(NSString *)otherActionTitle
                   otherActionStyle:(ActionStyle)otherActionStyle
                   otherAlertAction:(AlertAction)otherAlertAction {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    self.alertController = alertC;
    
    UIAlertActionStyle style = 0;
    switch (actionStyle) {
        case Default:
            style = UIAlertActionStyleDefault;
            break;
        case Cancel:
            style = UIAlertActionStyleCancel;
            break;
        case Destructive:
            style = UIAlertActionStyleDestructive;
            break;
        default:
            break;
    }
    
    UIAlertAction *alertOne = [UIAlertAction actionWithTitle:actionTitle style:style handler:^(UIAlertAction * _Nonnull action)  {
        alertAction(action);
    }];
    UIAlertActionStyle style1 = 0;
    switch (otherActionStyle) {
        case Default:
            style1 = UIAlertActionStyleDefault;
            break;
        case Cancel:
            style1 = UIAlertActionStyleCancel;
            break;
        case Destructive:
            style1 = UIAlertActionStyleDestructive;
            break;
        default:
            break;
    }
    
    UIAlertAction *alertTwo = [UIAlertAction actionWithTitle:otherActionTitle style:style1 handler:^(UIAlertAction * _Nonnull action)  {
        otherAlertAction(action);
    }];
    [alertC addAction:alertOne];
    [alertC addAction:alertTwo];
    [[UIApplication sharedApplication].windows.lastObject.rootViewController presentViewController:alertC animated:YES completion:nil];
    
}
//多个按钮--中间
- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
                       tag:(NSInteger)tag
                  delegate:(id<AlertManagerDelegate>)delegate
           textFieldNumber:(NSUInteger)textFieldNumber
              actionNumber:(NSUInteger)actionNumber
               actionTitle:(NSArray<NSString *> *)actionTitle
               actionStyle:(NSArray<NSNumber *> *)actionStyle {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    self.alertController = alertC;
    if (textFieldNumber > 0) {
        //循环创建输入框
        for (int i = 0; i < textFieldNumber; i++) {
            [alertC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                //输入框代理
                if ([delegate respondsToSelector:@selector(textField:textFieldAtIndex:tag:)]) {
                    [delegate textField:textField textFieldAtIndex:i tag:tag];
                }
            }];
        }
    }
    //循环创建按钮
    for (int i = 0; i < actionNumber; i++) {
        UIAlertAction *alertaction = [UIAlertAction actionWithTitle:actionTitle[i] style:[actionStyle[i] integerValue] handler:^(UIAlertAction * _Nonnull action)  {
            //调用代理人完成事件
            if ([delegate respondsToSelector:@selector(action:handlerForActionAtIndex:tag:)]) {
                [delegate action:action handlerForActionAtIndex:i tag:tag];
            }
        }];
        [alertC addAction:alertaction];
    }
    [[UIApplication sharedApplication].windows.lastObject.rootViewController presentViewController:alertC animated:YES completion:nil];
}

//多个按钮--底部
- (void)showActionSheetWithTitle:(NSString *)title
                         message:(NSString *)message
                             tag:(NSInteger)tag
                        delegate:(id<AlertManagerDelegate>)delegate
                    actionNumber:(NSUInteger)actionNumber
                     actionTitle:(NSArray<NSString *> *)actionTitle
                     actionStyle:(NSArray<NSNumber *> *)actionStyle {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    self.alertController = alertC;
    //循环创建按钮
    for (int i = 0; i < actionNumber; i++) {
        UIAlertAction *alertaction = [UIAlertAction actionWithTitle:actionTitle[i] style:[actionStyle[i] integerValue] handler:^(UIAlertAction * _Nonnull action)  {
            //调用代理人完成事件
            if ([delegate respondsToSelector:@selector(action:handlerForActionAtIndex:tag:)]) {
                [delegate action:action handlerForActionAtIndex:i tag:tag];
            }
        }];
        [alertC addAction:alertaction];
    }
    [[UIApplication sharedApplication].windows.lastObject.rootViewController presentViewController:alertC animated:YES completion:nil];
}


@end
