//
//  Gift.h
//  ZNYS
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 Woodseen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gift : NSObject

@property (strong) NSString *name;       //礼物名称
@property int starsToActivate;           //需要多少颗星星来解锁这个奖品

//指定初始化方法
- (instancetype) initWithGiftName:(NSString *)giftName
                  starsToActivate:(int)starsToActivate;

@end
