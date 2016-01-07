//
//  UserDetailView.m
//  ZNYS
//
//  Created by Ellise on 16/1/5.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "UserDetailView.h"
#import "User.h"

@interface UserDetailView ()

@property (nonatomic,strong) UIButton * modifyButton;

@property (nonatomic,strong) UILabel * nameDesLabel;

@property (nonatomic,strong) UILabel * birthdayDesLabel;

@property (nonatomic,strong) UILabel * coinDesLabel;

@property (nonatomic,strong) UILabel * brushDesLabel;

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
    _nameDesLabel = nil;
    _birthdayDesLabel = nil;
    _coinDesLabel = nil;
    _brushDesLabel = nil;
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
        [self addSubview:self.nameDesLabel];
        [self addSubview:self.birthdayDesLabel];
        [self addSubview:self.coinDesLabel];
        [self addSubview:self.brushDesLabel];
        
        WS(weakSelf, self);
        [self.thumbImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_top).with.offset(0.061*kSCREEN_HEIGHT);
            make.centerX.mas_equalTo(weakSelf.mas_centerX);
            make.width.mas_equalTo(0.291*kSCREEN_WIDTH);
            make.height.mas_equalTo(0.291*kSCREEN_WIDTH);
        }];
        
        [self.nameDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.thumbImage.mas_bottom).with.offset(0.02*kSCREEN_HEIGHT);
            make.left.equalTo(weakSelf.mas_left).with.offset(0);
            make.width.mas_equalTo(0.5*kSCREEN_WIDTH);
            make.height.mas_equalTo(0.033*kSCREEN_HEIGHT);
        }];
        
        [self.birthdayDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.nameDesLabel.mas_bottom).with.offset(0.016*kSCREEN_HEIGHT);
            make.left.equalTo(weakSelf.mas_left).with.offset(0);
            make.width.mas_equalTo(0.5*kSCREEN_WIDTH);
            make.height.mas_equalTo(0.033*kSCREEN_HEIGHT);
        }];
        
        [self.coinDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.birthdayDesLabel.mas_bottom).with.offset(0.016*kSCREEN_HEIGHT);
            make.left.equalTo(weakSelf.mas_left).with.offset(0);
            make.width.mas_equalTo(0.5*kSCREEN_WIDTH);
            make.height.mas_equalTo(0.033*kSCREEN_HEIGHT);
        }];
        
        [self.brushDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.coinDesLabel.mas_bottom).with.offset(0.016*kSCREEN_HEIGHT);
            make.left.equalTo(weakSelf.mas_left).with.offset(0);
            make.width.mas_equalTo(0.5*kSCREEN_WIDTH);
            make.height.mas_equalTo(0.033*kSCREEN_HEIGHT);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.thumbImage.mas_bottom).with.offset(0.02*kSCREEN_HEIGHT);
            make.left.equalTo(weakSelf.nameDesLabel.mas_right).with.offset(0);
            make.height.mas_equalTo(0.033*kSCREEN_HEIGHT);
        }];
        
        [self.birthdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.nameLabel.mas_bottom).with.offset(0.016*kSCREEN_HEIGHT);
            make.left.equalTo(weakSelf.birthdayDesLabel.mas_right).with.offset(0);
            make.height.mas_equalTo(0.033*kSCREEN_HEIGHT);
        }];
        
        [self.coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(weakSelf.birthdayLabel.mas_bottom).with.offset(0.016*kSCREEN_HEIGHT);
            make.left.equalTo(weakSelf.coinDesLabel.mas_right).with.offset(0);
            make.height.mas_equalTo(0.033*kSCREEN_HEIGHT);
        }];
        
        [self.brushLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(weakSelf.coinLabel.mas_bottom).with.offset(0.016*kSCREEN_HEIGHT);
            make.left.equalTo(weakSelf.brushDesLabel.mas_right).with.offset(0);
            make.height.mas_equalTo(0.033*kSCREEN_HEIGHT);
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
        _nameLabel.text = [User currentUserName];
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}

- (UILabel *)birthdayLabel{
    if (!_birthdayLabel) {
        _birthdayLabel = [[UILabel alloc] initWithCustomFont:20.f];
        _birthdayLabel.text = [User currentUserBirthday];
        _birthdayLabel.textColor = [UIColor whiteColor];
    }
    return _birthdayLabel;
}

- (UILabel *)coinLabel{
    if (!_coinLabel) {
        _coinLabel = [[UILabel alloc] initWithCustomFont:20.f];
        _coinLabel.text = [NSString stringWithFormat:@"%@",[User currentUserTokenOwned]];
        _coinLabel.textColor = [UIColor whiteColor];
    }
    return _coinLabel;
}

- (UILabel *)brushLabel{
    if (!_brushLabel) {
        _brushLabel = [[UILabel alloc] initWithCustomFont:20.f];
        _brushLabel.text = [NSString stringWithFormat:@"1把"];
        _brushLabel.textColor = [UIColor whiteColor];
    }
    return _brushLabel;
}

- (UIButton *)modifyButton{
    if (!_modifyButton) {
        _modifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_modifyButton addTarget:self action:@selector(modifyButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_modifyButton setBackgroundColor:[UIColor redColor]];
    }
    return _modifyButton;
}

- (UILabel *)nameDesLabel{
    if (!_nameDesLabel) {
        _nameDesLabel = [[UILabel alloc] initWithCustomFont:20.f];
        _nameDesLabel.text = @"昵称：";
        _nameDesLabel.textColor = [UIColor whiteColor];
        _nameDesLabel.textAlignment = NSTextAlignmentRight;
    }
    return _nameDesLabel;
}

- (UILabel *)birthdayDesLabel{
    if (!_birthdayDesLabel) {
        _birthdayDesLabel = [[UILabel alloc] initWithCustomFont:20.f];
        _birthdayDesLabel.text = @"生日：";
        _birthdayDesLabel.textColor = [UIColor whiteColor];
        _birthdayDesLabel.textAlignment = NSTextAlignmentRight;
    }
    return _birthdayDesLabel;
}

- (UILabel *)coinDesLabel{
    if (!_coinDesLabel) {
        _coinDesLabel = [[UILabel alloc] initWithCustomFont:20.f];
        _coinDesLabel.text = @"金币：";
        _coinDesLabel.textColor = [UIColor whiteColor];
        _coinDesLabel.textAlignment = NSTextAlignmentRight;
    }
    return _coinDesLabel;
}

- (UILabel *)brushDesLabel{
    if (!_brushDesLabel) {
        _brushDesLabel = [[UILabel alloc] initWithCustomFont:20.f];
        _brushDesLabel.text = @"正在使用牙刷：";
        _brushDesLabel.textColor = [UIColor whiteColor];
        _brushDesLabel.textAlignment = NSTextAlignmentRight;
    }
    return _brushDesLabel;
}

@end
