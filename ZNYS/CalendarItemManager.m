//
//  CalendarItemManager.m
//  ZNYS
//
//  Created by 张恒铭 on 6/29/16.
//  Copyright © 2016 Woodseen. All rights reserved.
//

#import "CalendarItemManager.h"
#import "User+CoreDataClass.h"
@implementation CalendarItemManager
+ (CalendarItem*)createCalendarItem {
    CalendarItem* item = [NSEntityDescription insertNewObjectForEntityForName:@"CalendarItem" inManagedObjectContext:[CoreDataHelper sharedInstance].context];
    return item;
}

@end
