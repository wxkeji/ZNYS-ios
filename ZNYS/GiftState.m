//
//  GiftState.m
//  ZNYS
//
//  Created by mac on 15/8/18.
//  Copyright (c) 2015年 Woodseen. All rights reserved.
//

#import "GiftState.h"

@implementation GiftState

- (instancetype)init
{
    if(self = [super init])
    {
        GiftStateEnum s=Obtained;
        [self setState:s];
    }
    return self;
}

- (void) setState:(GiftStateEnum)s
{
    state = s;
}

- (GiftStateEnum)state
{
    GiftStateEnum s = state;
    return s;
}

- (NSString *)toString
{
    switch (self.state) {
        case 0:
            return @"Obtained";
            break;
            
        case 1:
            return @"ActivatedNotObtained";
            break;
            
        case 2:
            return @"NotActivated";
            break;
            
        default:
            return @"Wrong gift state!";
    }
}

@end
