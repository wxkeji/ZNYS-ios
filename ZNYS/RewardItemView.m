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

@property (nonatomic,strong) UIView * lineView;

@property (nonatomic,strong) UIView * coinBackView;

@end

@implementation RewardItemView

#pragma mark life cycle 

- (void)dealloc{
    _bgView = nil;
    _coinLabel = nil;
    _coinView = nil;
    _selectButton = nil;
    _bottomButton = nil;
    _lineView = nil;
    _model = nil;
    _coinBackView = nil;
}

- (instancetype)initWithFrame:(CGRect)frame type:(ItemType)type model:(rewardListModel *)model{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.isSelected = NO;
        self.itemType = type;
        self.model = model;
        [self addLongPressGesture];
        [self addTapGesture];
        
        [self addSubview:self.bgView];
        [self addSubview:self.coinBackView];
        [self.coinBackView addSubview:self.coinView];
        [self.coinBackView addSubview:self.coinLabel];
        [self addSubview:self.selectButton];
        [self addSubview:self.bottomButton];
        [self addSubview:self.lineView];

        WS(weakSelf, self);
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(0);
            make.top.equalTo(weakSelf.mas_top).with.offset(0);
            make.right.equalTo(weakSelf.mas_right).with.offset(0);
            make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
        }];
        
        [self.coinView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.coinBackView.mas_left).with.offset(0);
            make.bottom.equalTo(weakSelf.coinBackView.mas_bottom).with.offset(0);
            make.width.mas_equalTo(CustomWidth(15));
            make.height.mas_equalTo(CustomHeight(15));
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
        
        [self.bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(0);
            make.right.equalTo(weakSelf.mas_right).with.offset(0);
            make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
            make.height.mas_equalTo(CustomHeight(35));
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(CustomWidth(8));
            make.right.equalTo(weakSelf.mas_right).with.offset(CustomWidth(-8));
            make.bottom.equalTo(weakSelf.mas_bottom).with.offset(CustomHeight(-36));
            make.height.mas_equalTo(CustomHeight(1));
        }];
        
        [self.coinBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-CustomHeight(45));
            make.centerX.mas_equalTo(weakSelf.mas_centerX);
            make.width.mas_equalTo(CustomWidth(50));
            make.height.mas_equalTo(CustomHeight(15));
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

- (void)addTapGesture{
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showNextPage)];
    [self addGestureRecognizer:tapGesture];
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

- (void)playRecord:(UIButton *)sender{
    [self.delegate playRecord:self.model];
}

- (void)addReward:(UIButton *)sender{
    [self.delegate addReward:self.model];
}

- (void)showNextPage{
    [self.delegate showNextPage:self.model];
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

- (UIButton *)bottomButton{
    if (!_bottomButton) {
        _bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        if (self.itemType == RecordType) {
            _bottomButton.backgroundColor = [UIColor purpleColor];
            [_bottomButton addTarget:self action:@selector(playRecord:) forControlEvents:UIControlEventTouchUpInside];
        }else if (self.itemType == AddType){
            _bottomButton.backgroundColor = [UIColor redColor];
            [_bottomButton addTarget:self action:@selector(addReward:) forControlEvents:UIControlEventTouchUpInside];
        }else if(self.itemType == CheckType){
            _bottomButton.backgroundColor = [UIColor grayColor];
        }
    }
    return _bottomButton;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor grayColor];
    }
    return _lineView;
}

- (UIView *)coinBackView{
    if (!_coinBackView) {
        _coinBackView = [[UIView alloc] init];
        _coinBackView.backgroundColor = [UIColor clearColor];
    }
    return _coinBackView;
}

- (rewardListModel *)model{
    if (!_model) {
        _model = [[rewardListModel alloc] init];
    }
    return _model;
}
@end
