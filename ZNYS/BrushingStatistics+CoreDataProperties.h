//
//  BrushingStatistics+CoreDataProperties.h
//  ZNYS
//
//  Created by 张恒铭 on 12/19/15.
//  Copyright © 2015 Woodseen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BrushingStatistics.h"

NS_ASSUME_NONNULL_BEGIN

@interface BrushingStatistics (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *duration;
@property (nullable, nonatomic, retain) NSDecimalNumber *effect;
@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSNumber *starsGained;
@property (nullable, nonatomic, retain) NSNumber *timeSlot;
@property (nullable, nonatomic, retain) NSNumber *toothBrushID;
@property (nullable, nonatomic, retain) ToothBrush *bePossessedByToothBrush;
@property (nullable, nonatomic, retain) NSSet<AreaStatistics *> *includeSYQY;

@end

@interface BrushingStatistics (CoreDataGeneratedAccessors)

- (void)addIncludeSYQYObject:(AreaStatistics *)value;
- (void)removeIncludeSYQYObject:(AreaStatistics *)value;
- (void)addIncludeSYQY:(NSSet<AreaStatistics *> *)values;
- (void)removeIncludeSYQY:(NSSet<AreaStatistics *> *)values;

@end

NS_ASSUME_NONNULL_END
