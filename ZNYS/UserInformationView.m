//
//  UserInformationView.m
//  ZNYS
//
//  Created by yu243e on 16/8/23.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "UserInformationView.h"
#import "CoreDataHelper.h"
@interface UserInformationView()


@property (nonatomic, strong) UIImageView * userImageView;
@property (nonatomic, strong) UILabel * userNameLabel;
@property (nonatomic, strong) UIImageView * levelImageView;
@property (nonatomic, strong) UILabel *levelLabel;
@property (nonatomic, strong) UIImageView * coinImageView;
@property (nonatomic, strong) UILabel *coinLabel;

@end

@implementation UserInformationView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.userImageView];
        [self addSubview:self.userNameLabel];
        [self addSubview:self.levelImageView];
        [self addSubview:self.levelLabel];
        [self addSubview:self.coinImageView];
        [self addSubview:self.coinLabel];
        
        [self setupConstraintsForSubviews];
        
        self.userImageView.layer.cornerRadius = 22;
        self.userImageView.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setupConstraintsForSubviews {
    WS(weakSelf, self);
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(15);
        make.top.equalTo(weakSelf.mas_top).with.offset(0);
        make.width.mas_equalTo(44);//44x44@1x
        make.height.mas_equalTo(44);
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.userImageView.mas_right).offset(10);
        make.centerY.equalTo(weakSelf.userImageView.mas_centerY);
    }];
    
    [self.levelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.userImageView.mas_centerY);
        make.left.mas_equalTo(kSCREEN_WIDTH * 0.55);
        make.height.mas_equalTo(22);//22x22@1x
    }];
    
    [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.userImageView.mas_centerY);
        make.left.equalTo(weakSelf.levelImageView.mas_right).offset(10);
    }];
    
    [self.coinImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.userImageView.mas_centerY);
        make.left.mas_equalTo(kSCREEN_WIDTH * 0.75);
        make.height.mas_equalTo(22);//22x22@1x
    }];
    
    [self.coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.userImageView.mas_centerY);
        make.left.equalTo(weakSelf.coinImageView.mas_right).offset(10);
    }];
    
}

#pragma mark - public method

#pragma mark - private method

#pragma mark - event action

#pragma mark - getters and setters
- (UIImageView *)userImageView{
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] init];
        _userImageView.image = [UIImage imageNamed:@"user/user_temp"];
//        _userNameLabel.layer.masksToBounds = YES;
    }
    return _userImageView;
}

- (UILabel *)userNameLabel{
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] initWithCustomFont:15.f];
        _userNameLabel.text = [User currentUserName];
        _userNameLabel.textColor = [UIColor whiteColor];
        _userNameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _userNameLabel;
}

- (UIImageView *)coinImageView{
    if (!_coinImageView) {
        _coinImageView = [[UIImageView alloc] init];
        _coinImageView.image = [UIImage imageNamed:@"user/coin"];
        _coinImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _coinImageView;
}

- (UILabel *)coinLabel{
    if (!_coinLabel) {
        _coinLabel = [[UILabel alloc] initWithCustomFont:15.f];
        _coinLabel.text = [NSString stringWithFormat:@"%@",[User currentUserTokenOwned]];
        _coinLabel.textColor = [UIColor whiteColor];
        _coinLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _coinLabel;
}

- (UIImageView *)levelImageView{
    if (!_levelImageView) {
        _levelImageView = [[UIImageView alloc] init];
        _levelImageView.image = [UIImage imageNamed:@"user/level"];
        _levelImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _levelImageView;
}

- (UILabel *)levelLabel{
    if (!_levelLabel) {
        _levelLabel = [[UILabel alloc] initWithCustomFont:15.f];
        if (![User currentUserLevel]) {
            _levelLabel.text = [NSString stringWithFormat:@"%d",0];
        } else {
            _levelLabel.text = [NSString stringWithFormat:@"%@",[User currentUserLevel]];
        }
        _levelLabel.textColor = [UIColor whiteColor];
        _levelLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _levelLabel;
}


@end