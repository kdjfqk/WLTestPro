//
//  BWA_HomeMaxCreditLimitGuide.m
//  TestProject
//
//  Created by Wang,Ling(wallet-plus) on 2018/7/26.
//  Copyright © 2018年 Wang,Ling(wallet-plus). All rights reserved.
//

#import "BWA_HomeMaxCreditLimitGuide.h"
#import "BWA_HomeMaxCreditLimitGuideView.h"
#import "BWA_OverlayWindow.h"

#define kBWA_HomeMaxCreditLimitGuideFlagKey @"BWA_HomeMaxCreditLimitGuideFlag"

@interface BWA_HomeMaxCreditLimitGuideFlag: NSObject
+ (BOOL)hasFlag;
+ (void)writeFlag;
+ (void)removeFlag;
@end

@implementation BWA_HomeMaxCreditLimitGuideFlag
+ (BOOL)hasFlag {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kBWA_HomeMaxCreditLimitGuideFlagKey];
}
+ (void)writeFlag {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kBWA_HomeMaxCreditLimitGuideFlagKey];
}
+ (void)removeFlag {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kBWA_HomeMaxCreditLimitGuideFlagKey];
}
@end

@interface BWA_HomeMaxCreditLimitGuide()
@property (nonatomic, strong) BWA_OverlayWindow *overlayWindow;
@property (nonatomic, strong) BWA_HomeMaxCreditLimitGuideView *guideView;
@end

@implementation BWA_HomeMaxCreditLimitGuide

+ (BOOL)shouldShowGuideView {
    return [BWA_HomeMaxCreditLimitGuideFlag hasFlag] == NO;
}

//overwrite
- (instancetype)init {
    if (self = [super init]) {
        [self createSubElment];
    }
    return self;
}

//public
- (void)setDatasource:(id)datasource maskRect:(CGRect)rect{
    [self.guideView setDatasource:datasource maskRect:rect];
}
- (void)showGuide {
    [self.overlayWindow showWindow];
    [BWA_HomeMaxCreditLimitGuideFlag writeFlag];
}
- (void)removeGuide {
    //从UIApplication的windows数组中移除，windows为只读，weak持有数组中元素，故将overlayWindow置为nil即可将其移除
    self.overlayWindow = nil;
}

//private
- (void)createSubElment {
    _guideView = [[BWA_HomeMaxCreditLimitGuideView alloc] init];
    _overlayWindow = [[BWA_OverlayWindow alloc] initWithBGColor:[UIColor clearColor]];
    [_overlayWindow setContentView:_guideView];
    __weak typeof(self) weakSelf = self;
    _guideView.closeAction = ^{
        [weakSelf removeGuide];
    };
}
@end
