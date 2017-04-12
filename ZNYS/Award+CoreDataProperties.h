//
//  Award+CoreDataProperties.h
//  ZNYS
//
//  Created by yu243e on 2017/4/12.
//  Copyright © 2017年 Woodseen. All rights reserved.
//

#import "Award+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Award (CoreDataProperties)

+ (NSFetchRequest<Award *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *awardDescription;
@property (nullable, nonatomic, copy) NSString *exchangeData;
@property (nonatomic) int32_t level;
@property (nonatomic) int32_t maxPrice;
@property (nonatomic) int32_t minPrice;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *pitcureURL;
@property (nonatomic) int32_t price;
@property (nonatomic) int32_t priority;
@property (nullable, nonatomic, copy) NSString *status;
@property (nullable, nonatomic, copy) NSString *type;
@property (nullable, nonatomic, copy) NSString *userID;
@property (nullable, nonatomic, copy) NSString *uuid;
@property (nullable, nonatomic, copy) NSString *voice;
@property (nullable, nonatomic, retain) User *bePossessedByUser;

@end

NS_ASSUME_NONNULL_END
