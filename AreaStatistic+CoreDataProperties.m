//
//  AreaStatistic+CoreDataProperties.m
//  
//
//  Created by 张恒铭 on 4/18/17.
//
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
@dynamic brushingStatistic;

@end
