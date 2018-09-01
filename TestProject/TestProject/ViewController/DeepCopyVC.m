//
//  DeepCopyVC.m
//  TestProject
//
//  Created by Wang,Ling(wallet-plus) on 2018/7/24.
//  Copyright © 2018年 Wang,Ling(wallet-plus). All rights reserved.
//

#import "DeepCopyVC.h"

@interface DeepCopyVC ()

@end

@implementation DeepCopyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self test];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)test {
    //create dic
    NSString *arrItem = @"sdfg";
    NSArray *arr = @[arrItem];
    NSDictionary *dic = @{@"a":arr};
    NSLog(@"dic adress: %p",dic);
    NSLog(@"dic.arr adress: %p",arr);
    NSLog(@"dic.arr[0] adress: %p",arrItem);
    
    //dic 转 date
    NSError *error;
    NSData *dicDate = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    
    [NSJSONSerialization isValidJSONObject:dic];
    
    //date 转 dic
    NSMutableDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:dicDate options:NSJSONReadingMutableContainers error:&error];
    
    //打印dic1及其内部存储对象的地址，与dic的不同，可以确定 是重新开辟的空间，是深拷贝
    NSLog(@"dic1 adress: %p",dic1);
    NSLog(@"dic1.arr adress: %p",dic1[@"a"]);
    NSLog(@"dic.arr[0] adress: %p",dic1[@"a"][0]);
}

@end
