//
//  ViewController.m
//  TestProject
//
//  Created by Wang,Ling(wallet-plus) on 2018/7/19.
//  Copyright © 2018年 Wang,Ling(wallet-plus). All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController
{
    NSArray *datasource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self loadData];
}

- (void)loadData {
    if (!datasource) {
        datasource = @[@[@"NSCache", @"CacheVC"],
                       @[@"NSArray/NSDictionary deep copy", @"DeepCopyVC"],
                       @[@"Charles Fake Response Test", @"CharlesFakeResponseVC"],
                       @[@"Guide", @"GuideViewController"],
                       @[@"Sub Sub View RemoveFromSuperView Test", @"SubSubViewRemoveFromSuperViewTestViewController"],
                       @[@"从字符串中提取数字", @"getNumFromString"],
                       @[@"测试Block中使用的外部object的地址是否发生变化", @"objectAddressBlockTest"],
                       @[@"gif图播放", @"GifImageTestVC"],
                       @[@"非主线程的AutoReleasePool什么时候创建", @"ThreadRunloopAutoReleasePoolTestVC"],
                       @[@"分享", @"ShareVC"],
                       @[@"富文本相关", @"RichTextVCViewController"],
                       @[@"UIWebView与WK性能对比", @"UIWKWebViewCompareVC"],
                       ];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = ((NSArray *)datasource[indexPath.row])[0];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *valueStr = (NSString *)((NSArray *)datasource[indexPath.row])[1];
    Class vcClass = NSClassFromString(valueStr);
    id obj = [[vcClass alloc] init];
    if ([obj isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = obj;
        vc.title = (NSString *)((NSArray *)datasource[indexPath.row])[0];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        SEL selector = NSSelectorFromString(valueStr);
        if ([self respondsToSelector:selector]) {
            [self performSelector:selector];
        }
    }
}

#pragma mark - 测试方法
- (void)getNumFromString {
    NSString *str = @"投资券5.89元";
    /*
     正则式含义：
     “\d”表示0-9任意数字；
     []表示匹配方括号中的任意一个字符；
     *表示出现0次或多次；
     (?=***)表示匹配的字符串需要以***为后缀（注：***本身并不包含在匹配出的子字符串中）
     */
    NSRange range = [str rangeOfString:@"\\d[\\d.,]*(?=元)" options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        NSString *subStr = [str substringWithRange:range];
        NSLog(@"%@", subStr);
    }
}

- (void)objectAddressBlockTest {
    UIViewController *vc = [[UIViewController alloc] init];
    NSLog(@"out block : %p", vc);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"in block : %p", vc);
    });
}
@end
