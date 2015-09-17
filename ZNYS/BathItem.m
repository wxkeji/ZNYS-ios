//
//  BathItem.m
//  ZNYS
//
//  Created by luolun on 15/9/16.
//  Copyright (c) 2015年 Woodseen. All rights reserved.
//

#import "BathItem.h"

@interface BathItem ()
@property (nonatomic) int starsToActivate;             //需要多少颗星星来解锁这个奖品
@end

@implementation BathItem

//指定初始化方法
- (instancetype) initWithItemName:(NSString *)giftName
                  starsToActivate:(int)starsToActivate
                        imageName:(NSString *)imageName;
{
    self = [super initWithItemName:giftName imageName:imageName];
    self.starsToActivate = starsToActivate;
    return self;
}
@end
