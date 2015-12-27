//
//  CustomerServices+CoreDataProperties.h
//  ZNYS
//
//  Created by 张恒铭 on 12/19/15.
//  Copyright © 2015 Woodseen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CustomerServices.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomerServices (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *id;
@property (nullable, nonatomic, retain) NSString *linkAddress;
@property (nullable, nonatomic, retain) NSString *literalDescription;
@property (nullable, nonatomic, retain) NSString *pictureURL;
@property (nullable, nonatomic, retain) NSSet<InferenceEngine *> *beOutput;
@property (nullable, nonatomic, retain) NSSet<User *> *viewYH;

@end

@interface CustomerServices (CoreDataGeneratedAccessors)

- (void)addBeOutputObject:(InferenceEngine *)value;
- (void)removeBeOutputObject:(InferenceEngine *)value;
- (void)addBeOutput:(NSSet<InferenceEngine *> *)values;
- (void)removeBeOutput:(NSSet<InferenceEngine *> *)values;

- (void)addViewYHObject:(User *)value;
- (void)removeViewYHObject:(User *)value;
- (void)addViewYH:(NSSet<User *> *)values;
- (void)removeViewYH:(NSSet<User *> *)values;

@end

NS_ASSUME_NONNULL_END
