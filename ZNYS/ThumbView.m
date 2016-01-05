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
        
    }
    return self;
}

#pragma mark event action

- (void)thumbButtonAction{
    
}

#pragma mark getters and setters

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"阿花";
        _nameLabel.textColor = [UIColor blackColor];
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
