//
//  UITextField+Font.m
//  ZNYS
//
//  Created by Ellise on 16/1/6.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "UITextField+Font.h"

@implementation UITextField (Font)

- (instancetype)initWithCustomFont:(CGFloat)size{
    self = [super init];
    if (self) {
        self.font = [UIFont fontWithName:@"DFPWaWaW5" size:size];
    }
    return self;
}

@end
