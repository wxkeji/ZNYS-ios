//
//  ChildrenHomeViewController.m
//  ZNYS
//
//  Created by yu243e on 16/8/30.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ChildrenHomeViewController.h"
#import "UserInformationView.h"
#import "UserDetailsViewController.h"

//模态presetation
#import "ModalPresentationController.h"

#import "ThemeManager.h"
#import "UserManager.h"

#import "TopRackView.h"
#import "DownRackView.h"
#import "ToothBrushFindViewController.h"

//点击跳转
#import "CalendarViewController.h"
#import "VerifyPasswordViewController.h"
#import "ConnectedResultView.h"
#import "MAKAFakeRootAlertView.h"
#import "ExchangeRewardViewController.h"

@interface ChildrenHomeViewController ()<TopRackViewDataSource, DownRackViewDataSource>

@property (nonatomic, strong) UIImageView *backgroundImageViewTop;
@property (nonatomic, strong) UIImageView *backgroundLogoImageView;

@property (nonatomic, strong) UIButton *settingButton;
@property (nonatomic, strong) UIButton *awardButton;
@property (nonatomic, strong) UIButton *calendarButton;

@property (nonatomic, strong) UserInformationView *userInformationView;
@property (nonatomic, strong) UIButton *userDetailsButton;

@property (nonatomic, strong) UIImageView *awardTopRackImageView;
@property (nonatomic, strong) UIImageView *awardDownRackImageView;

@property (nonatomic, strong) TopRackView *topRackView;
@property (nonatomic, strong) DownRackView *downRackView;

@property (nonatomic, strong) UIButton *connectToothBrushButton;

@end

@implementation ChildrenHomeViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.nav.hidden = YES;
    
    //加入滑动返回 但是可能会造成 strange effects
    //http://stackoverflow.com/questions/24710258/no-swipe-back-when-hiding-navigation-bar-in-uinavigationcontroller
    [self.navigationController.interactivePopGestureRecognizer setDelegate:nil];
    
    [self.view addSubview:self.backgroundImageViewTop];
    [self.view addSubview:self.backgroundLogoImageView];
    
    [self.view addSubview:self.settingButton];
    [self.view addSubview:self.awardButton];
    [self.view addSubview:self.calendarButton];
    
    [self.view addSubview:self.userInformationView];
    [self.view addSubview:self.userDetailsButton];
    
    [self.view addSubview:self.awardTopRackImageView];
    [self.view addSubview:self.awardDownRackImageView];
    
    [self.view addSubview:self.topRackView];
    [self.view addSubview:self.downRackView];
    
    [self.view addSubview:self.connectToothBrushButton];
    
    [self setupConstraintsForSubviews];
    
    [self.settingButton addTarget:self action:@selector(toSetting) forControlEvents:UIControlEventTouchUpInside];
    [self.awardButton addTarget:self action:@selector(toExchangeReward) forControlEvents:UIControlEventTouchUpInside];
    [self.calendarButton addTarget:self action:@selector(toCalendar) forControlEvents:UIControlEventTouchUpInside];
    [self.userDetailsButton addTarget:self action:@selector(expandUserDetailInformation) forControlEvents:UIControlEventTouchUpInside];
    
    [self.connectToothBrushButton addTarget:self action:@selector(connectButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    //设置用户详细信息和主题
    [self userDetailChange];
    
    //为用户改变做注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDetailChange) name:@"userDidSwitch" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDetailChange) name:@"userDidCreate" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDetailChange) name:@"userDetailDidChange" object:nil];
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
    
    [self.userDetailsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.userInformationView.mas_top).offset(-NAVGATION_USER_INTERVAL/2.);
        make.bottom.equalTo(weakSelf.userInformationView.mas_bottom).offset(NAVGATION_USER_INTERVAL/2.);
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.left.equalTo(self.view.mas_left);
    }];//覆盖 userInformationView
    
    [self.awardTopRackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.top.equalTo(self.view.mas_top).offset(CustomHeight(332));
        make.height.mas_equalTo(16);
    }];
    [self.awardDownRackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.top.equalTo(self.view.mas_top).offset(CustomHeight(478));
        make.height.mas_equalTo(20);
    }];
    
    [self.topRackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(50);
        make.right.equalTo(self.view.mas_right).offset(-50);
        make.bottom.equalTo(self.awardTopRackImageView.mas_top).offset(0);
        make.height.mas_equalTo(100);
    }];//奖牌60x60
    
    [self.downRackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.bottom.equalTo(self.awardDownRackImageView.mas_top);
        make.height.mas_equalTo(ZNYSGetSizeByWidth(88, 108, 108));
    }];//奖励100x100
    
    [self.connectToothBrushButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.bottom.equalTo(weakSelf.view.mas_bottom).with.offset(CustomHeight(-30));
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];//连接按钮100x100
    
}

