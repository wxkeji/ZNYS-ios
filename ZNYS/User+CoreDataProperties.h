//
//  User+CoreDataProperties.h
//  ZNYS
//
//  Created by yu243e on 2017/4/11.
//  Copyright © 2017年 Woodseen. All rights reserved.
//

#import "User+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *birthday;
@property (nonatomic) BOOL gender;
@property (nonatomic) int16_t level;
@property (nullable, nonatomic, copy) NSString *nickName;
@property (nullable, nonatomic, copy) NSString *photoURL;
@property (nonatomic) int16_t starsOwned;
@property (nonatomic) int16_t tokensOwned;
@property (nullable, nonatomic, copy) NSString *uuid;
@property (nonatomic) int16_t historyTokens;
@property (nullable, nonatomic, retain) CustomerServices *beViewedByCustomerService;
@property (nullable, nonatomic, retain) NSSet<Award *> *possessAwards;
@property (nullable, nonatomic, retain) NSSet<Belongings *> *possessBelongings;
@property (nullable, nonatomic, retain) NSSet<CalendarItem *> *possessCalenderItem;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *possessItem;
@property (nullable, nonatomic, retain) NSSet<ToothBrush *> *possessToothBrushes;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addPossessAwardsObject:(Award *)value;
- (void)removePossessAwardsObject:(Award *)value;
- (void)addPossessAwards:(NSSet<Award *> *)values;
- (void)removePossessAwards:(NSSet<Award *> *)values;

- (void)addPossessBelongingsObject:(Belongings *)value;
- (void)removePossessBelongingsObject:(Belongings *)value;
- (void)addPossessBelongings:(NSSet<Belongings *> *)values;
- (void)removePossessBelongings:(NSSet<Belongings *> *)values;

- (void)addPossessCalenderItemObject:(CalendarItem *)value;
- (void)removePossessCalenderItemObject:(CalendarItem *)value;
- (void)addPossessCalenderItem:(NSSet<CalendarItem *> *)values;
- (void)removePossessCalenderItem:(NSSet<CalendarItem *> *)values;

- (void)addPossessItemObject:(NSManagedObject *)value;
- (void)removePossessItemObject:(NSManagedObject *)value;
- (void)addPossessItem:(NSSet<NSManagedObject *> *)values;
- (void)removePossessItem:(NSSet<NSManagedObject *> *)values;

- (void)addPossessToothBrushesObject:(ToothBrush *)value;
- (void)removePossessToothBrushesObject:(ToothBrush *)value;
- (void)addPossessToothBrushes:(NSSet<ToothBrush *> *)values;
- (void)removePossessToothBrushes:(NSSet<ToothBrush *> *)values;

@end

NS_ASSUME_NONNULL_END
