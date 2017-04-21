//
//  ToothBrush+CoreDataProperties.h
//  
//
//  Created by 张恒铭 on 4/18/17.
//
//

#import "ToothBrush+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ToothBrush (CoreDataProperties)

+ (NSFetchRequest<ToothBrush *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *bindTime;
@property (nullable, nonatomic, copy) NSString *lastConnectTime;
@property (nullable, nonatomic, copy) NSString *macAddress;
@property (nullable, nonatomic, copy) NSString *nickname;
@property (nullable, nonatomic, copy) NSNumber *photoNumber;
@property (nullable, nonatomic, copy) NSNumber *toothbrushID;
@property (nullable, nonatomic, copy) NSString *userUUID;
@property (nullable, nonatomic, retain) NSSet<BrushingStatistic *> *brushingStatistic;
@property (nullable, nonatomic, retain) User *user;

@end

@interface ToothBrush (CoreDataGeneratedAccessors)

- (void)addBrushingStatisticObject:(BrushingStatistic *)value;
- (void)removeBrushingStatisticObject:(BrushingStatistic *)value;
- (void)addBrushingStatistic:(NSSet<BrushingStatistic *> *)values;
- (void)removeBrushingStatistic:(NSSet<BrushingStatistic *> *)values;

@end

NS_ASSUME_NONNULL_END
