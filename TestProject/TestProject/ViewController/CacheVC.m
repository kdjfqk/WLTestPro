//
//  CacheVC.m
//  TestProject
//
//  Created by Wang,Ling(wallet-plus) on 2018/7/19.
//  Copyright © 2018年 Wang,Ling(wallet-plus). All rights reserved.
//

#import "CacheVC.h"

@interface CacheVC () <NSCacheDelegate>

@end

@implementation CacheVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSCache *cache = [[NSCache alloc] init];
    cache.countLimit = 10;
//    cache.totalCostLimit = 1;
    cache.delegate = self;
    
    for (int i = 0; i<50; i++) {
//        NSObject *obj = [[NSObject alloc] init];
//        NSString *obj = [[NSString alloc] initWithFormat:@"---%d----%@",i,@"sdfg"];
        NSString *obj = @"dfsdg";
        [cache setObject:obj forKey:@(i)];
        
        NSLog(@"%p",obj);
    }
    
    NSLog(@"10------%@",[cache objectForKey:@(49)]);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
    NSLog(@"willEvictObject");
}

@end
