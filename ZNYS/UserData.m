//
//  GiftStatusManager.m
//  ZNYS
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 Woodseen. All rights reserved.
//

#import "UserData.h"
#import <sqlite3.h>

#define DB_FILENAME @"userdata"    //数据库文件名ß

@interface UserData ()
{
    int currentValidNumberOfStars;    //用户现在拥有的可供兑换奖品的星星数量
    int totalStars;                   //用户拥有的星星总数，包括已经用来兑换的星星和还没使用的星星
}
@end

@implementation UserData

- (void) testFunc
{
    ItemWithState *g = [[ItemWithState alloc] init];
    ItemState *s = g.state;
    NSLog(@"%lu",(unsigned long)s);
}

//指定初始化方法
- (instancetype) initWithCurrentValidNumbersOfStars:(int)currentValidNums
                                    totalStars:(int)totals
                                      gloryItemList:(NSMutableArray *)gloryItemList
                                       bathItemList:(NSMutableArray *)bathItemList
{
    /*
    
    //数据库操作
    //获取数据库文件地址
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:DB_FILENAME];
    
    //打开iPhone上的数据库文件
    sqlite3 *database;
    int state = sqlite3_open([path UTF8String],&database);
    if(state == SQLITE_OK)
    {
        NSLog(@" >> Succeed to open database. %@",path);
    }
    else
    {
         NSLog(@" >> Failed to open database. %@",path);
    }
    
    */
    
    currentValidNumberOfStars = currentValidNums;
    self.gloryItemList = gloryItemList;
    self.bathItemList = bathItemList;
    totalStars = totals;
    return self;
}

- (instancetype) initWithCurrentValidNumbersOfStars:(int)numberOfStars
                                      gloryItemList:(NSMutableArray *)gloryItemList
                                       bathItemList:(NSMutableArray *)bathItemList
{
    totalStars = numberOfStars;
    currentValidNumberOfStars = totalStars;
    self.gloryItemList = gloryItemList;
    self.bathItemList = bathItemList;
    return self;
}

- (instancetype)init
{
    NSMutableArray *gList = [[NSMutableArray alloc] init];
    long validNumberOfStars,totals;
    
    validNumberOfStars = [[NSUserDefaults standardUserDefaults] integerForKey:@"currentValidNumberOfStars"];
    
    
    //添加奖品
    for(int i=0;i<8;i++)
    {
        ItemWithState *gws = [[ItemWithState alloc] initWithItemName:[NSString stringWithFormat:@"littleDragon"]  imageName:@"小恐龙_已兑换"];
        [gList addObject:gws];
    }
    for(int i=8;i<16;i++)
    {
        ItemWithState *gws = [[ItemWithState alloc] initWithItemName:[NSString stringWithFormat:@"littleDuck"] imageName:@"小鸭子_已兑换"];
        [gList addObject:gws];
    }
    for(int i=16;i<24;i++)
    {
        ItemWithState *gws = [[ItemWithState alloc] initWithItemName:[NSString stringWithFormat:@"littleBasketball"]  imageName:@"小篮球_已兑换"];
        [gList addObject:gws];
    }

    self = [self initWithCurrentValidNumbersOfStars:validNumberOfStars totalStars:totals  gloryItemList:gList bathItemList:self.bathItemList];
    
    return self;
}

////检查所有奖品的状态，更新奖品的状态
//- (void) checkGiftStateOfPage:(int)page
//{
//    NSArray *gList = [self page:page];
//    for(ItemWithState *g in gList)
//    {
//        if(g.state.state == NotActiveted)
//        {
//            if (self.currentValidNumberOfStars >= g.starsToActivate) {
//                g.state.state = ActivatedNotObtained;
//            }
//        }
//    }
//}

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
        [list addObject:self.gloryItemList[start + i]];
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
