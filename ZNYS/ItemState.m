//
//  GiftState.m
//  ZNYS
//
//  Created by mac on 15/8/18.
//  Copyright (c) 2015年 Woodseen. All rights reserved.
//

#import "ItemState.h"

@implementation ItemState

- (instancetype)init
{
    if(self = [super init])
    {
        ItemStateEnum s=Obtained;
        [self setState:s];
    }
    return self;
}

- (void) setState:(ItemStateEnum)s
{
    state = s;
}

- (ItemStateEnum)state
{
    ItemStateEnum s = state;
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
            return @"Wrong item state!";
    }
}

@end
