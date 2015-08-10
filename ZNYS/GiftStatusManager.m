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


//指定初始化方法
- (instancetype) initWithCurrentNumbersOfStars:(int)numberOfStars
                                      giftList:(NSArray *)gList
{
    return self;
}

//检查所有奖品的状态，更新奖品的状态
- (void) checkGiftState
{
    
}

//得到某一页的状态信息
- (Gift *) giftOfPage:(int)page
{
    return nil;
}

//用户得到了星星，number为星星增加的数量
- (void)increaseStars:(int)number
{
    
}

//减少星星（用星星兑换的奖品），如果星星的数量不够则返回NO
- (BOOL)decreaseStars:(int)number
{
    return NO;
}

//得到当前星星的数量
- (int)currentNumberOfStars
{
    return -1;
}


@end
