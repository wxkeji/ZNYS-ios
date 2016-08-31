//
//  NSArray+ForceBound.h
//  ZNYS
//
//  Created by mac on 15/8/23.
//  Copyright (c) 2015年 Woodseen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray(ForceBound)

- (id)objectAtIndexWithForceBound:(NSUInteger)index;
@end
