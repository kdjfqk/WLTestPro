//
//  BWA_OverlayWindow.h
//  TestProject
//
//  Created by Wang,Ling(wallet-plus) on 2018/7/26.
//  Copyright © 2018年 Wang,Ling(wallet-plus). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BWA_OverlayWindow : UIWindow

- (instancetype)initWithDefaultBGColor;
- (instancetype)initWithDefaultBGColorAlpha:(CGFloat)alpha;
- (instancetype)initWithBGColor:(UIColor *)bgColor;

- (void)setContentView:(UIView *)content;
- (void)showWindow;
- (void)hidenWindow;

@end
