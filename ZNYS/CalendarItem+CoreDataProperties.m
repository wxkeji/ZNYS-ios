//
//  CalendarItem+CoreDataProperties.m
//  ZNYS
//
//  Created by yu243e on 2017/4/12.
//  Copyright © 2017年 Woodseen. All rights reserved.
//

#import "CalendarItem+CoreDataProperties.h"

@implementation CalendarItem (CoreDataProperties)

+ (NSFetchRequest<CalendarItem *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CalendarItem"];
}

@dynamic awardCount;
@dynamic connectStarNumber;
@dynamic date;
@dynamic eveningStarNumber;
@dynamic firstAwardID;
@dynamic id;
@dynamic level;
@dynamic morningStarNumber;
@dynamic starNumber;
@dynamic userID;
@dynamic belongToUser;

@end
