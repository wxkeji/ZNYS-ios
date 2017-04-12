//
//  User+CoreDataProperties.m
//  ZNYS
//
//  Created by yu243e on 2017/4/11.
//  Copyright © 2017年 Woodseen. All rights reserved.
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"User"];
}

@dynamic birthday;
@dynamic gender;
@dynamic level;
@dynamic nickName;
@dynamic photoURL;
@dynamic starsOwned;
@dynamic tokensOwned;
@dynamic uuid;
@dynamic historyTokens;
@dynamic beViewedByCustomerService;
@dynamic possessAwards;
@dynamic possessBelongings;
@dynamic possessCalenderItem;
@dynamic possessItem;
@dynamic possessToothBrushes;

@end
