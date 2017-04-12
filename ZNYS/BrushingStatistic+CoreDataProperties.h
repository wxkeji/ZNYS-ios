//
//  BrushingStatistic+CoreDataProperties.h
//  ZNYS
//
//  Created by yu243e on 2017/4/12.
//  Copyright © 2017年 Woodseen. All rights reserved.
//

#import "BrushingStatistic+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface BrushingStatistic (CoreDataProperties)

+ (NSFetchRequest<BrushingStatistic *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *cleanliness;
@property (nullable, nonatomic, copy) NSString *duration;
@property (nullable, nonatomic, copy) NSDecimalNumber *effect;
@property (nullable, nonatomic, copy) NSString *id;
@property (nullable, nonatomic, copy) NSNumber *speed;
@property (nullable, nonatomic, copy) NSNumber *starsGained;
@property (nullable, nonatomic, copy) NSNumber *strength;
@property (nullable, nonatomic, copy) NSNumber *timeSlot;
@property (nullable, nonatomic, copy) NSNumber *toothBrushID;
@property (nullable, nonatomic, retain) ToothBrush *bePossessedByToothBrush;
@property (nullable, nonatomic, retain) NSSet<AreaStatistic *> *includeAreaStatistics;

@end

@interface BrushingStatistic (CoreDataGeneratedAccessors)

- (void)addIncludeAreaStatisticsObject:(AreaStatistic *)value;
- (void)removeIncludeAreaStatisticsObject:(AreaStatistic *)value;
- (void)addIncludeAreaStatistics:(NSSet<AreaStatistic *> *)values;
- (void)removeIncludeAreaStatistics:(NSSet<AreaStatistic *> *)values;

@end

NS_ASSUME_NONNULL_END
