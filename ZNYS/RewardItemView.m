//
//  RewardItemView.m
//  ZNYS
//
//  Created by Ellise on 16/1/14.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "RewardItemView.h"

@interface RewardItemView()

@property (nonatomic,strong) UIImageView * coinView;

@property (nonatomic,strong) UIButton * playRecordButton;

@end

@implementation RewardItemView

#pragma mark life cycle 

- (void)dealloc{
    _bgView = nil;
    _coinLabel = nil;
    _coinView = nil;
    _selectButton = nil;
    _playRecordButton = nil;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.isSelected = NO;
        [self addLongPressGesture];
        
        [self addSubview:self.bgView];
        [self addSubview:self.coinView];
        [self addSubview:self.coinLabel];
        [self addSubview:self.selectButton];
        [self addSubview:self.playRecordButton];
        
        WS(weakSelf, self);
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(0);
            make.top.equalTo(weakSelf.mas_top).with.offset(0);
            make.right.equalTo(weakSelf.mas_right).with.offset(0);
            make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
        }];
        
        [self.coinView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(CustomWidth(23));
            make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-CustomHeight(14));
            make.width.mas_equalTo(CustomWidth(20));
            make.height.mas_equalTo(CustomHeight(20));
        }];
        
        [self.coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.coinView.mas_right).with.offset(CustomWidth(8));
            make.centerY.mas_equalTo(weakSelf.coinView.mas_centerY);
            make.height.mas_equalTo(weakSelf.coinView.mas_height);
        }];
        
        [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_right).with.offset(CustomWidth(-10));
            make.top.equalTo(weakSelf.mas_top).with.offset(CustomHeight(10));
            make.width.mas_equalTo(CustomWidth(20));
            make.height.mas_equalTo(CustomHeight(20));
        }];
    }
    return self;
}

#pragma mark private method

- (void)addLongPressGesture{
    UILongPressGestureRecognizer * longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showDeleteButton)];
    /*最大100像素的运动是手势识别所允许的*/
    longPressGesture.allowableMovement = 100.0f;
    /*这个参数表示,两次点击之间间隔的时间长度。*/
    longPressGesture.minimumPressDuration = 0.2;
    [self addGestureRecognizer:longPressGesture];
}

#pragma mark event action

- (void)selectButtonClicked{
    if (self.isSelected) {
        self.isSelected = !self.isSelected;
        self.selectButton.backgroundColor = [UIColor grayColor];
    }else{
        self.isSelected = !self.isSelected;
        self.selectButton.backgroundColor = [UIColor blueColor];
    }
}

- (void)showDeleteButton{
    [self.delegate startDelete];
}

#pragma mark getters and setters

- (UIImageView *)bgView{
    if (!_bgView) {
        _bgView = [[UIImageView alloc] init];
        _bgView.backgroundColor = [UIColor yellowColor];
    }
    return _bgView;
}

- (UIImageView *)coinView{
    if (!_coinView) {
        _coinView = [[UIImageView alloc]init];
        _coinView.backgroundColor = [UIColor purpleColor];
    }
    return _coinView;
}

- (UILabel *)coinLabel{
    if (!_coinLabel) {
        _coinLabel = [[UILabel alloc] initWithCustomFont:15.f];
        _coinLabel.text = @"x 8";
        _coinLabel.textColor = [UIColor blackColor];
    }
    return _coinLabel;
}

- (UIButton *)selectButton{
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectButton.backgroundColor = [UIColor grayColor];
        _selectButton.hidden = YES;
        [_selectButton addTarget:self action:@selector(selectButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}

@end
