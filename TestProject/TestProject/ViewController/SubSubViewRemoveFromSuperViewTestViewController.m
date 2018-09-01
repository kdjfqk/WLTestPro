//
//  SubSubViewRemoveFromSuperViewTestViewController.m
//  TestProject
//
//  Created by Wang,Ling(wallet-plus) on 2018/8/1.
//  Copyright © 2018年 Wang,Ling(wallet-plus). All rights reserved.
//

#import "SubSubViewRemoveFromSuperViewTestViewController.h"

@interface SubSubView : UIView
@end

@implementation SubSubView
- (void)removeFromSuperview {
    NSLog(@"SubSubView removeFromSuperview called!!!!!");
    [super removeFromSuperview];
}
@end



@interface SubView : UIView
@property (nonatomic, strong) SubSubView *ssView;
@end

@implementation SubView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.ssView];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remove)]];
    }
    return self;
}

- (void)removeFromSuperview {
    NSLog(@"SubView removeFromSuperview called!!!!!");
    [super removeFromSuperview];
}

- (SubSubView *)ssView {
    if (!_ssView) {
        _ssView = [[SubSubView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        _ssView.backgroundColor = [UIColor yellowColor];
    }
    return _ssView;
}

- (void)remove {
    [self removeFromSuperview];
}

@end


@interface SubSubViewRemoveFromSuperViewTestViewController ()
@property (nonatomic, strong) SubView *sView;
@end

@implementation SubSubViewRemoveFromSuperViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.sView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (SubView *)sView {
    if (!_sView) {
        _sView = [[SubView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        _sView.backgroundColor = [UIColor redColor];
    }
    return _sView;
}

@end
