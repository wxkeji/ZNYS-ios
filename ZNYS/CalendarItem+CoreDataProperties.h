//
//  CalendarItem+CoreDataProperties.h
//  ZNYS
//
//  Created by 张恒铭 on 6/29/16.
//  Copyright © 2016 Woodseen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CalendarItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface CalendarItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *awardCount;
@property (nullable, nonatomic, retain) NSString *date;
@property (nullable, nonatomic, retain) NSString *firstAwardID;
@property (nullable, nonatomic, retain) NSString *id;
@property (nullable, nonatomic, retain) NSNumber *level;
@property (nullable, nonatomic, retain) NSNumber *starNumber;
@property (nullable, nonatomic, retain) NSString *userID;
@property (nullable, nonatomic, retain) NSNumber *connectStarNumber;
@property (nullable, nonatomic, retain) NSNumber *morningStarNumber;
@property (nullable, nonatomic, retain) NSNumber *eveningStarNumber;
@property (nullable, nonatomic, retain) User *belongToUser;

@end

NS_ASSUME_NONNULL_END
