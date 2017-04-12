//
//  ToothBrush+CoreDataProperties.h
//  
//
//  Created by yu243e on 2017/4/12.
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
@property (nullable, nonatomic, retain) User *bePossessedByUser;
@property (nullable, nonatomic, retain) NSSet<BrushingStatistic *> *possessBrushingStatistics;

@end

@interface ToothBrush (CoreDataGeneratedAccessors)

- (void)addPossessBrushingStatisticsObject:(BrushingStatistic *)value;
- (void)removePossessBrushingStatisticsObject:(BrushingStatistic *)value;
- (void)addPossessBrushingStatistics:(NSSet<BrushingStatistic *> *)values;
- (void)removePossessBrushingStatistics:(NSSet<BrushingStatistic *> *)values;

@end

NS_ASSUME_NONNULL_END
