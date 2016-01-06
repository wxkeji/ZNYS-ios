//
//  User+CoreDataProperties.h
//  ZNYS
//
//  Created by 张恒铭 on 12/19/15.
//  Copyright © 2015 Woodseen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *age;
@property (nullable, nonatomic, retain) NSNumber *cycleCountOfHighestLevel;
@property (nullable, nonatomic, retain) NSString *gender;
@property (nullable, nonatomic, retain) NSNumber *level;
@property (nullable, nonatomic, retain) NSString *nickName;
@property (nullable, nonatomic, retain) NSNumber *photoNumber;
@property (nullable, nonatomic, retain) NSNumber *starsOwned;
@property (nullable, nonatomic, retain) NSNumber *tokenOwned;
@property (nullable, nonatomic, retain) NSString *uuid;
@property (nullable, nonatomic, retain) NSString *birthday;
@property (nullable, nonatomic, retain) CustomerServices *beViewedByCustomerService;
@property (nullable, nonatomic, retain) NSSet<Award *> *possessAwards;
@property (nullable, nonatomic, retain) NSSet<Belongings *> *possessBelongings;
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

- (void)addPossessToothBrushesObject:(ToothBrush *)value;
- (void)removePossessToothBrushesObject:(ToothBrush *)value;
- (void)addPossessToothBrushes:(NSSet<ToothBrush *> *)values;
- (void)removePossessToothBrushes:(NSSet<ToothBrush *> *)values;

@end

NS_ASSUME_NONNULL_END
