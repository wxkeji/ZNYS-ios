//
//  Belongings+CoreDataProperties.h
//  ZNYS
//
//  Created by 张恒铭 on 12/19/15.
//  Copyright © 2015 Woodseen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Belongings.h"

NS_ASSUME_NONNULL_BEGIN

@interface Belongings (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *status;
@property (nullable, nonatomic, retain) NSString *uuid;
@property (nullable, nonatomic, retain) NSString *xAxis;
@property (nullable, nonatomic, retain) NSString *yAxis;
@property (nullable, nonatomic, retain) User *bePossessedByYH;

@end

NS_ASSUME_NONNULL_END
