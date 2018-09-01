//
//  ScreenShotShareVC.m
//  TestProject
//
//  Created by Wang,Ling(wallet-plus) on 2018/8/26.
//  Copyright © 2018年 Wang,Ling(wallet-plus). All rights reserved.
//

#import "ScreenShotShareVC.h"

#define kScreenImageScale (3.0/5.0)

@interface ScreenShotShareVC ()
@property (nonatomic, strong) UIImage *screenImg;
@property (nonatomic, strong) UIView *imgViewContainer;
@property (nonatomic, strong) UIImageView *screenImgView;
@property (nonatomic, strong) UIImageView *footerImgView;
@property (nonatomic, strong) UIImageView *mergedImgView;
@property (nonatomic, strong) UIButton *backBtn;
@end

@implementation ScreenShotShareVC

- (instancetype)initWithScreenImge:(UIImage *)img {
    if (self = [super init]) {
        _screenImg = img;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.imgViewContainer];
    [self.imgViewContainer addSubview:self.screenImgView];
    [self.imgViewContainer addSubview:self.footerImgView];
}

- (void)viewWillAppear:(BOOL)animated {
    self.screenImgView.image = _screenImg;
    self.footerImgView.image = [self shareFooterImage];
    [self updateSubViewFrame];
    [self showMergedImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateSubViewFrame {
    CGSize sImgSize = [UIScreen mainScreen].bounds.size;
    CGFloat sImgW = sImgSize.width * kScreenImageScale;
    CGFloat sImgH = sImgSize.height * kScreenImageScale;
    CGFloat sImgX = ([UIScreen mainScreen].bounds.size.width - sImgW)/2;
    CGFloat sImgY = ([UIScreen mainScreen].bounds.size.height - sImgH)/3;
    
    CGSize fImgSize = [self.footerImgView sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width, CGFLOAT_MAX)];
    CGFloat fImgW = sImgW;
    CGFloat fImgH = fImgSize.height * (fImgW/fImgSize.width);
    
    self.imgViewContainer.frame = CGRectMake(sImgX, sImgY, sImgW, sImgH+fImgH);
    self.screenImgView.frame = CGRectMake(0, 0, sImgW, sImgH);
    self.footerImgView.frame = CGRectMake(0, sImgH, fImgW, fImgH);
}

- (UIImage *)shareFooterImage {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"share" ofType:@"png"];
    UIImage *img = [UIImage imageWithContentsOfFile:path];
    return img;
}

- (void)showMergedImage {
    self.mergedImgView.frame = self.imgViewContainer.frame;
    [self.view addSubview:self.mergedImgView];
    UIGraphicsBeginImageContextWithOptions(self.mergedImgView.bounds.size, NO, 0.0);
    [self.imgViewContainer.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.mergedImgView.image = image;
}

- (void)backBtnClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIView *)imgViewContainer {
    if (!_imgViewContainer) {
        _imgViewContainer = [[UIView alloc] init];
    }
    return _imgViewContainer;
}

- (UIImageView *)screenImgView {
    if (!_screenImgView) {
        _screenImgView = [[UIImageView alloc] init];
        _screenImgView.contentMode = UIViewContentModeScaleToFill;
    }
    return _screenImgView;
}
- (UIImageView *)footerImgView {
    if (!_footerImgView) {
        _footerImgView = [[UIImageView alloc] init];
        _footerImgView.contentMode = UIViewContentModeScaleToFill;
    }
    return _footerImgView;
}
- (UIImageView *)mergedImgView {
    if (!_mergedImgView) {
        _mergedImgView = [[UIImageView alloc] init];
        _mergedImgView.contentMode = UIViewContentModeScaleToFill;
    }
    return _mergedImgView;
}
- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 50)];
        [_backBtn setTitle:@"Back" forState:UIControlStateNormal];
        [_backBtn setBackgroundColor:[UIColor blueColor]];
        [_backBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
@end
