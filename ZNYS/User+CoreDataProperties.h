//
//  User+CoreDataProperties.h
//  ZNYS
//
//  Created by yu243e on 2017/4/10.
//  Copyright © 2017年 Woodseen. All rights reserved.
//

#import "User+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *age;
@property (nullable, nonatomic, copy) NSString *birthday;
@property (nullable, nonatomic, copy) NSNumber *cycleCountOfHighestLevel;
@property (nullable, nonatomic, copy) NSString *gender;
@property (nullable, nonatomic, copy) NSString *icon_url_local;
@property (nullable, nonatomic, copy) NSString *icon_url_server;
@property (nullable, nonatomic, copy) NSNumber *interationTime;
@property (nullable, nonatomic, copy) NSNumber *isCurrentUser;
@property (nullable, nonatomic, copy) NSNumber *isDelete;
@property (nullable, nonatomic, copy) NSNumber *isRegistered;
@property (nullable, nonatomic, copy) NSNumber *lastActiveTime;
@property (nullable, nonatomic, copy) NSDecimalNumber *level;
@property (nullable, nonatomic, copy) NSString *nickName;
@property (nullable, nonatomic, copy) NSNumber *photoNumber;
@property (nullable, nonatomic, copy) NSNumber *starsOwned;
@property (nullable, nonatomic, copy) NSNumber *tokenOwned;
@property (nullable, nonatomic, copy) NSString *uuid;
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
