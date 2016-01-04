//
//  UIButton+Font.m
//  ZNYS
//
//  Created by Ellise on 16/1/4.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "UIButton+Font.h"

@implementation UIButton (Font)

- (instancetype)initWithCustomFont:(CGFloat)size{
    self = [super init];
    if (self) {
        self.titleLabel.font = [UIFont fontWithName:@"DFPWaWaW5" size:size];
    }
    return self;
}

@end
