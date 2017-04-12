//
//  Award+CoreDataProperties.m
//  ZNYS
//
//  Created by yu243e on 2017/4/12.
//  Copyright © 2017年 Woodseen. All rights reserved.
//

#import "Award+CoreDataProperties.h"

@implementation Award (CoreDataProperties)

+ (NSFetchRequest<Award *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Award"];
}

@dynamic awardDescription;
@dynamic exchangeData;
@dynamic level;
@dynamic maxPrice;
@dynamic minPrice;
@dynamic name;
@dynamic pitcureURL;
@dynamic price;
@dynamic priority;
@dynamic status;
@dynamic type;
@dynamic userID;
@dynamic uuid;
@dynamic voice;
@dynamic bePossessedByUser;

@end
