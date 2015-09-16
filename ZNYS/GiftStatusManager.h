//
//  GiftStatusManager.h
//  ZNYS
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 Woodseen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GiftWithState.h"

/*
@protocol GiftBoxViewControllerDelegate <NSObject>



@end
 */

@interface GiftStatusManager : NSObject

/*@property (strong,nonatomic) NSMutableArray *pageList;*/
@property (strong,nonatomic) NSMutableArray *giftList;           //所有的奖品的列表，包括【已兑换的奖品】、
                                                //【已激活未兑换奖品】、【未激活的奖品】

//指定初始化方法
- (instancetype) initWithCurrentValidNumbersOfStars:(int)numberOfStars
                                      giftList:(NSArray *)gList;

//检查所有奖品的状态，更新奖品的状态
- (void) checkGiftStateOfPage:(int)page;

//得到某一页的状态信息
- (NSArray *) giftOfPage:(int)page;

//用户得到了星星，number表示星星增加的数量
- (void)increaseStars:(int)number;

//减少星星（用星星兑换的奖品），如果星星的数量不够则返回NO
- (BOOL)decreaseStars:(int)number;

//得到当前可用于兑换的星星的数量
- (int)currentValidNumberOfStars;

//得到用户从开始的到现在获得的星星总数
- (int)totalStars;

@end
