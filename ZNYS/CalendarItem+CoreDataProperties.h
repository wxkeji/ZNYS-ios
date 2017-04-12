//
//  CalendarItem+CoreDataProperties.h
//  ZNYS
//
//  Created by yu243e on 2017/4/12.
//  Copyright © 2017年 Woodseen. All rights reserved.
//

#import "CalendarItem+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CalendarItem (CoreDataProperties)

+ (NSFetchRequest<CalendarItem *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *awardCount;
@property (nullable, nonatomic, copy) NSNumber *connectStarNumber;
@property (nullable, nonatomic, copy) NSString *date;
@property (nullable, nonatomic, copy) NSNumber *eveningStarNumber;
@property (nullable, nonatomic, copy) NSString *firstAwardID;
@property (nullable, nonatomic, copy) NSString *id;
@property (nullable, nonatomic, copy) NSNumber *level;
@property (nullable, nonatomic, copy) NSNumber *morningStarNumber;
@property (nullable, nonatomic, copy) NSNumber *starNumber;
@property (nullable, nonatomic, copy) NSString *userID;
@property (nullable, nonatomic, retain) User *belongToUser;

@end

NS_ASSUME_NONNULL_END
