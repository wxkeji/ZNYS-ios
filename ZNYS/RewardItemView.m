//
//  RewardItemView.m
//  ZNYS
//
//  Created by Ellise on 16/1/14.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "RewardItemView.h"

@interface RewardItemView()

@property (nonatomic,strong) UIImageView * coinView;

@end

@implementation RewardItemView

#pragma mark life cycle 

- (void)dealloc{
    _bgView = nil;
    _coinLabel = nil;
    _coinView = nil;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.bgView];
        [self addSubview:self.coinView];
        [self addSubview:self.coinLabel];
        
        WS(weakSelf, self);
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(0);
            make.top.equalTo(weakSelf.mas_top).with.offset(0);
            make.right.equalTo(weakSelf.mas_right).with.offset(0);
            make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
        }];
        
        [self.coinView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(CustomWidth(23));
            make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-CustomHeight(14));
            make.width.mas_equalTo(CustomWidth(20));
            make.height.mas_equalTo(CustomHeight(20));
        }];
        
        [self.coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.coinView.mas_right).with.offset(CustomWidth(8));
            make.centerY.mas_equalTo(weakSelf.coinView.mas_centerY);
            make.height.mas_equalTo(weakSelf.coinView.mas_height);
        }];
    }
    return self;
}

#pragma mark getters and setters

- (UIImageView *)bgView{
    if (!_bgView) {
        _bgView = [[UIImageView alloc] init];
        _bgView.backgroundColor = [UIColor yellowColor];
    }
    return _bgView;
}

- (UIImageView *)coinView{
    if (!_coinView) {
        _coinView = [[UIImageView alloc]init];
        _coinView.backgroundColor = [UIColor purpleColor];
    }
    return _coinView;
}

- (UILabel *)coinLabel{
    if (!_coinLabel) {
        _coinLabel = [[UILabel alloc] initWithCustomFont:15.f];
        _coinLabel.text = @"x 8";
        _coinLabel.textColor = [UIColor whiteColor];
    }
    return _coinLabel;
}

@end
