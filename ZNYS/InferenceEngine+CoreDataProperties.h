//
//  InferenceEngine+CoreDataProperties.h
//  ZNYS
//
//  Created by 张恒铭 on 12/19/15.
//  Copyright © 2015 Woodseen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "InferenceEngine.h"

NS_ASSUME_NONNULL_BEGIN

@interface InferenceEngine (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *customerServiceID;
@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *inferenceDescription;
@property (nullable, nonatomic, retain) NSNumber *rulesID;
@property (nullable, nonatomic, retain) Rules *matchRules;
@property (nullable, nonatomic, retain) CustomerServices *outputKFXX;

@end

NS_ASSUME_NONNULL_END
