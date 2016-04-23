//
//  AddRewardButtonView.m
//  ZNYS
//
//  Created by Ellise on 16/4/20.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "AddRewardButtonView.h"

@implementation AddRewardButtonView

#pragma mark life cycle

- (void)dealloc{
    _addButton = nil;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.addButton];
        
        WS(weakSelf, self);
        [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(0);
            make.top.equalTo(weakSelf.mas_top).with.offset(0);
            make.right.equalTo(weakSelf.mas_right).with.offset(0);
            make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
        }];
    }
    return self;
}

#pragma mark event action

- (void)addButtonClicked{
    NSLog(@"addButtonClicked");
}

#pragma mark getters and setters

- (UIButton *) addButton{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.backgroundColor = [UIColor purpleColor];
        [_addButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

@end
