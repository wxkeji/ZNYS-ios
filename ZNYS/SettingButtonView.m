//
//  SettingButtonView.m
//  ZNYS
//
//  Created by Ellise on 16/1/4.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "SettingButtonView.h"

@interface SettingButtonView()

@property (nonatomic,strong) UIButton * rewardListButton;

@property (nonatomic,strong) UIButton * brushModeButton;

@property (nonatomic,strong) UIButton * brushRecordButton;

@property (nonatomic,strong) UIButton * notiButton;

@property (nonatomic,strong) UIButton * aboutButton;

@property (nonatomic,strong) UIButton * brushControlButton;

@property (nonatomic,strong) UIButton* toothBrushManagementButton;

@end

@implementation SettingButtonView

#pragma mark life cycle

- (void)dealloc{
    _buttonClickBlock = nil;
    _rewardListButton = nil;
    _brushControlButton = nil;
    _brushModeButton = nil;
    _brushRecordButton = nil;
    _notiButton = nil;
    _aboutButton = nil;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.rewardListButton];
        [self addSubview:self.brushControlButton];
        [self addSubview:self.brushModeButton];
        [self addSubview:self.brushRecordButton];
        [self addSubview:self.notiButton];
        [self addSubview:self.aboutButton];
        [self addSubview:self.toothBrushManagementButton];
        
        WS(weakSelf, self);
        [self.rewardListButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(0.064*kSCREEN_WIDTH);
            make.top.equalTo(weakSelf.mas_top).with.offset(0.078*kSCREEN_HEIGHT);
            make.width.mas_equalTo(0.627*kSCREEN_WIDTH);
            make.height.mas_equalTo(0.159*kSCREEN_HEIGHT);
        }];
        
        [self.brushModeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_right).with.offset(-0.056*kSCREEN_WIDTH);
            make.left.equalTo(weakSelf.rewardListButton.mas_right).with.offset(0.029*kSCREEN_WIDTH);
            make.centerY.mas_equalTo(weakSelf.rewardListButton.mas_centerY);
            make.height.mas_equalTo(0.159*kSCREEN_HEIGHT);
        }];
        
        [self.brushRecordButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(0.064*kSCREEN_WIDTH);
            make.top.equalTo(weakSelf.rewardListButton.mas_bottom).with.offset(0.02*kSCREEN_HEIGHT);
            make.height.mas_equalTo(0.159*kSCREEN_HEIGHT);
            make.width.mas_equalTo(0.283*kSCREEN_WIDTH);
        }];
        
        [self.notiButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.brushRecordButton.mas_centerY);
            make.centerX.mas_equalTo(weakSelf.mas_centerX);
            make.height.mas_equalTo(0.159*kSCREEN_HEIGHT);
            make.width.mas_equalTo(0.283*kSCREEN_WIDTH);
        }];
        
        [self.aboutButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_right).with.offset(-0.056*kSCREEN_WIDTH);
            make.centerY.mas_equalTo(weakSelf.brushRecordButton.mas_centerY);
            make.height.mas_equalTo(0.159*kSCREEN_HEIGHT);
            make.width.mas_equalTo(0.283*kSCREEN_WIDTH);
        }];
        
        
        [self.toothBrushManagementButton mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.equalTo(weakSelf.brushRecordButton.mas_left);
            make.right.equalTo(weakSelf.brushRecordButton.mas_right);
            make.centerX.equalTo(weakSelf.brushRecordButton);
            make.height.equalTo(@(0.159*kSCREEN_HEIGHT));
            make.centerY.equalTo(weakSelf.mas_centerY).with.offset(0.159*kSCREEN_HEIGHT);
        }];
    }
    return self;
}

#pragma mark event action

- (void)buttonClickAction:(UIButton *)choose{
    if (self.buttonClickBlock) {
        self.buttonClickBlock(choose.tag);
    }
}

#pragma mark getters and setters

- (UIButton *)rewardListButton{
    if (!_rewardListButton) {
        _rewardListButton = [[UIButton alloc] initWithCustomFont:35.f];
        _rewardListButton.tag = baseTag+0;
        _rewardListButton.layer.cornerRadius = 10.f;
        _rewardListButton.backgroundColor = RGBCOLOR(244, 148, 187);
        [_rewardListButton setTitle:@"奖励清单" forState:UIControlStateNormal];
        [_rewardListButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rewardListButton;
}

- (UIButton *)brushModeButton{
    if (!_brushModeButton) {
        _brushModeButton = [[UIButton alloc]initWithCustomFont:38.f];
        _brushModeButton.tag = baseTag+1;
        _brushModeButton.layer.cornerRadius = 10.f;
        _brushModeButton.titleLabel.numberOfLines = 2;
        _brushModeButton.backgroundColor = RGBCOLOR(228, 86, 133);
        [_brushModeButton setTitle:@"刷牙模式" forState:UIControlStateNormal];
        [_brushModeButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _brushModeButton;
}

- (UIButton *)brushRecordButton{
    if (!_brushRecordButton) {
        _brushRecordButton = [[UIButton alloc] initWithCustomFont:38.f];
        _brushRecordButton.tag = baseTag+2;
        _brushRecordButton.layer.cornerRadius = 10.f;
        _brushRecordButton.titleLabel.numberOfLines = 2;
        _brushRecordButton.backgroundColor = RGBCOLOR(76, 167, 208);
        [_brushRecordButton setTitle:@"刷牙记录" forState:UIControlStateNormal];
        [_brushRecordButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _brushRecordButton;
}

- (UIButton *)notiButton{
    if (!_notiButton) {
        _notiButton = [[UIButton alloc] initWithCustomFont:35.f];
        _notiButton.tag = baseTag+3;
        _notiButton.layer.cornerRadius = 10.f;
        _notiButton.backgroundColor = RGBCOLOR(123, 216, 191);
        [_notiButton setTitle:@"通知" forState:UIControlStateNormal];
        [_notiButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _notiButton;
}

- (UIButton *)aboutButton{
    if (!_aboutButton) {
        _aboutButton = [[UIButton alloc] initWithCustomFont:38.f];
        _aboutButton.tag = baseTag+4;
        _aboutButton.layer.cornerRadius = 10.f;
        _aboutButton.titleLabel.numberOfLines = 2;
        _aboutButton.backgroundColor = RGBCOLOR(89, 177, 176);
        [_aboutButton setTitle:@"关于我们" forState:UIControlStateNormal];
        [_aboutButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _aboutButton;
}

- (UIButton *)brushControlButton{
    if (!_brushControlButton) {
        _brushControlButton = [[UIButton alloc] initWithCustomFont:35.f];
        _brushControlButton.tag = baseTag+5;
        _brushControlButton.layer.cornerRadius = 10.f;
        _brushControlButton.backgroundColor = [UIColor yellowColor];
        [_brushControlButton setTitle:@"牙刷管理" forState:UIControlStateNormal];
        [_brushControlButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _brushControlButton;
}

- (UIButton *)toothBrushManagementButton {
	if(_toothBrushManagementButton == nil) {
		_toothBrushManagementButton = [[UIButton alloc] initWithCustomFont:25.0f];
        _toothBrushManagementButton.tag = baseTag+6;
        _toothBrushManagementButton.layer.cornerRadius = 10.0f;
        _toothBrushManagementButton.titleLabel.numberOfLines = 2;
        [_toothBrushManagementButton setBackgroundColor:RGBCOLOR(39, 181, 251)];
        [_toothBrushManagementButton setTitle:@"宝宝的牙刷" forState:UIControlStateNormal];
        [_toothBrushManagementButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
	}
	return _toothBrushManagementButton;
}

@end
