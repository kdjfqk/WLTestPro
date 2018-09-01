//
//  BWA_HomeMaxCreditLimitGuideView.m
//  TestProject
//
//  Created by Wang,Ling(wallet-plus) on 2018/7/26.
//  Copyright © 2018年 Wang,Ling(wallet-plus). All rights reserved.
//

#import "BWA_HomeMaxCreditLimitGuideView.h"
#import "BWA_HomeMaxCreditLimitGuideViewItem.h"
#import "Macro.h"

#define kArrowImageY CGRectGetMaxY(self.maskRect)+DuNativeResourceHeight(45)
#define kArrowImageWidth DuNativeResourceWidth(40)
#define kArrowImageHeight DuNativeResourceHeight(54)
#define kArrowImageRect CGRectMake((DuScreenWidth-kArrowImageWidth)/2, kArrowImageY, kArrowImageWidth, kArrowImageHeight)

#define kDetailLabelY CGRectGetMaxY(kArrowImageRect)+DuNativeResourceHeight(42)
#define kDetailLabelWidth CGRectGetWidth(self.bounds)
#define kDetailLabelHeight DuNativeResourceHeight(56)
#define kDetailLabelRect CGRectMake(0, kDetailLabelY, kDetailLabelWidth, kDetailLabelHeight)
#define kDetailLabelTextWithLimit(limit) [NSString stringWithFormat:@"—— 您最多同时可借%d元 ——",limit]

#define kBottomBtnFont [UIFont systemFontOfSize:DuNativeResourceFontSize(30)]
#define kBottomBtnWidth DuNativeResourceWidth(480)
#define kBottomBtnHeight DuNativeResourceHeight(80)
#define kBottomBtnRect CGRectMake((DuScreenWidth-kBottomBtnWidth)/2, DuScreenHeight-DuNativeResourceHeight(128)-kBottomBtnHeight, kBottomBtnWidth, kBottomBtnHeight)

#define kCreditLimitGuideViewItemY CGRectGetMaxY(kDetailLabelRect)+DuNativeResourceHeight(72)
#define kCreditLimitGuideViewItemWidth DuNativeResourceWidth(245)
#define kCreditLimitGuideViewItemHeight DuNativeResourceHeight(106)

#define kLeftCreditLimitGuideViewItemX DuNativeResourceWidth(82)
#define kLeftCreditLimitGuideViewItemRect CGRectMake(kLeftCreditLimitGuideViewItemX, kCreditLimitGuideViewItemY, kCreditLimitGuideViewItemWidth, kCreditLimitGuideViewItemHeight)

#define kLineViewWidth DuNativeResourceWidth(1)
#define kLineViewHeight DuNativeResourceHeight(83)
#define kLineViewX (DuScreenWidth-kLineViewWidth)/2
#define kLineViewY kCreditLimitGuideViewItemY+(kCreditLimitGuideViewItemHeight-kLineViewHeight)/2
#define kLineViewRect CGRectMake(kLineViewX, kLineViewY, kLineViewWidth, kLineViewHeight)

#define kRightCreditLimitGuideViewItemRect CGRectMake(CGRectGetMaxX(kLineViewRect)+DuNativeResourceWidth(26), kCreditLimitGuideViewItemY, kCreditLimitGuideViewItemWidth, kCreditLimitGuideViewItemHeight)


#pragma mark - BWA_MaskView
@interface BWA_MaskView :UIView
- (void)setPath:(CGPathRef)path;
- (void)setMaskColor:(UIColor *)color;
@end

@implementation BWA_MaskView {
    CAShapeLayer *maskLayer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        maskLayer = [[CAShapeLayer alloc] init];
        [maskLayer setFillColor:[UIColor colorWithWhite:0 alpha:0.9].CGColor];
        [maskLayer setFillRule:kCAFillRuleEvenOdd];
        [self.layer addSublayer:maskLayer];
    }
    return self;
}
- (void)setPath:(CGPathRef)path {
    CGMutablePathRef mutablePath = CGPathCreateMutable();
    CGPathAddRect(mutablePath, nil, self.bounds);
    CGPathAddPath(mutablePath, nil, path);
    maskLayer.path = mutablePath;
}
- (void)setMaskColor:(UIColor *)color {
    [maskLayer setFillColor:color.CGColor];
}
@end

