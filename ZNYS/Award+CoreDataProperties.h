//
//  Award+CoreDataProperties.h
//  ZNYS
//
//  Created by 张恒铭 on 4/24/16.
//  Copyright © 2016 Woodseen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Award.h"

NS_ASSUME_NONNULL_BEGIN

@interface Award (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *awardDescription;
@property (nullable, nonatomic, retain) NSString *exchangeData;
@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSNumber *level;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *pitcureURL;
@property (nullable, nonatomic, retain) NSNumber *price;
@property (nullable, nonatomic, retain) NSNumber *priority;
@property (nullable, nonatomic, retain) NSString *status;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSString *userID;
@property (nullable, nonatomic, retain) NSString *uuid;
@property (nullable, nonatomic, retain) NSNumber *voice;
@property (nullable, nonatomic, retain) User *bePossessedByUser;

@end

NS_ASSUME_NONNULL_END
