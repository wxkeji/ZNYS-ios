//
//  UserDetailView.m
//  ZNYS
//
//  Created by Ellise on 16/1/5.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "UserDetailView.h"

@interface UserDetailView ()

@property (nonatomic,strong) UIButton * modifyButton;

@end

@implementation UserDetailView

#pragma mark life cycle

- (void)dealloc{
    _thumbImage = nil;
    _nameLabel = nil;
    _birthdayLabel = nil;
    _coinLabel = nil;
    _brushLabel = nil;
    _modifyButton = nil;
    _modifyButtonBlock = nil;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        
        [self addSubview:self.thumbImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.birthdayLabel];
        [self addSubview:self.coinLabel];
        [self addSubview:self.brushLabel];
        [self addSubview:self.modifyButton];
        
        WS(weakSelf, self);
        [self.thumbImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_top).with.offset(0.061*kSCREEN_HEIGHT);
            make.centerX.mas_equalTo(weakSelf.mas_centerX);
            make.width.mas_equalTo(0.291*kSCREEN_WIDTH);
            make.height.mas_equalTo(0.291*kSCREEN_WIDTH);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.thumbImage.mas_bottom).with.offset(0.03*kSCREEN_HEIGHT);
            make.height.mas_equalTo(0.033*kSCREEN_HEIGHT);
            make.centerX.mas_equalTo(weakSelf.mas_centerX);
        }];
        
        [self.birthdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                       make.top.equalTo(weakSelf.nameLabel.mas_bottom).with.offset(0.026*kSCREEN_HEIGHT);
            make.height.mas_equalTo(0.033*kSCREEN_HEIGHT);
            make.centerX.mas_equalTo(weakSelf.mas_centerX);
        }];
        
        [self.coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(weakSelf.birthdayLabel.mas_bottom).with.offset(0.026*kSCREEN_HEIGHT);
            make.height.mas_equalTo(0.033*kSCREEN_HEIGHT);
            make.centerX.mas_equalTo(weakSelf.mas_centerX);
        }];
        
        [self.brushLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(weakSelf.coinLabel.mas_bottom).with.offset(0.026*kSCREEN_HEIGHT);
            make.height.mas_equalTo(0.033*kSCREEN_HEIGHT);
            make.centerX.mas_equalTo(weakSelf.mas_centerX);
        }];
        
        [self.modifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_right).with.offset(-0.059*kSCREEN_WIDTH);
            make.top.equalTo(weakSelf.mas_top).with.offset(0.061*kSCREEN_HEIGHT);
            make.width.mas_equalTo(0.104*kSCREEN_WIDTH);
            make.height.mas_equalTo(0.104*kSCREEN_WIDTH);
        }];
    }
    return self;
}

#pragma mark event action

- (void)modifyButtonAction{
    if (self.modifyButtonBlock) {
        self.modifyButtonBlock();
    }
}

#pragma mark getters and setters

- (UIImageView *)thumbImage{
    if (!_thumbImage) {
        _thumbImage = [[UIImageView alloc] init];
        _thumbImage.layer.cornerRadius = 10.f;
    }
    return _thumbImage;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithCustomFont:20.f];
        _nameLabel.text = [NSString stringWithFormat:@"昵称：果果"];
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}

- (UILabel *)birthdayLabel{
    if (!_birthdayLabel) {
        _birthdayLabel = [[UILabel alloc] initWithCustomFont:20.f];
        _birthdayLabel.text = [NSString stringWithFormat:@"生日：2000-01-01"];
        _birthdayLabel.textColor = [UIColor whiteColor];
    }
    return _birthdayLabel;
}

- (UILabel *)coinLabel{
    if (!_coinLabel) {
        _coinLabel = [[UILabel alloc] initWithCustomFont:20.f];
        _coinLabel.text = [NSString stringWithFormat:@"累计金币：50"];
        _coinLabel.textColor = [UIColor whiteColor];
    }
    return _coinLabel;
}

- (UILabel *)brushLabel{
    if (!_brushLabel) {
        _brushLabel = [[UILabel alloc] initWithCustomFont:20.f];
        _brushLabel.text = [NSString stringWithFormat:@"正在使用牙刷：1把"];
        _brushLabel.textColor = [UIColor whiteColor];
    }
    return _brushLabel;
}

- (UIButton *)modifyButton{
    if (!_modifyButton) {
        _modifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_modifyButton addTarget:self action:@selector(modifyButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _modifyButton;
}

@end
