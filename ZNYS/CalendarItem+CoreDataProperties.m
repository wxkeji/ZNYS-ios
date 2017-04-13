//
//  CalendarItem+CoreDataProperties.m
//  ZNYS
//
//  Created by yu243e on 2017/4/13.
//  Copyright © 2017年 Woodseen. All rights reserved.
//

#import "CalendarItem+CoreDataProperties.h"

@implementation CalendarItem (CoreDataProperties)

+ (NSFetchRequest<CalendarItem *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CalendarItem"];
}

@dynamic connectStarNumber;
@dynamic date;
@dynamic eveningStarNumber;
@dynamic morningStarNumber;
@dynamic starNumber;
@dynamic user;

@end
