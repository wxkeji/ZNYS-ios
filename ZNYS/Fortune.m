//
//  Fortune.m
//  ZNYS
//
//  Created by mac on 15/9/20.
//  Copyright © 2015年 Woodseen. All rights reserved.
//

#import "Fortune.h"

#define NUMBER_SYSTEM 10    //进制，10个星星换一个金币

@interface Fortune()

@property (assign, nonatomic) int stars;  //星星
@property (assign, nonatomic) int coins;  //硬币

@end

@implementation Fortune

- (instancetype)initWithCoins:(int)coins stars:(int)stars
{
    self = [super init];
    self.coins = coins;
    self.stars = stars;
    return self;
}

- (instancetype)init
{
    return [self initWithCoins:0 stars:0];
}

- (void)increaseCoins:(int)coins stars:(int)stars
{
    if(coins < 0 || stars < 0)return;
    
    //先加上响应的星星和金币
    self.stars += stars;
    self.coins += coins;
    
    //把所有金币转化为星星
    self.stars += coins * NUMBER_SYSTEM;
    self.coins = 0;
    
    //利用取模和除法运算重新计算星星数和金币数
    self.coins = self.stars / NUMBER_SYSTEM;
    self.stars = self.stars % NUMBER_SYSTEM;
}

//如果所拥有的财富不足，返回NO
- (BOOL)decreaseCoins:(int)coins stars:(int)stars
{
    //把要减去的财富等价为星星数
    int starsToPay = coins * NUMBER_SYSTEM  + stars;
    
    //已有财富等价为星星数
    int totalInStars = self.coins * NUMBER_SYSTEM + self.stars;
    
    if(totalInStars < starsToPay)
    {
        return NO;
    }
    else
    {
        self.stars = totalInStars - starsToPay;
        self.coins = 0;
        
        self.coins = self.stars / NUMBER_SYSTEM;
        self.stars = self.stars % NUMBER_SYSTEM;
    }
    
    return YES;
}

@end
