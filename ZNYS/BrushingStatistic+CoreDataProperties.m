//
//  BrushingStatistic+CoreDataProperties.m
//  
//
//  Created by 张恒铭 on 4/18/17.
//
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
@dynamic areaStatistic;
@dynamic toothBrush;

@end
