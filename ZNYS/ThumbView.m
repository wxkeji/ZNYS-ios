//
//  ThumbView.m
//  ZNYS
//
//  Created by Ellise on 16/1/5.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ThumbView.h"

@implementation ThumbView

#pragma mark life cycle

- (void)dealloc{
    _nameLabel = nil;
    _thumbButton = nil;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.nameLabel];
        [self addSubview:self.thumbButton];
        
        WS(weakSelf, self);
        [self.thumbButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_top).with.offset(0);
            make.left.equalTo(weakSelf.mas_left).with.offset(0);
            make.right.equalTo(weakSelf.mas_right).with.offset(0);
            make.height.mas_equalTo(0.108*kSCREEN_HEIGHT);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-5);
            make.left.equalTo(weakSelf.mas_left).with.offset(0);
            make.right.equalTo(weakSelf.mas_right).with.offset(0);
            make.height.mas_equalTo(0.025*kSCREEN_HEIGHT);
        }];
    }
    return self;
}

#pragma mark event action

- (void)thumbButtonAction{
    //发通知
}

#pragma mark getters and setters

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithCustomFont:15.f];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

- (UIButton *)thumbButton{
    if (!_thumbButton) {
        _thumbButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _thumbButton.backgroundColor = [UIColor redColor];
        [_thumbButton addTarget:self action:@selector(thumbButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _thumbButton;
}

@end
