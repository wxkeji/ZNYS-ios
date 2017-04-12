//
//  AreaStatistic+CoreDataProperties.m
//  ZNYS
//
//  Created by yu243e on 2017/4/12.
//  Copyright © 2017年 Woodseen. All rights reserved.
//

#import "AreaStatistic+CoreDataProperties.h"

@implementation AreaStatistic (CoreDataProperties)

+ (NSFetchRequest<AreaStatistic *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"AreaStatistic"];
}

@dynamic areaName;
@dynamic brushingStatisticsID;
@dynamic correctness;
@dynamic duration;
@dynamic endTime;
@dynamic id;
@dynamic startTime;
@dynamic times;
@dynamic beIncludedByBrushingStatistics;

@end
