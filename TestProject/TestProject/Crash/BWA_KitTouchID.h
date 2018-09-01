//
//  BAKit_TouchID.h
//  BWACore
//
//  Created by ldj on 2017/7/3.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>

// 操作系统版本号
#define IOS_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])

/**
 *  TouchID 状态
 */
typedef NS_ENUM(NSUInteger, BWAKit_TouchIDType){
    
    /**
     *  当前设备不支持TouchID
     */
    BWAKit_TouchIDTypeNotSupport = 0,
    /**
     *  TouchID 验证成功
     */
    BWAKit_TouchIDTypeSuccess,
    /**
     *  TouchID 验证失败
     */
    BWAKit_TouchIDTypeFail,
    /**
     *  TouchID 被用户手动取消
     */
    BWAKit_TouchIDTypeUserCancel,
    /**
     *  用户不使用TouchID,选择手动输入密码
     */
    BWAKit_TouchIDTypeInputPassword,
    /**
     *  TouchID 被系统取消 (如遇到来电,锁屏,按了Home键等)
     */
    BWAKit_TouchIDTypeSystemCancel,
    /**
     *  TouchID 无法启动,因为用户没有设置密码
     */
    BWAKit_TouchIDTypePasswordNotSet,
    /**
     *  TouchID 无法启动,因为用户没有设置TouchID
     */
    BWAKit_TouchIDTypeTouchIDNotSet,
    /**
     *  TouchID 无效
     */
    BWAKit_TouchIDTypeTouchIDNotAvailable,
    /**
     *  TouchID 被锁定(连续多次验证TouchID失败,系统需要用户手动输入密码)
     */
    BWAKit_TouchIDTypeTouchIDLockout,
    /**
     *  当前软件被挂起并取消了授权 (如App进入了后台等)
     */
    BWAKit_TouchIDTypeAppCancel,
    /**
     *  当前软件被挂起并取消了授权 (LAContext对象无效)
     */
    BWAKit_TouchIDTypeInvalidContext,
    /**
     *  系统版本不支持TouchID (必须高于iOS 8.0才能使用)
     */
    BWAKit_TouchIDTypeVersionNotSupport,
    /**
     *  touchID有变化
     */
    BWAKit_TouchIDTypeTouchIDHaveChange
};

/**
 指纹解锁 回调
 
 @param touchIDType 返回的类型，BAKit_TouchIDType
 @param error error
 @param errorMessage errorMessage
 */
typedef void (^BWAKit_TouchID_Block)(BWAKit_TouchIDType touchIDType, NSError *error, NSString *errorMessage);

/**
 判断是否支持指纹解锁 回调
 
 @param isSupport 是否支持
 @param context context
 @param policy policy
 @param error error
 */
typedef void (^BWAKit_TouchIDVerifyIsSupport_Block)(BOOL isSupport,LAContext *context, NSInteger policy, NSError *error);

@interface BWA_KitTouchID : NSObject

/**
 指纹解锁
 
 @param content  提示文本
 @param cancelButtonTitle  取消按钮显示内容(此参数只有iOS10以上才能生效)，默认（nil）：取消
 @param otherButtonTitle   密码登录按钮显示内容，默认（nil）：输入密码（nil）
 @param enabled    默认：NO，输入密码按钮，使用系统解锁；YES：自己操作点击密码登录
 @param BWAKit_TouchIDTypeBlock   返回状态码和错误，可以自行单独处理
 */
+ (void)touchIDWithContent:(NSString *)content
            cancelButtonTitle:(NSString *)cancelButtonTitle
             otherButtonTitle:(NSString *)otherButtonTitle
                      enabled:(BOOL)enabled
       BWAKit_TouchIDTypeBlock:(BWAKit_TouchID_Block)BWAKit_TouchIDTypeBlock;

/**
 判断是否支持指纹解锁
 
 @param block block
 */
+ (void)touchIDVerifyIsSupportWithBlock:(BWAKit_TouchIDVerifyIsSupport_Block)block;

/**
 判断是否支持指纹解锁
 
 */
+ (BOOL)touchIDVerifyIsSupport;
@end
