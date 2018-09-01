//
//  BWA_HomeMaxCreditLimitGuideView.h
//  TestProject
//
//  Created by Wang,Ling(wallet-plus) on 2018/7/26.
//  Copyright © 2018年 Wang,Ling(wallet-plus). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BWA_HomeMaxCreditLimitGuideView : UIView

@property (nonatomic, copy) void(^closeAction)(void);

- (void)setDatasource:(id)datasource maskRect:(CGRect)rect;

@end
