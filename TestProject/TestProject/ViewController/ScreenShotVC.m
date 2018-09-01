//
//  ScreenShotVC.m
//  TestProject
//
//  Created by Wang,Ling(wallet-plus) on 2018/8/24.
//  Copyright © 2018年 Wang,Ling(wallet-plus). All rights reserved.
//

#import "ScreenShotVC.h"
#import <WebKit/WebKit.h>

@interface ScreenShotVC ()
@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UIButton *btn;
@end

@implementation ScreenShotVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.webview];
    [self.view addSubview:self.imgView];
//    [self.view addSubview:self.btn];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"截屏" style:UIBarButtonItemStylePlain target:self action:@selector(test)];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baid.com"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)test {
    //截屏
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIGraphicsBeginImageContextWithOptions(window.bounds.size, NO, 0.0);
    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.imgView setImage:image];
}

- (void)btnClicked {
    [self test];
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 200)];
    }
    return _imgView;
}


- (UIButton *)btn {
    if (!_btn) {
        _btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 100, 50)];
        _btn.backgroundColor = [UIColor redColor];
        _btn.titleLabel.text = @"截屏";
        [_btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

@end
