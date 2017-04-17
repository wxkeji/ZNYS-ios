//
//  User+CoreDataProperties.m
//  ZNYS
//
//  Created by yu243e on 2017/4/17.
//  Copyright © 2017年 Woodseen. All rights reserved.
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"User"];
}

@dynamic birthday;
@dynamic gender;
@dynamic historyTokens;
@dynamic level;
@dynamic nickName;
@dynamic starsOwned;
@dynamic tokensOwned;
@dynamic uuid;
@dynamic awards;
@dynamic calenderItems;
@dynamic toothBrushes;

@end
