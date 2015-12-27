//
//  ToothBrush+CoreDataProperties.h
//  ZNYS
//
//  Created by 张恒铭 on 12/19/15.
//  Copyright © 2015 Woodseen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ToothBrush.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToothBrush (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *macAddress;
@property (nullable, nonatomic, retain) NSString *nickname;
@property (nullable, nonatomic, retain) NSNumber *photoNumber;
@property (nullable, nonatomic, retain) NSString *userUUID;
@property (nullable, nonatomic, retain) User *bePossessedByUser;
@property (nullable, nonatomic, retain) NSSet<BrushingStatistics *> *possessBrushingStatistics;

@end

@interface ToothBrush (CoreDataGeneratedAccessors)

- (void)addPossessBrushingStatisticsObject:(BrushingStatistics *)value;
- (void)removePossessBrushingStatisticsObject:(BrushingStatistics *)value;
- (void)addPossessBrushingStatistics:(NSSet<BrushingStatistics *> *)values;
- (void)removePossessBrushingStatistics:(NSSet<BrushingStatistics *> *)values;

@end

NS_ASSUME_NONNULL_END
