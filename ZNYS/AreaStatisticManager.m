

//
//  AreaStatisticManager.m
//  ZNYS
//
//  Created by 张恒铭 on 4/17/17.
//  Copyright © 2017 Woodseen. All rights reserved.
//

#import "AreaStatisticManager.h"
#import "CoreDataHelper.h"

const NSString *entityName = @"AreaStatistic";

@implementation AreaStatisticManager

+ (instancetype)sharedInstance {
    static AreaStatisticManager* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AreaStatisticManager alloc] init];
    });
    return instance;
}


- (AreaStatistic *)createAreaStatistic {
    AreaStatistic *instance =  [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:[CoreDataHelper sharedInstance].context];
    return instance;
}


- (NSArray *)fetchAreaStatisticWithPredicate:(NSPredicate *)predicate {
    NSArray *result;
    NSManagedObjectContext *context = [CoreDataHelper sharedInstance].context;
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    if (predicate) {
        [request setPredicate:predicate];
    }
    result = [context executeFetchRequest:request error:nil];
    return result;
}

@end
