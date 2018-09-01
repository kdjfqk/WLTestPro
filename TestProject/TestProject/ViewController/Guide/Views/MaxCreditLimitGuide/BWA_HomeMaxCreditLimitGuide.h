//
//  BWA_HomeMaxCreditLimitGuide.h
//  TestProject
//
//  Created by Wang,Ling(wallet-plus) on 2018/7/26.
//  Copyright © 2018年 Wang,Ling(wallet-plus). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BWA_HomeMaxCreditLimitGuide : NSObject
+ (BOOL)shouldShowGuideView;

- (void)setDatasource:(id)datasource maskRect:(CGRect)rect;
- (void)showGuide;
- (void)removeGuide;
@end