- (void)dealloc {
    //销毁观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - TopRackViewDataSource
- (NSUInteger)numberOfItemsInTopRack {
    return 10;
}

- (UIImage *)topRackItemImageAtIndex:(NSUInteger)index {
    NSInteger userLevel = [[UserManager sharedInstance] currentUser].level;
    
    NSString *imageName = [NSString stringWithFormat:@"奖牌%lu", (index + 1)];
    UIImage *image = [UIImage imageNamed:imageName];
    
    if ((index + 1) > userLevel) {
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    return image;
    
}

#pragma mark - DownRackViewDataSource
- (NSUInteger)numberOfItemsInDownRack {
    return 5;
}

- (UIImage *)downRackItemImageAtIndex:(NSUInteger)index {
    NSString *imageName = [NSString stringWithFormat:@"奖励%lu", (index + 1)];
    UIImage *image = [UIImage imageNamed:imageName];
    
    if ((index + 1) > 2) {
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    return image;
    
}

#pragma mark - private method
- (void)configureTheme {
    self.backgroundImageViewTop.image = [UIImage themedImageWithNamed:@"color/primary"];
    self.backgroundLogoImageView.image = [UIImage themedImageWithNamed:@"logo"];
    
    [self.settingButton setImage:[UIImage themedImageWithNamed:@"navigation/settingButton"] forState:UIControlStateNormal];
    [self.calendarButton setImage:[UIImage themedImageWithNamed:@"navigation/calendarButton"] forState:UIControlStateNormal];
    [self.awardButton setImage:[UIImage themedImageWithNamed:@"navigation/awardButton"] forState:UIControlStateNormal];
    
    [self.awardTopRackImageView setImage:[UIImage themedImageWithNamed:@"childrenHome/奖励架1"]];
    [self.awardDownRackImageView setImage:[UIImage themedImageWithNamed:@"childrenHome/奖励架2"]];
    
    [self.connectToothBrushButton setImage:[UIImage themedImageWithNamed:@"childrenHome/connectButton"] forState:UIControlStateNormal];
    
    [self.topRackView configureTheme];
    [self.downRackView configureTheme];
}

- (void)userDetailChange {
    [self.userInformationView userSwitch];
    [self.topRackView reloadData];
    [self.downRackView reloadData];
    
    ZNYSThemeStyle themeStyle = [ThemeManager sharedManager].themeStyle;
    ZNYSThemeStyle newStyle = [[UserManager sharedInstance] currentUserThemeStyle];
    if (themeStyle != newStyle) {
        [[ThemeManager sharedManager] configureTheme:newStyle];
    }
    
    [self configureTheme];
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
    UserDetailsViewController * modalViewController = [[UserDetailsViewController alloc] init];
    
    //因为没有被强持有，必须用NS_VALID_UNTIL_END_OF_SCOPE 保持其存在
    //参考 APPLE Custom View Controller Presentations and Transitions
    ModalPresentationController *presentationController NS_VALID_UNTIL_END_OF_SCOPE;
    presentationController = [[ModalPresentationController alloc] initWithPresentedViewController:modalViewController presentingViewController:self];
    [presentationController setModalStyle:CHYCModalPresentationStyleFromTop];
    
    modalViewController.transitioningDelegate = presentationController;
    
    modalViewController.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:modalViewController animated:YES completion:nil];
}

//在这里加入连接牙刷的代码
- (void)connectButtonClicked {
    UIViewController *vc = [[ToothBrushFindViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    vc.view.backgroundColor = [UIColor clearColor];
    [self presentViewController:vc animated:YES completion:nil];
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

- (UIButton *)userDetailsButton {
    if (!_userDetailsButton) {
        _userDetailsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _userDetailsButton.backgroundColor = [UIColor clearColor];
        [_userDetailsButton setBackgroundImage:[UIImage imageWithColor:RGBACOLOR(0, 0, 0, BUTTON_TOUCH_ALPHA)] forState:UIControlStateHighlighted];
    }
    return _userDetailsButton;
}

- (UIImageView *)awardTopRackImageView {
    if (!_awardTopRackImageView) {
        _awardTopRackImageView = [[UIImageView alloc] init];
    }
    return _awardTopRackImageView;
}
- (UIImageView *)awardDownRackImageView {
    if (!_awardDownRackImageView) {
        _awardDownRackImageView = [[UIImageView alloc] init];
    }
    return _awardDownRackImageView;
}

- (TopRackView *)topRackView {
    if (!_topRackView) {
        _topRackView = [[TopRackView alloc] init];
        _topRackView.datasource = self;
    }
    return _topRackView;
}
- (DownRackView *)downRackView {
    if (!_downRackView) {
        _downRackView = [[DownRackView alloc] init];
        _downRackView.datasource = self;
    }
    return _downRackView;
}

- (UIButton *)connectToothBrushButton {
    if (!_connectToothBrushButton) {
        _connectToothBrushButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _connectToothBrushButton;
}
@end
