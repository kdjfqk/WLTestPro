//
//  GuideViewController.m
//  TestProject
//
//  Created by Wang,Ling(wallet-plus) on 2018/7/26.
//  Copyright © 2018年 Wang,Ling(wallet-plus). All rights reserved.
//

#import "GuideViewController.h"
#import "BWA_HomeMaxCreditLimitGuide.h"

@interface GuideViewController ()
@property (nonatomic, strong) UIButton *showGuide;
@property (nonatomic, strong) BWA_HomeMaxCreditLimitGuide *maxCreditLimitGuide;
@end

@implementation GuideViewController
{
    UIWindow *win;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.showGuide];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)showGuide {
    if (!_showGuide) {
        _showGuide = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
        [_showGuide setTitle:@"Show Guide" forState:UIControlStateNormal];
        _showGuide.backgroundColor = UIColor.redColor;
        [_showGuide addTarget:self action:@selector(showGuideAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showGuide;
}

- (void)showGuideAction {
    //if ([BWA_HomeMaxCreditLimitGuide shouldShowGuideView]) {
        _maxCreditLimitGuide = [[BWA_HomeMaxCreditLimitGuide alloc] init];
        [_maxCreditLimitGuide setDatasource:nil maskRect:CGRectMake(([UIScreen mainScreen].bounds.size.width-200)/2, 100, 200, 150)];
        [_maxCreditLimitGuide showGuide];
    //}
}
@end
