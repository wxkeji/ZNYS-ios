//
//  UserAccountViewController.m
//  ZNYS
//
//  Created by Ellise on 16/1/5.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "UserAccountViewController.h"
#import "UserDetailView.h"

@interface UserAccountViewController ()

@property (nonatomic,strong) UIView * navView;

@property (nonatomic,strong) UIButton * dismissButton;

@property (nonatomic,strong) UILabel * titleLabel;

@property (nonatomic,strong) UserDetailView * userDetailView;

@end

@implementation UserAccountViewController

#pragma mark life cycle

- (void)dealloc{
    _navView = nil;
    _dismissButton = nil;
    _userDetailView = nil;
    _titleLabel = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
  
    [self.view addSubview:self.navView];
    [self.navView addSubview:self.dismissButton];
    [self.navView addSubview:self.titleLabel];
    [self.view addSubview:self.userDetailView];
    
    WS(weakSelf, self);
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).with.offset(0);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.height.mas_equalTo(0.115*kSCREEN_HEIGHT);
    }];
    
    [self.dismissButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.navView.mas_top).with.offset(0.052*kSCREEN_HEIGHT);
        make.left.equalTo(weakSelf.navView.mas_left).with.offset(0.04*kSCREEN_WIDTH);
        make.width.mas_equalTo(0.085*kSCREEN_WIDTH);
        make.height.mas_equalTo(0.085*kSCREEN_WIDTH);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.navView.mas_centerX);
        make.centerY.mas_equalTo(weakSelf.dismissButton.mas_centerY);
        make.height.mas_equalTo(0.04*kSCREEN_HEIGHT);
    }];
    
    [self.userDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.navView.mas_bottom).with.offset(0);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.height.mas_equalTo(0.509*kSCREEN_HEIGHT);
    }];
}

#pragma mark private method

#pragma mark event action

- (void)dismissButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark getters and setters

- (UIView *)navView{
    if (!_navView) {
        _navView = [[UIView alloc] init];
        _navView.backgroundColor = [UIColor purpleColor];
    }
    return _navView;
}

- (UIButton *)dismissButton{
    if (!_dismissButton) {
        _dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dismissButton setImage:[UIImage imageNamed:@"userAccount_back"] forState:UIControlStateNormal];
        [_dismissButton addTarget:self action:@selector(dismissButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dismissButton;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithCustomFont:23.f];
        _titleLabel.text = @"用户管理";
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UserDetailView *)userDetailView{
    if (!_userDetailView) {
        _userDetailView = [[UserDetailView alloc] init];
    }
    return _userDetailView;
}

@end
