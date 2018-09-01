//
//  ShareVC.m
//  TestProject
//
//  Created by Wang,Ling(wallet-plus) on 2018/8/19.
//  Copyright © 2018年 Wang,Ling(wallet-plus). All rights reserved.
//

#import "ShareVC.h"
#import <WebKit/WebKit.h>
#import "ScreenShotShareVC.h"

@interface ShareVC ()
@property (nonatomic, strong) WKWebView *webview;
@end

@implementation ShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view addSubview:self.webview];
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithTitle:@"系统" style:UIBarButtonItemStylePlain target:self action:@selector(callSystemShare)],[[UIBarButtonItem alloc] initWithTitle:@"截屏" style:UIBarButtonItemStylePlain target:self action:@selector(callScreenShotShare)]];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)callSystemShare {
    //调起系统原生分享
    NSArray *images = @[@"rectangle_blue.jpg"];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:images applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (void)callScreenShotShare {
    //截屏
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIGraphicsBeginImageContextWithOptions(window.bounds.size, NO, 0.0);
    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //present截屏分享vc
    ScreenShotShareVC *vc = [[ScreenShotShareVC alloc] initWithScreenImge:image];
    [self presentViewController:vc animated:YES completion:nil];
}

- (WKWebView *)webview {
    if (!_webview) {
        _webview = [[WKWebView alloc] initWithFrame:self.view.bounds];
    }
    return _webview;
}
@end
