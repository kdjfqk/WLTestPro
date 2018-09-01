//
//  BWA_OverlayWindow.m
//  TestProject
//
//  Created by Wang,Ling(wallet-plus) on 2018/7/26.
//  Copyright © 2018年 Wang,Ling(wallet-plus). All rights reserved.
//

#import "BWA_OverlayWindow.h"

@interface BWA_OverlayWindow()
@property (nonatomic, strong) UIView *content;
@end

@implementation BWA_OverlayWindow

- (instancetype)init {
    return [self initWithDefaultBGColor];
}
- (instancetype)initWithDefaultBGColor {
    return [self initWithDefaultBGColorAlpha:0.9];
}
- (instancetype)initWithDefaultBGColorAlpha:(CGFloat)alpha {
    return [self initWithBGColor:[UIColor colorWithWhite:0 alpha:alpha]];
}
- (instancetype)initWithBGColor:(UIColor *)bgColor{
    if (self = [super initWithFrame:UIScreen.mainScreen.bounds]) {
        self.windowLevel = UIWindowLevelStatusBar+1;
        self.backgroundColor = bgColor;
    }
    return self;
}

- (void)setContentView:(UIView *)content {
    _content = content;
    [self addSubview:_content];
}

- (void)showWindow {
    self.hidden = NO;
}
- (void)hidenWindow {
    self.hidden = YES;
}

@end
