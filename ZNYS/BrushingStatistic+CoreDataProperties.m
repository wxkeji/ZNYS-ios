//
//  BrushingStatistic+CoreDataProperties.m
//  ZNYS
//
//  Created by yu243e on 2017/4/12.
//  Copyright © 2017年 Woodseen. All rights reserved.
//

#import "BrushingStatistic+CoreDataProperties.h"

@implementation BrushingStatistic (CoreDataProperties)

+ (NSFetchRequest<BrushingStatistic *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"BrushingStatistic"];
}

@dynamic cleanliness;
@dynamic duration;
@dynamic effect;
@dynamic id;
@dynamic speed;
@dynamic starsGained;
@dynamic strength;
@dynamic timeSlot;
@dynamic toothBrushID;
@dynamic bePossessedByToothBrush;
@dynamic includeAreaStatistics;

@end
