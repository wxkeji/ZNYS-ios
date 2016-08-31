//
//  ChildrenHomeViewController.m
//  ZNYS
//
//  Created by yu243e on 16/8/30.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ChildrenHomeViewController.h"
#import "UserInformationView.h"

//点击跳转
#import "CalendarViewController.h"
#import "VerifyPasswordViewController.h"
#import "ConnectedResultView.h"
#import "MAKAFakeRootAlertView.h"
#import "ExchangeRewardViewController.h"

@interface ChildrenHomeViewController ()

@property (nonatomic, strong) UIImageView *backgroundImageViewTop;
@property (nonatomic, strong) UIImageView *backgroundLogoImageView;

@property (nonatomic, strong) UIButton *settingButton;
@property (nonatomic, strong) UIButton *awardButton;
@property (nonatomic, strong) UIButton *calendarButton;

@property (nonatomic, strong) UserInformationView *userInformationView;

@property (nonatomic, strong) UIButton *connectToothBrushButton;

@end

@implementation ChildrenHomeViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.nav.hidden = YES;
    
    [self.view addSubview:self.backgroundImageViewTop];
    [self.view addSubview:self.backgroundLogoImageView];
    
    [self.view addSubview:self.settingButton];
    [self.view addSubview:self.awardButton];
    [self.view addSubview:self.calendarButton];
    
    [self.view addSubview:self.userInformationView];

    [self.view addSubview:self.connectToothBrushButton];
    
    [[ThemeManager sharedManager] configureThemeWithNamed:@"boy"];
    [self configureTheme];
    
    [self setupConstraintsForSubviews];
    
    [self.settingButton addTarget:self action:@selector(toSetting) forControlEvents:UIControlEventTouchUpInside];
    [self.awardButton addTarget:self action:@selector(toExchangeReward) forControlEvents:UIControlEventTouchUpInside];
    [self.calendarButton addTarget:self action:@selector(toCalendar) forControlEvents:UIControlEventTouchUpInside];
    [self.connectToothBrushButton addTarget:self action:@selector(toConnectedResult) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupConstraintsForSubviews {
    WS(weakSelf, self);
    CGFloat logoHeight = CustomHeight(85);
    //logo 不包括突出部分高度
    CGFloat logoBaseHeight = logoHeight*125.62601f/152.f;
    CGFloat navigationAndUserHeight = 20+52+52;
    [self.backgroundImageViewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.top.equalTo(weakSelf.view.mas_top);
        make.bottom.equalTo(weakSelf.view.mas_top).with.offset(navigationAndUserHeight + logoHeight);
    }];
    
    [self.backgroundLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.backgroundImageViewTop.mas_bottom).offset(logoHeight -logoBaseHeight);
        make.height.mas_equalTo(logoHeight);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
    }];//选择适合6的分辨率 缩放使用
    
    [self.settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(15);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(28);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
    }];
    
    [self.awardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-CustomWidth(20) - 44 - 15);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(28);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
    }];
    
    [self.calendarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-15);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(28);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
    }];
    
    [self.userInformationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(80);
    }];
    
    [self.connectToothBrushButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.bottom.equalTo(weakSelf.view.mas_bottom).with.offset(CustomHeight(-30));
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];//连接按钮100x100
}

#pragma mark private method
- (void)configureTheme {
    self.backgroundImageViewTop.image = [UIImage themedImageWithNamed:@"color/primary"];
    self.backgroundLogoImageView.image = [UIImage themedImageWithNamed:@"children/logo"];
    
    [self.settingButton setImage:[UIImage themedImageWithNamed:@"navigation/settingButton"] forState:UIControlStateNormal];
    [self.calendarButton setImage:[UIImage themedImageWithNamed:@"navigation/calendarButton"] forState:UIControlStateNormal];
    [self.awardButton setImage:[UIImage themedImageWithNamed:@"navigation/awardButton"] forState:UIControlStateNormal];
    [self.connectToothBrushButton setImage:[UIImage themedImageWithNamed:@"childrenHome/connectButton"] forState:UIControlStateNormal];
}

#pragma mark event action
- (void)toCalendar {
    CalendarViewController * vc = [[CalendarViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)toSetting {
    VerifyPasswordViewController * viewController = [[VerifyPasswordViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)toConnectedResult {
    
    //无意义frame
    ConnectedResultView * connectedView = [[ConnectedResultView alloc]initWithFrame:CGRectZero];
    MAKAFakeRootAlertView * alertView = [[MAKAFakeRootAlertView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [alertView setUpView:connectedView];
    connectedView.dismissBlock = ^{
        [alertView dismiss];
    };
    alertView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [alertView show];
}

- (void)toExchangeReward {
    ExchangeRewardViewController * vc = [[ExchangeRewardViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark getters and setters
- (UIView *)backgroundImageViewTop{
    if (!_backgroundImageViewTop) {
        _backgroundImageViewTop = [[UIImageView alloc] init];
        _backgroundImageViewTop.contentMode = UIViewContentModeScaleToFill;
    }
    return _backgroundImageViewTop;
}

- (UIView *)backgroundLogoImageView{
    if (!_backgroundLogoImageView) {
        _backgroundLogoImageView = [[UIImageView alloc] init];
        _backgroundLogoImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _backgroundLogoImageView;
}

- (UIButton *)settingButton{
    if (!_settingButton) {
        _settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _settingButton;
}

- (UIButton *)awardButton{
    if (!_awardButton) {
        _awardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _awardButton;
}

- (UIButton *)calendarButton{
    if (!_calendarButton) {
        _calendarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _calendarButton;
}


- (UserInformationView *)userInformationView {
    if (!_userInformationView) {
        _userInformationView = [[UserInformationView alloc]init];
    }
    return _userInformationView;
}

- (UIButton *)connectToothBrushButton {
    if (!_connectToothBrushButton) {
        _connectToothBrushButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _connectToothBrushButton;
}

@end
