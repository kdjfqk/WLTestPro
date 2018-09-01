//
//  RichTextVCViewController.m
//  TestProject
//
//  Created by Wang,Ling(wallet-plus) on 2018/8/20.
//  Copyright © 2018年 Wang,Ling(wallet-plus). All rights reserved.
//

#import "RichTextVCViewController.h"
#import <CoreText/CoreText.h>

@interface RichTextVCViewController ()
@property  (nonatomic, strong) UILabel *lab;
@end

@implementation RichTextVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.lab];
    NSString *str = @"您最多300000可借额度^300000^元^sdf^jknk^ss";
    self.lab.attributedText = [self BWAHomeSetFontText:str wordFont:[UIFont fontWithName:@"PingFangSC-Light" size:10] numberFont:[UIFont fontWithName:@"PingFangSC-Medium" size:30]];
}

- (NSAttributedString *)BWAHomeSetFontText:(NSString *)text wordFont:(UIFont *)wordFont numberFont:(UIFont *)numberFont{
    if (!([text isKindOfClass:[NSString class]] && text.length)) {
        return nil;
    }
    
    NSString *pattern = [NSString stringWithFormat:@"\\^.*?\\^"];
    NSError *error = nil;
    NSMutableArray *strArr = [[NSMutableArray alloc] init]; //带^的数字字符串
    
    @try {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
        NSArray <NSTextCheckingResult *> *result = [regex matchesInString:text options:0 range:NSMakeRange(0, text.length)];
        if (result) {
            for (NSUInteger i=0; i<result.count; i++) {
                NSTextCheckingResult *tempResult = [result objectAtIndex:i];
                [strArr addObject:[text substringWithRange:tempResult.range]];
            }
        }
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
    } @finally {
        if (error) {
            //self.text = [text stringByReplacingOccurrencesOfString:@"^" withString:@""];
        }
    }
    
    //去掉^符号
    for (NSInteger i=0; i<strArr.count; i++) {
        NSString *item = strArr[i];
        strArr[i] = [item stringByReplacingOccurrencesOfString:@"^" withString:@""];
    }
    
    //去掉text中的^
    NSString *newStr = [text stringByReplacingOccurrencesOfString:@"^" withString:@""];
    
    //获取text中纯数字的rang
    NSMutableArray *rangArr = [[NSMutableArray alloc] init];
    for (NSInteger i=0; i<strArr.count; i++) {
        NSRange rang = [newStr rangeOfString:strArr[i]];
        if (rang.location != NSNotFound) {
            [rangArr addObject:[NSValue valueWithRange:rang]];
        }
    }
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:newStr];
    [attrStr setAttributes:@{NSFontAttributeName:wordFont} range:NSMakeRange(0, attrStr.length)];
    for (NSValue *rang in rangArr) {
        [attrStr setAttributes:@{NSFontAttributeName:numberFont} range:[rang rangeValue]];
    }
    return attrStr;
}

- (NSAttributedString *)getAttributedStringWithText:(NSString *)text wordFont:(UIFont *)wordFont numberFont:(UIFont *)numberFont{
    NSArray *strArr = [text componentsSeparatedByString:@"^"];
    NSMutableAttributedString *mutaAttrStr = [[NSMutableAttributedString alloc] init];
    NSInteger maxIndex = strArr.count-1;
    for (int index=0; index<maxIndex; index++) {
        //index为偶数，为非选中，设置wordFont
        if (index%2==0) {
            NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:strArr[index] attributes:@{NSFontAttributeName:wordFont}];
            [mutaAttrStr appendAttributedString:attrStr];
            
            //index为奇数，为选中，设置numberFont
        } else {
            NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:strArr[index] attributes:@{NSFontAttributeName:numberFont}];
            [mutaAttrStr appendAttributedString:attrStr];
        }
    }
    //最后一个元素，若index为奇数，且字符串以"^"结尾，则也被选中
    if ((maxIndex%2 != 0) && ([text hasSuffix:@"^"])) {
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:strArr[maxIndex] attributes:@{NSFontAttributeName:numberFont}];
        [mutaAttrStr appendAttributedString:attrStr];
    } else {
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:strArr[maxIndex] attributes:@{NSFontAttributeName:wordFont}];
        [mutaAttrStr appendAttributedString:attrStr];
    }
    return mutaAttrStr;
}

- (NSAttributedString *)get2AttributedStringWithText:(NSString *)text wordFont:(UIFont *)wordFont numberFont:(UIFont *)numberFont {
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
    NSInteger separatorCount = 0;
    NSInteger i = 0;
    
    while (i<text.length) {
        NSInteger j = i;
        while (j<text.length) {
            //字符不是分隔符时，继续向后遍历
            if (![[text substringWithRange:NSMakeRange(j, 1)] isEqualToString:@"^"]) {
                j++;
                continue;
            }
            
            //字符是分隔符时，获取i到j的substr，并根据分隔符是否成对来判断该substr是否被标记为数字
            separatorCount++;
            NSRange range = NSMakeRange(i, j-i);
            if (range.length>0) {
                if (separatorCount%2 == 0) {    //成对匹配结束，substr被标记为数子
                    [result appendAttributedString:[[NSAttributedString alloc] initWithString:[text substringWithRange:range] attributes:@{NSFontAttributeName:numberFont}]];
                } else {    //成对匹配开始，，substr未被标记为数子
                    [result appendAttributedString:[[NSAttributedString alloc] initWithString:[text substringWithRange:range] attributes:@{NSFontAttributeName:wordFont}]];
                }
            }
            break;
        }
        
        if (j<text.length) {
            i = j+1;
        } else {    //处理结尾substr
             NSRange range = NSMakeRange(i, j-i);
            [result appendAttributedString:[[NSAttributedString alloc] initWithString:[text substringWithRange:range] attributes:@{NSFontAttributeName:wordFont}]];
            break;
        }
    }
    return result;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UILabel *)lab {
    if (!_lab) {
        _lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-20, [UIScreen mainScreen].bounds.size.height-20)];
        _lab.numberOfLines = 0;
        _lab.textAlignment = NSTextAlignmentLeft;
    }
    return _lab;
}

@end
