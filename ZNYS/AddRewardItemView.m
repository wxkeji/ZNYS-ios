//
//  AddRewardItemView.m
//  ZNYS
//
//  Created by Ellise on 16/4/22.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "AddRewardItemView.h"

@interface AddRewardItemView()

@property (nonatomic,strong) UIImageView * coinView;

@property (nonatomic,strong) UIView * lineView;

@end

@implementation AddRewardItemView

#pragma mark life cycle

- (void)dealloc{
    _backgroundView = nil;
    _coinLabel = nil;
    _coinView = nil;
    _lineView = nil;
    _bottomButton = nil;
    _delegate = nil;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.backgroundView];
        [self addSubview:self.coinView];
        [self addSubview:self.coinLabel];
        [self addSubview:self.lineView];
        [self addSubview:self.bottomButton];
        
        WS(weakSelf, self);
        [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(0);
            make.top.equalTo(weakSelf.mas_top).with.offset(0);
            make.right.equalTo(weakSelf.mas_right).with.offset(0);
            make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
        }];
        
        [self.coinView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(CustomWidth(29));
            make.top.equalTo(weakSelf.mas_top).with.offset(CustomHeight(97));
            make.width.mas_equalTo(CustomWidth(15));
            make.height.mas_equalTo(CustomHeight(15));
        }];
        
        [self.coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.coinView.mas_right).with.offset(3);
            make.centerY.mas_equalTo(weakSelf.mas_centerY);
            make.width.mas_equalTo(CustomWidth(45));
            make.height.mas_equalTo(CustomHeight(18));
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.coinView.mas_bottom).with.offset(CustomHeight(14));
            make.left.equalTo(weakSelf.mas_left).with.offset(CustomWidth(7));
            make.right.equalTo(weakSelf.mas_right).with.offset(CustomWidth(-7));
            make.height.mas_equalTo(CustomHeight(1));
        }];
        
        [self.bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(0);
            make.right.equalTo(weakSelf.mas_right).with.offset(0);
            make.top.equalTo(weakSelf.lineView.mas_bottom).with.offset(0);
            make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
        }];
    }
    return self;
}

#pragma mark private method

#pragma mark action method

- (void)addReward{
    [self.delegate showAddRewardDetailView];
}

#pragma mark getters and setters

- (UIImageView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIImageView alloc] init];
        _backgroundView.backgroundColor = [UIColor yellowColor];
    }
    return _backgroundView;
}

- (UIImageView *)coinView{
    if (!_coinView) {
        _coinView = [[UIImageView alloc] init];
        _coinView.backgroundColor = [UIColor blueColor];
    }
    return _coinView;
}

- (UILabel *)coinLabel{
    if (!_coinLabel) {
        _coinLabel = [[UILabel alloc] initWithCustomFont:15.f];
        _coinLabel.text = @"x 8";
        _coinLabel.textAlignment = NSTextAlignmentLeft;
        _coinLabel.textColor = [UIColor whiteColor];
    }
    return _coinLabel;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor whiteColor];
    }
    return _lineView;
}

- (UIButton *)bottomButton{
    if (!_bottomButton) {
        _bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomButton addTarget:self action:@selector(addReward) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomButton;
}

@end
