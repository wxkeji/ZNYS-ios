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
    GiftState *s = g.state;
    NSLog(@"%lu",(unsigned long)s);
}


//指定初始化方法
- (instancetype) initWithCurrentNumbersOfStars:(int)numberOfStars
                                      giftList:(NSMutableArray *)gList
{
    totalStars = numberOfStars;
    self.giftList = gList;
    return self;
}

//检查所有奖品的状态，更新奖品的状态
- (void) checkGiftStateOfPage:(int)page
{
    NSArray *gList = [self page:page];
    for(GiftWithState *g in gList)
    {
        if(g.state.state == NotActiveted)
        {
            if (self.currentValidNumberOfStars >= g.starsToActivate) {
                g.state.state = ActivatedNotObtained;
            }
        }
    }
}

//先刷新，然后得到某一页的奖品及其状态信息，页码是从0开始的
- (NSArray *) giftOfPage:(int)page
{
    [self checkGiftStateOfPage:page];
    return [self page:page];
}


//得到某一页奖品指针
- (NSArray *)page:(int)page
{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    for(int start=page*8,i=0;i<8;i++)
    {
        [list addObject:self.giftList[start + i]];
    }
    return list;
}


//用户得到了星星，number为星星增加的数量
- (void)increaseStars:(int)number
{
    currentValidNumberOfStars += number;
    totalStars += number;
}

//减少星星（用星星兑换的奖品），如果星星的数量不够则返回NO
- (BOOL)decreaseStars:(int)number
{
    if (currentValidNumberOfStars >= number) {
        currentValidNumberOfStars -= number;
        return YES;
    }
    else
    {
        return NO;
    }
}

//得到当前可用于兑换的星星的数量
- (int)currentValidNumberOfStars
{
    return currentValidNumberOfStars;
}

//得到用户从开始的到现在获得的星星总数
- (int)totalStars
{
    return totalStars;
}

@end
