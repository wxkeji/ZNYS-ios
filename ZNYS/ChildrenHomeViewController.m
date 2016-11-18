//
//  ChildrenHomeViewController.m
//  ZNYS
//
//  Created by yu243e on 16/8/30.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ChildrenHomeViewController.h"
#import "UserInformationView.h"
#import "UserDetailInformationView.h"

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
@property (nonatomic, strong) UIButton *userDetailInformationButton;
@property (nonatomic, strong) UserDetailInformationView *userDetailInformationView;

@property (nonatomic, strong) UIButton *connectToothBrushButton;

@property (nonatomic, strong) UIButton *modalViewBackgroundButton;
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
    [self.view addSubview:self.userDetailInformationButton];
    
    [self.view addSubview:self.connectToothBrushButton];
    
    [[ThemeManager sharedManager] configureThemeWithNamed:@"boy"];
    [self configureTheme];
    
    [self setupConstraintsForSubviews];
    
    [self.settingButton addTarget:self action:@selector(toSetting) forControlEvents:UIControlEventTouchUpInside];
    [self.awardButton addTarget:self action:@selector(toExchangeReward) forControlEvents:UIControlEventTouchUpInside];
    [self.calendarButton addTarget:self action:@selector(toCalendar) forControlEvents:UIControlEventTouchUpInside];
    [self.userDetailInformationButton addTarget:self action:@selector(expandUserDetailInformation) forControlEvents:UIControlEventTouchUpInside];
    
    [self.connectToothBrushButton addTarget:self action:@selector(toConnectedResult) forControlEvents:UIControlEventTouchUpInside];
    
    [self.modalViewBackgroundButton addTarget:self action:@selector(disMissModalViewBackground) forControlEvents:UIControlEventTouchUpInside];
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
        make.left.equalTo(weakSelf.view.mas_left).with.offset(MIN_EDGE_X);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(NAVIGATION_BUTTON_Y);
        make.width.mas_equalTo(MIN_BUTTON_H_W);
        make.height.mas_equalTo(MIN_BUTTON_H_W);
    }];
    
    [self.awardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-CustomWidth(20) - MIN_BUTTON_H_W - MIN_EDGE_X);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(NAVIGATION_BUTTON_Y);
        make.width.mas_equalTo(MIN_BUTTON_H_W);
        make.height.mas_equalTo(MIN_BUTTON_H_W);
    }];
    
    [self.calendarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-MIN_EDGE_X);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(NAVIGATION_BUTTON_Y);
        make.width.mas_equalTo(MIN_BUTTON_H_W);
        make.height.mas_equalTo(MIN_BUTTON_H_W);
    }];
    
    [self.userInformationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(USER_INFORMATIN_Y);
        make.height.mas_equalTo(MIN_BUTTON_H_W);
    }];
    
    [self.userDetailInformationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.userInformationView.mas_top).offset(-NAVGATION_USER_INTERVAL/2.);
        make.bottom.equalTo(weakSelf.userInformationView.mas_bottom).offset(NAVGATION_USER_INTERVAL/2.);
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.left.equalTo(self.view.mas_left);
    }];//覆盖 userInformationView
    
    [self.connectToothBrushButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.bottom.equalTo(weakSelf.view.mas_bottom).with.offset(CustomHeight(-30));
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];//连接按钮100x100
    
}

#pragma mark - UserDetailInformationViewDelegate
- (void)dismissUserDetailView {
    [self disMissModalViewBackground];
}

#pragma mark - private method
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

- (void)expandUserDetailInformation {
    [self showModalViewBackground];
    [self.modalViewBackgroundButton addSubview:self.userDetailInformationView];
    self.userDetailInformationView.delegate = self;
    [self.userDetailInformationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(self.view.mas_top);
    }]; //  不需要高度和宽度，已在 view 中定义 intrinsic
    [self.view layoutIfNeeded];
    [self.userDetailInformationView showAnimationWithDelay:modalAnimationDuration];
}

- (void)toConnectedResult {
    
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

/*
 *  模态弹窗相关
 */
static const NSTimeInterval modalAnimationDuration = 0.3;
- (void)showModalViewBackground {
    self.modalViewBackgroundButton.frame = self.userDetailInformationButton.frame;
    self.modalViewBackgroundButton.alpha = 0.6;
    [self.view addSubview:self.modalViewBackgroundButton];
    [UIView animateWithDuration:modalAnimationDuration animations:^{
        self.modalViewBackgroundButton.frame = self.view.bounds;
        self.modalViewBackgroundButton.alpha = 1.0;
    }];
}
- (void)disMissModalViewBackground {
    WS(weakSelf, self);
    NSTimeInterval delay = [self.userDetailInformationView showCloseAnimation];
    [UIView animateWithDuration:modalAnimationDuration
                          delay:delay
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        weakSelf.modalViewBackgroundButton.alpha = 0.0;
    }
                     completion:^(BOOL finished) {
                         [self.userDetailInformationView removeFromSuperview];
                         [self.modalViewBackgroundButton removeFromSuperview];
                         self.userDetailInformationView = nil;
                         self.modalViewBackgroundButton.frame = self.userDetailInformationButton.frame;
    }];
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

- (UIButton *)userDetailInformationButton {
    if (!_userDetailInformationButton) {
        _userDetailInformationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _userDetailInformationButton.backgroundColor = [UIColor clearColor];
        [_userDetailInformationButton setBackgroundImage:[UIImage imageWithColor:RGBACOLOR(0, 0, 0, BUTTON_TOUCH_ALPHA)] forState:UIControlStateHighlighted];
    }
    return _userDetailInformationButton;
}
- (UserDetailInformationView *)userDetailInformationView {
    if (!_userDetailInformationView) {
        _userDetailInformationView = [[UserDetailInformationView alloc] init];
    }
    return _userDetailInformationView;
}

- (UIButton *)connectToothBrushButton {
    if (!_connectToothBrushButton) {
        _connectToothBrushButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _connectToothBrushButton;
}

- (UIButton *)modalViewBackgroundButton {
    if (!_modalViewBackgroundButton) {
        _modalViewBackgroundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _modalViewBackgroundButton.opaque = NO;
        _modalViewBackgroundButton.backgroundColor = RGBACOLOR(0, 0, 0, MODAL_ALPHA);
    }
    return _modalViewBackgroundButton;
}
@end
