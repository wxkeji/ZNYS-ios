//
//  User+CoreDataProperties.m
//  ZNYS
//
//  Created by yu243e on 2017/4/10.
//  Copyright © 2017年 Woodseen. All rights reserved.
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"User"];
}

@dynamic age;
@dynamic birthday;
@dynamic cycleCountOfHighestLevel;
@dynamic gender;
@dynamic icon_url_local;
@dynamic icon_url_server;
@dynamic interationTime;
@dynamic isCurrentUser;
@dynamic isDelete;
@dynamic isRegistered;
@dynamic lastActiveTime;
@dynamic level;
@dynamic nickName;
@dynamic photoNumber;
@dynamic starsOwned;
@dynamic tokenOwned;
@dynamic uuid;
@dynamic beViewedByCustomerService;
@dynamic possessAwards;
@dynamic possessBelongings;
@dynamic possessCalenderItem;
@dynamic possessItem;
@dynamic possessToothBrushes;

@end
