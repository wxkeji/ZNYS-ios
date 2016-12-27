//
//  UserDetailsViewController.m
//  ZNYS
//
//  Created by yu243e on 16/12/23.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "UserDetailsViewController.h"
#import "UserManager.h"

@interface UserDetailsViewController ()

@property (nonatomic, strong) UIButton *backgroundButton;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIImageView *topContentView;
@property (nonatomic, strong) UIButton *closeOrConfirmButton;

@property (nonatomic, strong) UIImageView *switcherView;
@property (nonatomic, strong) UICollectionView *switchCollectionView;

@property (nonatomic, assign) BOOL isCloseButton;   //button 状态
@property (nonatomic, assign) BOOL hasSwitchView;   //是否有两个用户
@property (nonatomic, assign) BOOL userCount;

@end

static const CGFloat mainHeight = 200;
static const CGFloat switcherHeight = 100;

@implementation UserDetailsViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.backgroundButton];
    [self.backgroundButton addTarget:self action:@selector(backgroundButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.topContentView];
    self.topContentView.userInteractionEnabled = YES;
    
    [self.topContentView addSubview:self.closeOrConfirmButton];
    self.isCloseButton = true;
    [self settingButtonState];
    [self.closeOrConfirmButton addTarget:self action:@selector(closeOrConfirmButtonTap) forControlEvents:UIControlEventTouchUpInside];
    
    self.hasSwitchView = [self judgeSwitchView];    //初始化时判断一次
    //??? yu 是否可能造成状态不一致？
    if (self.hasSwitchView) {
        [self.contentView addSubview:self.switcherView];
    }
    
    [self setupConstraintsForSubviews];
}

- (void)setupConstraintsForSubviews {
    [self.backgroundButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top);
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.height.mas_equalTo(kSCREEN_HEIGHT);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top);
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.height.mas_equalTo(mainHeight + switcherHeight);
    }];
    
    [self.topContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top);
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.height.mas_equalTo(mainHeight);
    }];
    [self.closeOrConfirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).with.offset(-MIN_EDGE_X);
        make.top.equalTo(self.topContentView.mas_top).offset(NAVIGATION_BUTTON_Y);
        make.width.mas_equalTo(MIN_BUTTON_H_W);
        make.height.mas_equalTo(MIN_BUTTON_H_W);
    }];
    if (self.hasSwitchView) {
        [self.switcherView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(mainHeight);
            make.width.mas_equalTo(kSCREEN_WIDTH);
            make.left.equalTo(self.view.mas_left);
            make.height.mas_equalTo(switcherHeight);
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - event response
- (void)backgroundButtonClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)closeOrConfirmButtonTap {
    if (self.isCloseButton) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark - private methods
- (BOOL)judgeSwitchView {
    return [[UserManager sharedInstance] currentUserCount] > 1;
}
- (void)settingButtonState {
    if (self.isCloseButton) {
        [self.closeOrConfirmButton setImage:[UIImage themedImageWithNamed:@"user/close"] forState:UIControlStateNormal];
    } else {
        [self.closeOrConfirmButton setImage:[UIImage themedImageWithNamed:@"user/confirm"] forState:UIControlStateNormal];
    }
}

#pragma mark - getters and setters
- (UIView *)backgroundButton {
    if (!_backgroundButton) {
        _backgroundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backgroundButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    }
    return _backgroundButton;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (UIImageView *)topContentView {
    if (!_topContentView) {
        _topContentView = [[UIImageView alloc] init];
        _topContentView.backgroundColor = [UIColor colorWithThemedImageNamed:@"color/primary_dark"];
    }
    return _topContentView;
}
- (UIImageView *)switcherView {
    if (!_switcherView) {
        _switcherView = [[UIImageView alloc] init];
        _switcherView.backgroundColor = [UIColor colorWithThemedImageNamed:@"color/primary"];
    }
    return _switcherView;
}
- (UIScrollView *)switchCollectionView {
    if (!_switchCollectionView) {
        _switchCollectionView = [[UICollectionView alloc] init];
        _switchCollectionView.backgroundColor = [UIColor clearColor];
    }
    return _switchCollectionView;
}
- (UIButton *)closeOrConfirmButton {
    if (!_closeOrConfirmButton) {
        _closeOrConfirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _closeOrConfirmButton;
}

@end
