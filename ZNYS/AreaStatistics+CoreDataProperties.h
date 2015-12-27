//
//  AreaStatistics+CoreDataProperties.h
//  ZNYS
//
//  Created by 张恒铭 on 12/19/15.
//  Copyright © 2015 Woodseen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "AreaStatistics.h"

NS_ASSUME_NONNULL_BEGIN

@interface AreaStatistics (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *area;
@property (nullable, nonatomic, retain) NSDecimalNumber *correctness;
@property (nullable, nonatomic, retain) NSString *duration;
@property (nullable, nonatomic, retain) NSString *endTime;
@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *startTime;
@property (nullable, nonatomic, retain) NSNumber *times;
@property (nullable, nonatomic, retain) BrushingStatistics *beIncludedByBrushingStatistics;

@end

NS_ASSUME_NONNULL_END
