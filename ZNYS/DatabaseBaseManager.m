//
//  DatabaseBaseManager.m
//  ZNYS
//
//  Created by 张恒铭 on 4/19/17.
//  Copyright © 2017 Woodseen. All rights reserved.
//

#import "DatabaseBaseManager.h"

@implementation DatabaseBaseManager

+ (instancetype)sharedInstance {
    static __strong typeof([self class]) instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });    
    return instance;
}

- (instancetype)init {
    //子类中重载
    return self;
}

@end
