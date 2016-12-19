//
//  UserAccountViewController.m
//  ZNYS
//
//  Created by Ellise on 16/1/5.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "UserAccountViewController.h"
#import "AddAccountViewController.h"
#import "UserDetailView.h"
#import "SwitchUserView.h"
#import "UserManager.h"
#import "CoreDataHelper.h"

@interface UserAccountViewController ()

@property (nonatomic,strong) UIView * navView;

@property (nonatomic,strong) UIButton * dismissButton;

@property (nonatomic,strong) UILabel * titleLabel;

@property (nonatomic,strong) UserDetailView * userDetailView;

@property (nonatomic,strong) SwitchUserView * switchUserView;

@property (nonatomic,strong) UIView * switchBackView;

@property (nonatomic,strong) UILabel * switchDesLabel;

@end

@implementation UserAccountViewController

#pragma mark life cycle

- (void)dealloc{
    _navView = nil;
    _dismissButton = nil;
    _userDetailView = nil;
    _titleLabel = nil;
    _switchUserView = nil;
    _switchBackView = nil;
    _switchDesLabel = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
  
    [self.view addSubview:self.navView];
    [self.navView addSubview:self.dismissButton];
    [self.navView addSubview:self.titleLabel];
    [self.view addSubview:self.userDetailView];
    [self.view addSubview:self.switchBackView];
    [self.switchBackView addSubview:self.switchUserView];
    [self.switchBackView addSubview:self.switchDesLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshDetail) name:@"userDetailDidChange" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newUserDetail) name:@"userDidCreate" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpToAddUserAccount) name:@"AddUserActionDidPost" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newUserDetail) name:@"userDidSwitch" object:nil];
    
    WS(weakSelf, self);
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).with.offset(0);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.height.mas_equalTo(CustomHeight(75));
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
        make.height.mas_equalTo(0.459*kSCREEN_HEIGHT);
    }];
    
    [self.switchUserView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.switchBackView.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.switchBackView.mas_right).with.offset(0);
        make.top.equalTo(weakSelf.switchBackView.mas_top).with.offset(0.088*kSCREEN_HEIGHT);
        make.height.mas_equalTo(0.3*kSCREEN_HEIGHT);
    }];
    
    [self.switchBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.top.equalTo(weakSelf.userDetailView.mas_bottom).with.offset(0);
        make.bottom.equalTo(weakSelf.view.mas_bottom).with.offset(0);
    }];
    
    [self.switchDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.switchBackView.mas_left).with.offset(0.072*kSCREEN_WIDTH);
        make.top.equalTo(weakSelf.switchBackView.mas_top).with.offset(0.034*kSCREEN_HEIGHT);
        make.height.mas_equalTo(0.03*kSCREEN_HEIGHT);
    }];
}

#pragma mark private method

- (void)jumpToAddUserAccount{
    AddAccountViewController * viewController = [[AddAccountViewController alloc] init];
//    viewController.addAccountView.titleLabel.text = @"添加新用户";
//    viewController.addAccountView.nameTextField.placeholder = @"宝宝";
//    [viewController.addAccountView.nameTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
//    [viewController.addAccountView.birthButton setTitle:@"1996-01-01" forState:UIControlStateNormal];
    viewController.style = 2;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)refreshDetail{
    self.userDetailView.birthdayLabel.text = [[UserManager sharedInstance] currentUserBirthday];
    self.userDetailView.nameLabel.text = [[UserManager sharedInstance] currentUserName];
    self.userDetailView.brushLabel.text = [NSString stringWithFormat:@"%ld把",(long)[[UserManager sharedInstance] currentUsersNumberOfToothBushes]];
    self.userDetailView.coinLabel.text = [NSString stringWithFormat:@"%ld",(long)[[UserManager sharedInstance] currentUserTokenOwned]];
    //头像变化
}

- (void)newUserDetail{
    self.switchUserView.dataArray = [[CoreDataHelper sharedInstance] retrieveOtherUsersExcept:[[NSUserDefaults standardUserDefaults] objectForKey:@"currentUserUID"]];
    [self.switchUserView refresh];
    [self refreshDetail];
}
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
        
        WS(weakSelf, self);
        _userDetailView.modifyButtonBlock = ^{
            AddAccountViewController * viewController = [[AddAccountViewController alloc] init];
//            viewController.addAccountView.titleLabel.text = @"修改用户";
            viewController.style = 0;
            [weakSelf.navigationController pushViewController:viewController animated:YES];
        };
    }
    return _userDetailView;
}

- (SwitchUserView *)switchUserView{
    if (!_switchUserView) {
        _switchUserView = [[SwitchUserView alloc] init];
    }
    return _switchUserView;
}

- (UIView *)switchBackView{
    if (!_switchBackView) {
        _switchBackView = [[UIView alloc] init];
        _switchBackView.backgroundColor =[UIColor whiteColor];
    }
    return _switchBackView;
}

- (UILabel *)switchDesLabel{
    if (!_switchDesLabel) {
        _switchDesLabel = [[UILabel alloc] initWithCustomFont:18.f];
        _switchDesLabel.text = @"切换宝宝：";
        _switchDesLabel.textColor = [UIColor blackColor];
    }
    return _switchDesLabel;
}

@end
