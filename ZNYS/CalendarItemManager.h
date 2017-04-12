//
//  CalendarItemManager.h
//  ZNYS
//
//  Created by 张恒铭 on 6/29/16.
//  Copyright © 2016 Woodseen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalendarItem+CoreDataClass.h"
#import "CalendarItem+CoreDataProperties.h"
#import "CoreDataHelper.h"
@interface CalendarItemManager : NSObject

+ (instancetype)sharedInstance;


- (CalendarItem*)createCalendarItem;


- (NSArray<CalendarItem*>*)getCalendarItemsByUserID:(NSString*)userID;

- (void)save;
@end
