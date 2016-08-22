//
//  ZNYSBaseNavigationBar.m
//  ZNYS
//
//  Created by Ellise on 16/4/5.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ZNYSBaseNavigationBar.h"
#import "ZNYSBaseController.h"
#import "AppDelegate.h"
#import "ToolMacroes.h"
#import "UILabel+Font.h"
#import <Masonry.h>

@implementation ZNYSBaseNavigationBar

#pragma mark life cycle
- (instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 78)];
    if (self) {
        
        [self addSubview:self.dismissButton];
        [self addSubview:self.title];
        [self addSubview:self.rightButton];
        
        WS(weakSelf, self);
        [self.dismissButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(CustomWidth(15));
            make.centerY.mas_equalTo(weakSelf.title.mas_centerY);
            make.width.mas_equalTo(44);
            make.height.mas_equalTo(44);
        }];
        
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf.mas_centerX);
            make.top.equalTo(weakSelf.mas_top).with.offset(CustomHeight(30));
            make.width.mas_equalTo(110);
            make.height.mas_equalTo(27);
        }];
        
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_right).with.offset(-10);
            make.centerY.mas_equalTo(weakSelf.dismissButton.mas_centerY);
            make.width.mas_equalTo(44);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}

#pragma mark event action
- (void)dismissButtonClicked{
    [(ZNYSBaseController *)CurrentController backMenuDidPressed];
}

- (void)rightButtonClicked{
    [self.delegate rightButtonClicked];
}

#pragma mark getters and setters

- (UIButton *)dismissButton{
    if (!_dismissButton) {
        _dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _dismissButton.backgroundColor = [UIColor blueColor];
        [_dismissButton addTarget:self action:@selector(dismissButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dismissButton;
}

- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] initWithCustomFont:26.f];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.textColor = [UIColor blackColor];
    }
    return _title;
}

- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithCustomFont:20.f];
        [_rightButton addTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.backgroundColor = [UIColor clearColor];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rightButton.hidden = YES;
    }
    return _rightButton;
}

@end
