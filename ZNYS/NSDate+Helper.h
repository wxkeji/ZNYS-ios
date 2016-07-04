//
//  NSDate+Helper.h
//  ZNYS
//
//  Created by yu243e on 16/7/4.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Helper)

//需要注意这里的时间都是UTC+8 Log出来的是UTC需要+8h为这里的时间。
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format;

/*string 形如 2016-10-06*/
+ (NSDate *)dateFromString:(NSString *)string;
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;

+ (NSInteger)currentWeek:(NSDate *)date;

+ (NSDate *)beginningOfDay:(NSDate *)date;
+ (NSDate *)nextDay:(NSDate *)date;

@end
