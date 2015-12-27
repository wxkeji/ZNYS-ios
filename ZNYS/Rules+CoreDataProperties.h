//
//  Rules+CoreDataProperties.h
//  ZNYS
//
//  Created by 张恒铭 on 12/19/15.
//  Copyright © 2015 Woodseen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Rules.h"

NS_ASSUME_NONNULL_BEGIN

@interface Rules (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *leftValue;
@property (nullable, nonatomic, retain) NSString *operation;
@property (nullable, nonatomic, retain) NSNumber *recursiveID;
@property (nullable, nonatomic, retain) NSString *rightValue;
@property (nullable, nonatomic, retain) NSSet<InferenceEngine *> *matchInferenceEngine;

@end

@interface Rules (CoreDataGeneratedAccessors)

- (void)addMatchInferenceEngineObject:(InferenceEngine *)value;
- (void)removeMatchInferenceEngineObject:(InferenceEngine *)value;
- (void)addMatchInferenceEngine:(NSSet<InferenceEngine *> *)values;
- (void)removeMatchInferenceEngine:(NSSet<InferenceEngine *> *)values;

@end

NS_ASSUME_NONNULL_END
