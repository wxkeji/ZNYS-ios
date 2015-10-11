//
//  TouchableImageView.m
//  ZNYS
//
//  Created by mac on 15/9/16.
//  Copyright (c) 2015年 Woodseen. All rights reserved.
//


#import "TouchableImageView.h"

@implementation TouchableImageView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate imageTouchesBegin:self.tag];
}

@end
