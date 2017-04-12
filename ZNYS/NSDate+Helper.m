//
//  NSDate+Helper.m
//  ZNYS
//
//  Created by yu243e on 16/7/4.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "NSDate+Helper.h"

@implementation NSDate (Helper)
+ (NSString *)stringFromDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy年M月d日"];
//    [dateFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"]];
    return [dateFormatter stringFromDate:date];
}

+ (NSDate *)dateFromString:(NSString *)string {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy年M月d日"];
    
    return [dateFormatter dateFromString:string];
}

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: format];
    return [dateFormatter stringFromDate:date];
}

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: format];
    return [dateFormatter dateFromString:string];
}

+ (NSInteger)currentWeek:(NSDate *)date {
    NSCalendar *gregorianCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger weekday = [gregorianCalendar component:NSCalendarUnitWeekday fromDate:date];
    return weekday;
}

+ (NSDate *)beginningOfDay:(NSDate *)date {
    NSCalendar *gregorianCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];

    return [gregorianCalendar dateFromComponents:components];
}

+ (NSDate *)nextDay:(NSDate *)date {
    return [NSDate dateWithTimeInterval:24*60*60 sinceDate:[self beginningOfDay:date]];
}

+ (NSInteger)ageFromBirthdayDate:(NSDate *)date {
        // 出生日期转换 年月日
        NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
        NSInteger brithDateYear  = [components1 year];
        NSInteger brithDateDay   = [components1 day];
        NSInteger brithDateMonth = [components1 month];
        
        // 获取系统当前 年月日
        NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
        NSInteger currentDateYear  = [components2 year];
        NSInteger currentDateDay   = [components2 day];
        NSInteger currentDateMonth = [components2 month];
        
        // 计算年龄
        NSInteger iAge = currentDateYear - brithDateYear - 1;
        if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
            iAge++;  
        }  
        
        return iAge;
}
@end
