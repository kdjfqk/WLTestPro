//
//  BAKit_TouchID.m
//  BWACore
//
//  Created by ldj on 2017/7/3.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import "BWA_KitTouchID.h"
//#import "UIDeviceUtil.h"

@implementation BWA_KitTouchID
/**
 指纹解锁
 
 @param content  提示文本
 @param cancelButtonTitle  取消按钮显示内容(此参数只有iOS10以上才能生效)，默认（nil）：取消
 @param otherButtonTitle   密码登录按钮显示内容，默认（nil）：输入密码（nil）
 @param enabled    默认：NO，输入密码按钮，使用系统解锁；YES：自己操作点击密码登录
 @param BAKit_TouchIDTypeBlock   返回状态码和错误，可以自行单独处理
 */
+ (void)touchIDWithContent:(NSString *)content
            cancelButtonTitle:(NSString *)cancelButtonTitle
             otherButtonTitle:(NSString *)otherButtonTitle
                      enabled:(BOOL)enabled
   BWAKit_TouchIDTypeBlock:(BWAKit_TouchID_Block)block;
{
    [BWA_KitTouchID touchIDVerifyIsSupportWithBlock:^(BOOL isSupport ,LAContext *context, NSInteger policy, NSError *error) {
        if (!isSupport) {
            NSString *msg = @"此设备不支持Touch ID";
            dispatch_async(dispatch_get_main_queue(), ^{
                block(BWAKit_TouchIDTypeNotSupport, nil, msg);
            });
        }
        //设置为空，右边的输入密码按钮会被隐藏
        context.localizedFallbackTitle = otherButtonTitle;
        NSInteger policy2;
        if (enabled)
        {
            policy2 = LAPolicyDeviceOwnerAuthenticationWithBiometrics;
        }
        else
        {
            policy2 = LAPolicyDeviceOwnerAuthentication;
        }
        // 支持指纹验证
        [context evaluatePolicy:policy2 localizedReason:content reply:^(BOOL success, NSError * _Nullable error) {
            if (success)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(BWAKit_TouchIDTypeSuccess, error, nil);
                });
                
                return ;
            }
            else if (error)
            {
                NSString *msg = @"";
                switch (error.code) {
                    case LAErrorAuthenticationFailed:
                    {
                        msg = @"TouchID 验证失败";
                        dispatch_async(dispatch_get_main_queue(), ^{
                            block(BWAKit_TouchIDTypeFail, error, msg);
                        });
                    }
                        break;
                    case LAErrorUserCancel:
                    {
                        msg = @"TouchID 被用户手动取消";
                        dispatch_async(dispatch_get_main_queue(), ^{
                            block(BWAKit_TouchIDTypeUserCancel, error, msg);
                        });
                    }
                        break;
                    case LAErrorUserFallback:
                    {
                        msg = @"用户不使用TouchID,选择手动输入密码";
                        dispatch_async(dispatch_get_main_queue(), ^{
                            block(BWAKit_TouchIDTypeInputPassword, error, msg);
                        });
                    }
                        break;
                    case LAErrorSystemCancel:
                    {
                        msg = @"TouchID 被系统取消 (如遇到来电,锁屏,按了Home键等)";
                        dispatch_async(dispatch_get_main_queue(), ^{
                            block(BWAKit_TouchIDTypeSystemCancel, error, msg);
                        });
                    }
                        break;
                    case LAErrorPasscodeNotSet:
                    {
                        msg = @"TouchID 无法启动,因为用户没有设置密码";
                        dispatch_async(dispatch_get_main_queue(), ^{
                            block(BWAKit_TouchIDTypePasswordNotSet, error, msg);
                        });
                    }
                        break;
                    case LAErrorTouchIDNotEnrolled:
                    {
                        msg = @"TouchID 无法启动,因为用户没有设置 TouchID";
                        dispatch_async(dispatch_get_main_queue(), ^{
                            block(BWAKit_TouchIDTypeTouchIDNotSet, error, msg);
                        });
                    }
                        break;
                    case LAErrorTouchIDNotAvailable:
                    {
                        msg = @"TouchID 无效";
                        dispatch_async(dispatch_get_main_queue(), ^{
                            block(BWAKit_TouchIDTypeTouchIDNotAvailable, error, msg);
                        });
                    }
                        break;
                        
                        if (IOS_VERSION >= 9.0)
                        {
                        case LAErrorTouchIDLockout:
                            {
                                msg = @"TouchID 被锁定(连续多次验证 TouchID 失败,系统需要用户手动输入密码)";
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    block(BWAKit_TouchIDTypeTouchIDLockout, error, msg);
                                });
                                if (enabled)
                                {
                                    [context evaluatePolicy:policy localizedReason:content reply:^(BOOL success, NSError * _Nullable error) {}];
                                }
                            }
                            break;
                        case LAErrorAppCancel:
                            {
                                msg = @"当前软件被挂起并取消了授权 (如App进入了后台等)";
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    block(BWAKit_TouchIDTypeAppCancel, error, msg);
                                });
                                if (enabled)
                                {
                                    [context evaluatePolicy:policy localizedReason:content reply:^(BOOL success, NSError * _Nullable error) {}];
                                }
                            }
                            break;
                        case LAErrorInvalidContext:
                            {
                                msg = @"当前软件被挂起并取消了授权 (LAContext对象无效)";
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    block(BWAKit_TouchIDTypeInvalidContext, error, msg);
                                });
                                if (enabled)
                                {
                                    [context evaluatePolicy:policy localizedReason:content reply:^(BOOL success, NSError * _Nullable error) {}];
                                }
                            }
                            break;
                        }
                        
                    default:
                    {
                        msg = @"TouchID 验证失败";
                        if (enabled)
                        {
                            [context evaluatePolicy:policy localizedReason:content reply:^(BOOL success, NSError * _Nullable error) {}];
                        }
                    }
                        break;
                }
                //NSLog(@"%@", msg);
            }
        }];
    }];
}