#pragma mark - BWA_HomeMaxCreditLimitGuideView
@interface BWA_HomeMaxCreditLimitGuideView()
@property (nonatomic, strong) id datasource;
@property (nonatomic, assign) CGRect maskRect;
@property (nonatomic, strong) BWA_MaskView *maskView;
@property (nonatomic, strong) UIImageView *arrowImgView;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) BWA_HomeMaxCreditLimitGuideViewItem *leftItemView;
@property (nonatomic, strong) BWA_HomeMaxCreditLimitGuideViewItem *rightItemView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *bottomBtn;
@end

@implementation BWA_HomeMaxCreditLimitGuideView

- (instancetype)init {
    return [self initWithFrame:UIScreen.mainScreen.bounds];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
    }
    return self;
}

- (void)setDatasource:(id)datasource maskRect:(CGRect)rect{
    _datasource = datasource;
    _maskRect = rect;
    [self updateContent];
}

- (void)createSubViews {
    self.backgroundColor = UIColor.clearColor;
    [self addSubview:self.maskView];
    [self addSubview:self.arrowImgView];
    [self addSubview:self.bottomBtn];
    [self addSubview:self.detailLabel];
    [self addSubview:self.leftItemView];
    [self addSubview:self.lineView];
    [self addSubview:self.rightItemView];
}

- (void)updateContent {
    //TODO: 更新内容，替换为self.datasource值
    self.detailLabel.text = kDetailLabelTextWithLimit(300000);
    [self.leftItemView setDatasource:nil];
    [self.rightItemView setDatasource:nil];
    
    [self updateLayout];
}
- (void)updateLayout {
    [self.maskView setPath:CGPathCreateWithRoundedRect(_maskRect, 10, 10, nil)];
    self.arrowImgView.frame = kArrowImageRect;
    self.detailLabel.frame = kDetailLabelRect;
    self.leftItemView.frame = kLeftCreditLimitGuideViewItemRect;
    self.lineView.frame = kLineViewRect;
    self.rightItemView.frame = kRightCreditLimitGuideViewItemRect;
}

- (void)bottomBtnAction:(UIButton *)sender {
    if (self.closeAction) {
        self.closeAction();
    }
}

#pragma mark - getter
- (BWA_MaskView *)maskView {
    if (!_maskView) {
        _maskView = [[BWA_MaskView alloc] initWithFrame:self.bounds];
    }
    return _maskView;
}

- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        _bottomBtn = [[UIButton alloc] initWithFrame:kBottomBtnRect];
        [_bottomBtn setTitle:@"Close Guide" forState:UIControlStateNormal];
        [_bottomBtn setTintColor:[UIColor whiteColor]];
        [_bottomBtn.titleLabel setFont:kBottomBtnFont];
        _bottomBtn.backgroundColor = UIColor.clearColor;
        _bottomBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _bottomBtn.layer.borderWidth = 1;
        _bottomBtn.layer.cornerRadius = 20;
        [_bottomBtn addTarget:self action:@selector(bottomBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}
- (UIImageView *)arrowImgView {
    if (!_arrowImgView) {
        _arrowImgView = [[UIImageView alloc] initWithFrame:kArrowImageRect];
        [_arrowImgView setImage:[UIImage imageNamed:@"arrow_guide"]];
    }
    return _arrowImgView;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:kDetailLabelRect];
        _detailLabel.text = kDetailLabelTextWithLimit(300000);
        _detailLabel.textColor = [UIColor whiteColor];
        _detailLabel.font = [UIFont systemFontOfSize:DuNativeResourceFontSize(40)];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.backgroundColor = UIColor.clearColor;
    }
    return _detailLabel;
}

- (BWA_HomeMaxCreditLimitGuideViewItem *)leftItemView {
    if (!_leftItemView) {
        _leftItemView = [[BWA_HomeMaxCreditLimitGuideViewItem alloc] initWithFrame:kLeftCreditLimitGuideViewItemRect];
    }
    return _leftItemView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:kLineViewRect];
        _lineView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4];
    }
    return _lineView;
}

- (BWA_HomeMaxCreditLimitGuideViewItem *)rightItemView {
    if (!_rightItemView) {
        _rightItemView = [[BWA_HomeMaxCreditLimitGuideViewItem alloc] initWithFrame:kRightCreditLimitGuideViewItemRect];
    }
    return _rightItemView;
}

@end
