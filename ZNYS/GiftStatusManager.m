//
//  GiftStatusManager.m
//  ZNYS
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 Woodseen. All rights reserved.
//

#import "GiftStatusManager.h"

@implementation GiftStatusManager

- (void) testFunc
{
    GiftWithState *g = [[GiftWithState alloc] init];
    GiftState s = g.state;
    NSLog(@"%lu",(unsigned long)s);
}

@end
