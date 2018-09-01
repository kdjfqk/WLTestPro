//
//  GifImageTestVC.m
//  TestProject
//
//  Created by Wang,Ling(wallet-plus) on 2018/8/16.
//  Copyright © 2018年 Wang,Ling(wallet-plus). All rights reserved.
//

#import "GifImageTestVC.h"
#import "UIImage+GIF.h"

@interface GifImageTestVC ()
//gif图view
@property (nonatomic, strong) UIImageView *imgView;
//gif图首帧view
@property (nonatomic, strong) UIImageView *imgFirst;
//gif图末帧view
@property (nonatomic, strong) UIImageView *imgLast;
@property (nonatomic, strong) UIButton *startBtn;
@property (nonatomic, strong) UIButton *stopBtn;
@end

@implementation GifImageTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加sub view
    [self.view addSubview:self.imgView];
    [self.view addSubview:self.startBtn];
    [self.view addSubview:self.stopBtn];
    [self.view addSubview:self.imgFirst];
    [self.view addSubview:self.imgLast];
}

- (void)viewWillAppear:(BOOL)animated {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"首页" ofType:@"gif"];
    NSData *imgData = [NSData dataWithContentsOfFile:path options:NSDataReadingUncached error:nil];
    UIImage *img = [UIImage sd_animatedGIFWithData:imgData];
    
    [self.imgFirst setImage:img.images[0]];
    [self.imgFirst sizeToFit];
    [self.imgLast setImage:img.images[img.images.count-1]];
    [self.imgLast sizeToFit];
    
    
    self.imgView.animationImages = img.images;
    self.imgView.animationDuration = img.duration;
    self.imgView.animationRepeatCount = 1;
    self.imgView.image = img.images[img.images.count-1];
    [self.imgView startAnimating];
    [self.imgView sizeToFit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startBtnClicked {
    [self.imgView startAnimating];
}

- (void)stopBtnClicked {
    [self.imgView stopAnimating];
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 20, 20)];
    }
    return _imgView;
}

- (UIButton *)startBtn {
    if (!_startBtn) {
        _startBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 50)];
        [_startBtn setTitle:@"播放" forState:UIControlStateNormal];
        [_startBtn setBackgroundColor:[UIColor blueColor]];
        [_startBtn addTarget:self action:@selector(startBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startBtn;
}

- (UIButton *)stopBtn {
    if (!_stopBtn) {
        _stopBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 50)];
        [_stopBtn setTitle:@"停止" forState:UIControlStateNormal];
        [_stopBtn setBackgroundColor:[UIColor blueColor]];
        [_stopBtn addTarget:self action:@selector(stopBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stopBtn;
}

- (UIImageView *)imgFirst {
    if (!_imgFirst) {
        _imgFirst = [[UIImageView alloc] initWithFrame:CGRectMake(100, 300, 20, 20)];
    }
    return _imgFirst;
}

- (UIImageView *)imgLast {
    if (!_imgLast) {
        _imgLast = [[UIImageView alloc] initWithFrame:CGRectMake(100, 400, 20, 20)];
    }
    return _imgLast;
}
@end
