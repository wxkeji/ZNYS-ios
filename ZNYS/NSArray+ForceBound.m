//
//  NSArray+ForceBound.m
//  ZNYS
//
//  Created by mac on 15/8/23.
//  Copyright (c) 2015年 Woodseen. All rights reserved.
//

#import "NSArray+ForceBound.h"

@implementation NSArray(ForceBound)

- (id)objectAtIndexWithForceBound:(NSUInteger)index
{
    if(index < self.count)
    {
        return self[index];
    }
    else
    {
        return nil;
    }
}

@end
