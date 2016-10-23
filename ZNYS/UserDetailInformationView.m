//
//  UserDetailInformationView.m
//  ZNYS
//
//  Created by yu243e on 16/10/5.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "UserDetailInformationView.h"
@interface UserDetailInformationView()

@property (nonatomic, strong) UIImageView *mainBackgroundImageView;

@property (nonatomic, strong) UIImageView *switchBackgroundImageView;

@property (nonatomic, strong) UIButton *closeOrConfirmButton;
@property (nonatomic, assign) BOOL isCloseButton;   //button 状态
@property (nonatomic, assign, readwrite) BOOL hasSwitchView;   //是否有两个用户

@end

@implementation UserDetailInformationView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.isCloseButton = true;
        [self changeButtonState];
        self.hasSwitchView = [self judgeSwitchView];
        
        [self addSubview:self.mainBackgroundImageView];
        [self.mainBackgroundImageView addSubview:self.closeOrConfirmButton];
        self.mainBackgroundImageView.userInteractionEnabled = true;
        if (self.hasSwitchView) {
            [self addSubview:self.switchBackgroundImageView];
        }
        [self setupConstraintsForSubviews];
        [self.closeOrConfirmButton addTarget:self action:@selector(closeOrConfirmButtonTap) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

static const CGFloat mainInitTop = -180;
- (void)setupConstraintsForSubviews {
    CGFloat switchInitLeft = [UIScreen mainScreen].bounds.size.width;
    
    WS(weakSelf, self);
    [self.mainBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.top.mas_equalTo(mainInitTop);
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.height.mas_equalTo(mainHeight);
    }];
    [self.closeOrConfirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-MIN_EDGE_X);
        make.top.equalTo(weakSelf.mainBackgroundImageView.mas_top).offset(NAVIGATION_BUTTON_Y);
        make.width.mas_equalTo(MIN_BUTTON_H_W);
        make.height.mas_equalTo(MIN_BUTTON_H_W);
    }];
    if (self.hasSwitchView) {
        [self.switchBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_top).offset(mainHeight);
            make.width.mas_equalTo(kSCREEN_WIDTH);
            make.left.equalTo(weakSelf.mas_left).with.offset(switchInitLeft);
            make.height.mas_equalTo(switchHeight);
        }];
    }
}

#pragma mark - public methods
- (void)showAnimationWithDelay:(NSTimeInterval)delay {
    NSTimeInterval allTime = 0.3 + self.hasSwitchView * 0.25;
    WS(weakSelf, self);
    [self layoutIfNeeded];
    [UIView animateKeyframesWithDuration:allTime
                                   delay:delay
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic
                              animations:^{
                                  [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:(1 - weakSelf.hasSwitchView * 0.5) animations:^{
                                      [weakSelf changeMainLayoutForAnimation];
                                      [weakSelf layoutIfNeeded];
                                  }];
                                  if (weakSelf.hasSwitchView) {
                                      [UIView addKeyframeWithRelativeStartTime:0.6 relativeDuration:0.4 animations:^{
                                          [weakSelf changeSwitchLayoutForAnimation];
                                          [weakSelf layoutIfNeeded];
                                      }];
                                  }
                              }
                              completion:nil];
    
}
//返回动画延迟
- (NSTimeInterval)showCloseAnimation {
    WS(weakSelf, self);
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [weakSelf closeAnimation];
        [weakSelf layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (self.hasSwitchView) {
            [weakSelf.switchBackgroundImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.mas_left).with.offset(kSCREEN_WIDTH);
            }];
        }
    }];
    return 0.4;
}

#pragma mark - private methods
- (BOOL)judgeSwitchView {
    return true;
}
- (void)changeButtonState {
    if (self.isCloseButton) {
        [self.closeOrConfirmButton setImage:[UIImage themedImageWithNamed:@"user/close"] forState:UIControlStateNormal];
    } else {
        [self.closeOrConfirmButton setImage:[UIImage themedImageWithNamed:@"user/confirm"] forState:UIControlStateNormal];
    }
}
- (void)changeMainLayoutForAnimation {
    [self.mainBackgroundImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
    }];
}
- (void)changeSwitchLayoutForAnimation {
    WS(weakSelf, self);
    [self.switchBackgroundImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
    }];
}
- (void)closeAnimation {
    WS(weakSelf, self);
    [weakSelf.mainBackgroundImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(mainInitTop-switchHeight);
    }];
    if (weakSelf.hasSwitchView) {
        [weakSelf.switchBackgroundImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(-switchHeight));
        }];
    }
}

#pragma mark - event actions
- (void)closeOrConfirmButtonTap {
    if (self.isCloseButton) {
        [self.delegate dismissUserDetailView];
    }
}

#pragma mark - getters and setters
- (UIImageView *)mainBackgroundImageView {
    if (!_mainBackgroundImageView) {
        _mainBackgroundImageView = [[UIImageView alloc] init];
        _mainBackgroundImageView.backgroundColor = [UIColor colorWithThemedImageNamed:@"color/primary_dark"];
    }
    return _mainBackgroundImageView;
}
- (UIImageView *)switchBackgroundImageView {
    if (!_switchBackgroundImageView) {
        _switchBackgroundImageView = [[UIImageView alloc] init];
        _switchBackgroundImageView.backgroundColor = [UIColor colorWithThemedImageNamed:@"color/primary"];
    }
    return _switchBackgroundImageView;
}
- (UIButton *)closeOrConfirmButton {
    if (!_closeOrConfirmButton) {
        _closeOrConfirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _closeOrConfirmButton;
}
- (BOOL)hasSwitchView {
    return YES;
}
@end
