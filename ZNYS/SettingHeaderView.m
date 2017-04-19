//
//  SettingHeaderView.m
//  ZNYS
//
//  Created by Ellise on 16/1/4.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "SettingHeaderView.h"
#import "UserManager.h"

@interface SettingHeaderView()

@property (nonatomic,strong) UILabel * titleLabel;

@property (nonatomic,strong) UIButton * dismissButton;




@end

@implementation SettingHeaderView

#pragma mark life cycle
- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.dismissButton];
        [self addSubview:self.thumbButton];
        [self addSubview:self.nameLabel];
        
        WS(weakSelf, self);
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_top).with.offset(0.042*kSCREEN_HEIGHT);
            make.centerX.mas_equalTo(weakSelf.mas_centerX);
            make.height.mas_equalTo(0.042*kSCREEN_HEIGHT);
        }];
        
        [self.dismissButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_top).with.offset(0.042*kSCREEN_HEIGHT);
            make.left.equalTo(weakSelf.mas_left).with.offset(MIN_EDGE_X);
            make.width.mas_equalTo(35);
            make.height.mas_equalTo(35);
        }];
        
        [self.thumbButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf.mas_centerX);
            make.bottom.equalTo(weakSelf.nameLabel.mas_top).with.offset(-0.015*kSCREEN_HEIGHT);
            make.height.mas_equalTo(0.125*kSCREEN_HEIGHT);
            make.width.mas_equalTo(0.125*kSCREEN_HEIGHT);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-0.020*kSCREEN_HEIGHT);
            make.centerX.mas_equalTo(weakSelf.mas_centerX);
            make.height.mas_equalTo(0.037*kSCREEN_HEIGHT);
        }];
        [self configureTheme];
    }
    return self;
}

#pragma mark - public method
- (void)configureTheme {
    self.backgroundColor = [UIColor colorWithThemedImageNamed:@"color/primary"];
    [self.dismissButton setImage:[UIImage themedImageWithNamed:@"navigation/dismissButton"] forState:UIControlStateNormal];
}

#pragma mark event action

- (void)dismissButtonAction{
    if (self.dismissButtonBlock) {
        self.dismissButtonBlock();
    }
}

- (void)thumbButtonAction{
    if (self.thumbButtonBlock) {
        self.thumbButtonBlock();
    }
}

#pragma mark getters and setters

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithCustomFont:25.f];
        _titleLabel.text = @"设置";
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UIButton *)dismissButton{
    if (!_dismissButton) {
        _dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dismissButton addTarget:self action:@selector(dismissButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _dismissButton;
}

- (UIButton *)thumbButton{
    if (!_thumbButton) {
        _thumbButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _thumbButton.backgroundColor = [UIColor yellowColor];
        [_thumbButton addTarget:self action:@selector(thumbButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_thumbButton setImage:[[UserManager sharedInstance] currentUserAvatarImage] forState:UIControlStateNormal];
    }
    return _thumbButton;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithCustomFont:25.f];
        _nameLabel.text = [[UserManager sharedInstance] currentUser].nickName;
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}

@end
