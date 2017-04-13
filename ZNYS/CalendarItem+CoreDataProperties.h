//
//  CalendarItem+CoreDataProperties.h
//  ZNYS
//
//  Created by yu243e on 2017/4/13.
//  Copyright © 2017年 Woodseen. All rights reserved.
//

#import "CalendarItem+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CalendarItem (CoreDataProperties)

+ (NSFetchRequest<CalendarItem *> *)fetchRequest;

@property (nonatomic) int16_t connectStarNumber;
@property (nullable, nonatomic, copy) NSString *date;
@property (nonatomic) int16_t eveningStarNumber;
@property (nonatomic) int16_t morningStarNumber;
@property (nonatomic) int16_t starNumber;
@property (nullable, nonatomic, retain) User *user;

@end

NS_ASSUME_NONNULL_END
