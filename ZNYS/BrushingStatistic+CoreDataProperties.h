//
//  BrushingStatistic+CoreDataProperties.h
//  
//
//  Created by 张恒铭 on 4/18/17.
//
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
@property (nullable, nonatomic, retain) ToothBrush *areaStatistic;
@property (nullable, nonatomic, retain) NSSet<AreaStatistic *> *toothBrush;

@end

@interface BrushingStatistic (CoreDataGeneratedAccessors)

- (void)addToothBrushObject:(AreaStatistic *)value;
- (void)removeToothBrushObject:(AreaStatistic *)value;
- (void)addToothBrush:(NSSet<AreaStatistic *> *)values;
- (void)removeToothBrush:(NSSet<AreaStatistic *> *)values;

@end

NS_ASSUME_NONNULL_END
