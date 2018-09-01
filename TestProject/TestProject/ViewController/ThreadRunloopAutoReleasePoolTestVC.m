//
//  ThreadRunloopAutoReleasePoolTestVC.m
//  TestProject
//
//  Created by Wang,Ling(wallet-plus) on 2018/8/16.
//  Copyright © 2018年 Wang,Ling(wallet-plus). All rights reserved.
//

#import "ThreadRunloopAutoReleasePoolTestVC.h"

@interface ThreadRunloopAutoReleasePoolTestVC ()
@property (nonatomic, strong) UIButton *btn;
@end

@implementation ThreadRunloopAutoReleasePoolTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnClicked {
    //创建Thread
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadAction) object:nil];
    [thread start];
}

- (void)threadAction {
    NSLog(@"%@",[NSThread currentThread]);
    NSLog(@"%@",[NSRunLoop currentRunLoop]);
    NSLog(@"%@",[NSRunLoop mainRunLoop]);
    
    __weak NSObject *obj = [self method1];
    [self method2];
    [self method3];
}

- (NSObject *)method1 {
    NSObject *obj1 = [[NSObject alloc] init];
    return obj1;
}
- (void)method2 {
    //NSObject *obj2 = [[NSObject alloc] init];
}
- (void)method3 {
    //NSObject *obj3 = [[NSObject alloc] init];
}

- (UIButton *)btn {
    if (!_btn) {
        _btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 50)];
        [_btn setTitle:@"创建Thread" forState:UIControlStateNormal];
        [_btn setBackgroundColor:[UIColor blueColor]];
        [_btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}
@end