/**
 判断是否支持指纹解锁
 
 @param block block
 */
+ (void)touchIDVerifyIsSupportWithBlock:(BWAKit_TouchIDVerifyIsSupport_Block)block;
{
    if (IOS_VERSION < 8.0)
    {
        block(NO, nil, 0, nil);
        return;
    }
    //BOOL isOldTouch = YES;
    LAContext *context = [LAContext new];
    NSInteger policy;
    if (IOS_VERSION < 9.0 && IOS_VERSION >= 8.0)
    {
        policy = LAPolicyDeviceOwnerAuthenticationWithBiometrics;
    }
    else
    {
        policy = LAPolicyDeviceOwnerAuthentication;
    }
    
    // 错误对象
    NSError *error = nil;
    
    // 首先使用 canEvaluatePolicy 判断设备支持状态
    BOOL isSupport = [context canEvaluatePolicy:policy error:&error];

    //用户没有设置指纹
    if (error.code == kLAErrorPasscodeNotSet || error.code == kLAErrorTouchIDNotEnrolled) {
        isSupport = YES;
    }
    isSupport = isSupport;// || [UIDeviceUtil isSupportFaceID];
    block(isSupport, context, policy, error);
}

+ (BOOL)touchIDVerifyIsSupport
{
    if (IOS_VERSION < 8.0) {
        return NO;
    }
    LAContext *context = [LAContext new];
    // 错误对象
    NSError *error = nil;
    
    BOOL isSupport = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    
    //用户没有设置指纹或指纹已锁
    if (error.code == kLAErrorPasscodeNotSet || error.code == kLAErrorTouchIDNotEnrolled || error.code == kLAErrorTouchIDLockout) {
        return YES;
    }
    
    return isSupport; //|| [UIDeviceUtil isSupportFaceID];
}

@end
