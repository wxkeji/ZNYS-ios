//
//  AddAccountButton.m
//  ZNYS
//
//  Created by Ellise on 16/1/5.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "AddAccountButton.h"

@interface AddAccountButton()

@property (nonatomic,strong) UIButton * addButton;

@property (nonatomic,strong) UILabel * addLabel;

@end

@implementation AddAccountButton

- (void)dealloc{
    _addButton = nil;
    _addLabel = nil;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.addButton];
        [self addSubview:self.addLabel];
        
        WS(weakSelf, self);
        [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_top).with.offset(0);
            make.left.equalTo(weakSelf.mas_left).with.offset(0);
            make.right.equalTo(weakSelf.mas_right).with.offset(0);
            make.height.mas_equalTo(0.108*kSCREEN_HEIGHT);
        }];
        
        [self.addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-5);
            make.left.equalTo(weakSelf.mas_left).with.offset(0);
            make.right.equalTo(weakSelf.mas_right).with.offset(0);
            make.height.mas_equalTo(0.025*kSCREEN_HEIGHT);
        }];
    }
    return self;
}

#pragma mark event action

- (void)addButtonAction{
    
}

#pragma mark getters and setters

- (UILabel *)addLabel{
    if (!_addLabel) {
        _addLabel = [[UILabel alloc] initWithCustomFont:15.f];
        _addLabel.text = @"新用户";
        _addLabel.textColor = [UIColor blackColor];
        _addLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _addLabel;
}

- (UIButton *)addButton{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.backgroundColor = [UIColor redColor];
        [_addButton addTarget:self action:@selector(addButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

@end
