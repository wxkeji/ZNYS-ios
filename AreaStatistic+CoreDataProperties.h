//
//  AreaStatistic+CoreDataProperties.h
//  
//
//  Created by 张恒铭 on 4/18/17.
//
//

#import "AreaStatistic+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface AreaStatistic (CoreDataProperties)

+ (NSFetchRequest<AreaStatistic *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *areaName;
@property (nullable, nonatomic, copy) NSString *brushingStatisticsID;
@property (nullable, nonatomic, copy) NSDecimalNumber *correctness;
@property (nullable, nonatomic, copy) NSString *duration;
@property (nullable, nonatomic, copy) NSString *endTime;
@property (nullable, nonatomic, copy) NSNumber *id;
@property (nullable, nonatomic, copy) NSString *startTime;
@property (nullable, nonatomic, copy) NSNumber *times;
@property (nullable, nonatomic, retain) BrushingStatistic *brushingStatistic;

@end

NS_ASSUME_NONNULL_END
