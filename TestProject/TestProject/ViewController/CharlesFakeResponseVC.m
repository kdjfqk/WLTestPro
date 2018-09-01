//
//  CharlesFakeResponseVC.m
//  TestProject
//
//  Created by Wang,Ling(wallet-plus) on 2018/7/25.
//  Copyright © 2018年 Wang,Ling(wallet-plus). All rights reserved.
//

#import "CharlesFakeResponseVC.h"

@interface CharlesFakeResponseVC ()
@property  (nonatomic, strong) UILabel *lab;    //展示获取到的response数据，若跟fake json文件中数据一致，说明通过Charles制造假数据成功
@end

@implementation CharlesFakeResponseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addSubViews];
    [self test];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addSubViews {
    _lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height-100)];
    _lab.numberOfLines = 0;
    _lab.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_lab];
}

/*
 测试方式：
 1.设备设置网络代理走Charles
 2.Charles设置Map Local映射，将"http://www.baidu.com"映射到一个本地包含response json的文件
 */
- (void)test {
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSError *err;
            NSMutableString *resultStr = [[NSMutableString alloc] init];
            NSDictionary *dicResp = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
            NSLog(@"data dictionary: %@",dicResp);
            [resultStr appendString:[NSString stringWithFormat:@"data dictionary: %@",dicResp.description]];
            [resultStr appendString:@"\n"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self->_lab.text = resultStr;
            });
        } else {
            NSLog(@"error: %@",error.localizedDescription);
        }
        
    }];
    [task resume];
}

@end
