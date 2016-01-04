//
//  UILabel+Font.m
//  ZNYS
//
//  Created by Ellise on 16/1/2.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "UILabel+Font.h"

@implementation UILabel (Font)

- (instancetype)initWithCustomFont:(CGFloat)size{
    self = [super init];
    if (self) {
        self.font = [UIFont fontWithName:@"DFPWaWaW5" size:size];
    }
    return self;
}

@end
