//
//  User+CoreDataProperties.h
//  ZNYS
//
//  Created by yu243e on 2017/4/12.
//  Copyright © 2017年 Woodseen. All rights reserved.
//

#import "User+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *birthday;
@property (nonatomic) BOOL gender;
@property (nonatomic) int16_t historyTokens;
@property (nonatomic) int16_t level;
@property (nullable, nonatomic, copy) NSString *nickName;
@property (nullable, nonatomic, copy) NSString *photoURL;
@property (nonatomic) int16_t starsOwned;
@property (nonatomic) int16_t tokensOwned;
@property (nullable, nonatomic, copy) NSString *uuid;
@property (nullable, nonatomic, retain) NSSet<Award *> *awards;
@property (nullable, nonatomic, retain) NSSet<CalendarItem *> *calenderItems;
@property (nullable, nonatomic, retain) NSSet<ToothBrush *> *toothBrushes;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addAwardsObject:(Award *)value;
- (void)removeAwardsObject:(Award *)value;
- (void)addAwards:(NSSet<Award *> *)values;
- (void)removeAwards:(NSSet<Award *> *)values;

- (void)addCalenderItemsObject:(CalendarItem *)value;
- (void)removeCalenderItemsObject:(CalendarItem *)value;
- (void)addCalenderItems:(NSSet<CalendarItem *> *)values;
- (void)removeCalenderItems:(NSSet<CalendarItem *> *)values;

- (void)addToothBrushesObject:(ToothBrush *)value;
- (void)removeToothBrushesObject:(ToothBrush *)value;
- (void)addToothBrushes:(NSSet<ToothBrush *> *)values;
- (void)removeToothBrushes:(NSSet<ToothBrush *> *)values;

@end

NS_ASSUME_NONNULL_END
