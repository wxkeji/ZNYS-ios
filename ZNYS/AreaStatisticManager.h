//
//  AreaStatisticManager.h
//  ZNYS
//
//  Created by 张恒铭 on 4/17/17.
//  Copyright © 2017 Woodseen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AreaStatistic+CoreDataClass.h"


@interface AreaStatisticManager : NSObject

+ (instancetype)sharedInstance;

//CRUD
- (AreaStatistic *)createAreaStatistic;

- (NSArray *)fetchAreaStatisticWithPredicate:(NSPredicate *)predicate;

- (BOOL)deleteAreaStatistic:(AreaStatistic *)statistic;

@end
