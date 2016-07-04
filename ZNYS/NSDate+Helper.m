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
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
//    [dateFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"]];
    return [dateFormatter stringFromDate:date];
}

+ (NSDate *)dateFromString:(NSString *)string {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    
    //[dateFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"]];
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
    return [dateFormatter dateFromString:format];
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
@end
