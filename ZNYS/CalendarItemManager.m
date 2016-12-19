//
//  CalendarItemManager.m
//  ZNYS
//
//  Created by 张恒铭 on 6/29/16.
//  Copyright © 2016 Woodseen. All rights reserved.
//

#import "CalendarItemManager.h"

@implementation CalendarItemManager

+ (instancetype)sharedInstance
{
    static CalendarItemManager* sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[CalendarItemManager alloc] init];
    });
    return sharedManager;
}


- (CalendarItem*)createCalendarItem {
    CalendarItem* item = [NSEntityDescription insertNewObjectForEntityForName:@"CalendarItem" inManagedObjectContext:[CoreDataHelper sharedInstance].context];
    return item;
}

- (NSArray<CalendarItem*>*)getCalendarItemsByUserID:(NSString*)userID {
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"userID = %@",userID];
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"CalendarItem"];
    [request setPredicate:predicate];
    return [[CoreDataHelper sharedInstance].context executeFetchRequest:request error:nil];
}

- (void)save {
    [[CoreDataHelper sharedInstance] save];
}
@end
