//
//  SettingViewController.m
//  ZNYS
//
//  Created by Ellise on 16/1/4.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingButtonView.h"
#import "SettingHeaderView.h"

@interface SettingViewController ()

@property (nonatomic,strong) SettingHeaderView * headerView;

@property (nonatomic,strong) SettingButtonView * buttonView;

@property (nonatomic,strong) UIImageView * logoImage;

@end

@implementation SettingViewController

#pragma mark life cycle

- (void)dealloc{
    _headerView = nil;
    _buttonView = nil;
    _logoImage = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.buttonView];
//    [self.view addSubview:self.logoImage];
    
    WS(weakSelf, self);
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.height.mas_equalTo(0.298*kSCREEN_HEIGHT);
    }];
    
    [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.top.equalTo(weakSelf.headerView.mas_bottom).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.bottom.equalTo(weakSelf.view.mas_bottom).with.offset(0);
    }];
    
//    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(weakSelf.buttonView.mas_top).with.offset(0.063*kSCREEN_HEIGHT);
//        make.left.equalTo(weakSelf.view.mas_left).with.offset(0.064*kSCREEN_WIDTH);
//        make.width.mas_equalTo(0.36*kSCREEN_WIDTH);
//        make.height.mas_equalTo(0.36*kSCREEN_WIDTH);
//    }];
}

#pragma mark private method

#pragma mark event action

#pragma mark getters and setters

- (SettingButtonView *)buttonView{
    if (!_buttonView) {
        _buttonView = [[SettingButtonView alloc] init];
    }
    return _buttonView;
}

- (SettingHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[SettingHeaderView alloc] init];
        
        WS(weakSelf, self);
        _headerView.dismissButtonBlock = ^{
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        };
        
        _headerView.thumbButtonBlock = ^{
           
        };
    }
    return _headerView;
}

- (UIImageView *)logoImage{
    if (!_logoImage) {
        _logoImage = [[UIImageView alloc] init];
        _logoImage.backgroundColor = [UIColor redColor];
        [_logoImage setImage:[UIImage imageNamed:@"userAccount_logo"]];
    }
    return _logoImage;
}

@end
