//
//  BWA_HomeMaxCreditLimitGuideViewItem.m
//  TestProject
//
//  Created by Wang,Ling(wallet-plus) on 2018/7/30.
//  Copyright © 2018年 Wang,Ling(wallet-plus). All rights reserved.
//

#import "BWA_HomeMaxCreditLimitGuideViewItem.h"
#import "Macro.h"

#define kTitleImgViewWidth DuNativeResourceWidth(22.6)

#define kTitleLabelX DuNativeResourceWidth(35)
#define kTitleLabelWidth DuNativeResourceWidth(210)
#define kTitleLabelHeight DuNativeResourceWidth(53)
#define kTitleLabelMaxWidth DuNativeResourceWidth((210+48))


@interface BWA_HomeMaxCreditLimitGuideViewItem()
@property (nonatomic, strong) id datasource;
@property (nonatomic, strong) UIImageView *titleImgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *limitLabel;
@end

@implementation BWA_HomeMaxCreditLimitGuideViewItem
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
    }
    return self;
}
- (void)setDatasource:(id)datasource {
    _datasource = datasource;
    [self updateContent];
}

- (void)createSubViews {
    self.backgroundColor = UIColor.clearColor;
    [self addSubview:self.titleImgView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.limitLabel];
    [self updateContent];
}

- (void)updateContent {
    //TODO：替换为self.datasource真实值
    self.titleImgView.image = [UIImage imageNamed:@"rectangle_blue"];
    self.titleLabel.text = @"其中满易贷可借";
    NSMutableAttributedString *limitText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%d",50000]];
    [limitText setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:DuNativeResourceFontSize(30)]} range:NSMakeRange(0, 1)];
    [limitText setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:DuNativeResourceFontSize(50)]} range:NSMakeRange(1, limitText.length-1)];
    self.limitLabel.attributedText = limitText;
    
    [self updateLayout];
}

- (void)updateLayout {
    CGRect frame = self.titleLabel.frame;
    frame.size = [self.titleLabel sizeThatFits:CGSizeMake(kTitleLabelMaxWidth, CGFLOAT_MAX)];
    self.titleLabel.frame = frame;
}

- (UIImageView *)titleImgView {
    if (!_titleImgView) {
        _titleImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (kTitleLabelHeight-kTitleImgViewWidth)/2, kTitleImgViewWidth, kTitleImgViewWidth)];
        [_titleImgView setImage:[UIImage imageNamed:@"rectangle_blue"]];
    }
    return _titleImgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kTitleLabelX, 0, kTitleLabelWidth, kTitleLabelHeight)];
        _titleLabel.text = @"";
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:DuNativeResourceFontSize(30)];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.backgroundColor = UIColor.clearColor;
        _titleLabel.numberOfLines = 0;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _titleLabel;
}

- (UILabel *)limitLabel {
    if (!_limitLabel) {
        _limitLabel = [[UILabel alloc] initWithFrame:CGRectMake(kTitleLabelX, kTitleLabelHeight, kTitleLabelWidth, kTitleLabelHeight)];
        _limitLabel.text = @"";
        _limitLabel.textColor = [UIColor whiteColor];
        _limitLabel.font = [UIFont systemFontOfSize:DuNativeResourceFontSize(50)];
        _limitLabel.textAlignment = NSTextAlignmentLeft;
        _limitLabel.backgroundColor = UIColor.clearColor;
    }
    return _limitLabel;
}
@end
