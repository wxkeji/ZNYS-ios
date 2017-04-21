//
//  DatabaseBaseManager.h
//  ZNYS
//
//  Created by 张恒铭 on 4/19/17.
//  Copyright © 2017 Woodseen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseBaseManager : NSObject

+ (instancetype)sharedInstance;

- (instancetype)createInstance;

- (NSArray *)fetchInstanceWithPredicate:(NSPredicate *)predicate;

- (BOOL)deleteInstance:(void*)instance;

@end
