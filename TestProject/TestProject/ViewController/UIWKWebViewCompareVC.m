//
//  UIWKWebViewCompareVC.m
//  TestProject
//
//  Created by Wang,Ling(wallet-plus) on 2018/8/27.
//  Copyright © 2018年 Wang,Ling(wallet-plus). All rights reserved.
//

#import "UIWKWebViewCompareVC.h"
#import <WebKit/WebKit.h>

@interface UIWKWebViewCompareVC ()
@property (nonatomic, strong) WKWebView *wkwebview;
@property (nonatomic, strong) UIWebView *uiwebview;
@property (nonatomic, strong) UIWebView *btn;
@end

@implementation UIWKWebViewCompareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithTitle:@"UIWebView" style:UIBarButtonItemStylePlain target:self action:@selector(uiWebViewAction)],[[UIBarButtonItem alloc] initWithTitle:@"WKWebView" style:UIBarButtonItemStylePlain target:self action:@selector(wkWebViewAction)]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)uiWebViewAction {
    [self.wkwebview removeFromSuperview];
    [self.view addSubview:self.uiwebview];
    [self.uiwebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://pet-chain.baidu.com/chain/dogMarket?appId=2&tpl=wallet&nounce=55014&token=14e5eef02d2fd2139813e8273e2b91e9&timeStamp=1535558632551&_sfrom=2pJGs4"]]];
}

- (void)wkWebViewAction {
    [self.uiwebview removeFromSuperview];
    [self.view addSubview:self.wkwebview];
    [self.wkwebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://pet-chain.baidu.com/chain/dogMarket?appId=2&tpl=wallet&nounce=55014&token=14e5eef02d2fd2139813e8273e2b91e9&timeStamp=1535558632551&_sfrom=2pJGs4"]]];
}

- (UIWebView *)uiwebview {
    if (!_uiwebview) {
        _uiwebview = [[UIWebView alloc] initWithFrame:self.view.bounds];
    }
    return _uiwebview;
}

- (WKWebView *)wkwebview {
    if (!_wkwebview) {
        _wkwebview = [[WKWebView alloc] initWithFrame:self.view.bounds];
    }
    return _wkwebview;
}

@end
