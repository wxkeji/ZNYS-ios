//
//  ToothbrushManager.m
//  ZNYS
//
//  Created by 张恒铭 on 7/13/16.
//  Copyright © 2016 Woodseen. All rights reserved.
//

#import "ToothbrushManager.h"
#import "CoreDataHelper.h"
#import "ToothBrush+CoreDataProperties.h"
#import "UserManager.h"
@implementation ToothbrushManager
static ToothbrushManager* instance;
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    if (!instance) {
        dispatch_once(&onceToken, ^{
            instance = [[ToothbrushManager alloc] init];
        });
    }
    return instance;
}
-(void)releaseInstance {
    instance = nil;
}

- (NSArray*)getCurrentUsersToothBrushes {
    NSArray* result = [[CoreDataHelper sharedInstance] retrieveToothBrushWithPredicate:[NSPredicate predicateWithFormat:@"userUUID = %@",[[UserManager sharedInstance] currentUser].uuid]];
    if (result.count > 0) {
        return result;
    } else {
        return nil;
    }
}

//BUG +++  暂时 toothBrush.isConnected -> YES
#warning BUG ToothBrushManager.m by yu
- (ToothBrush*)getCurrentConnectedToothBrush {
    NSArray* toothBrushArray = [self getCurrentUsersToothBrushes];
    for (ToothBrush* toothBrush in toothBrushArray) {
        if (YES/*toothBrush.isConnected*/) {
            //返回第一个已连接的牙刷
            return toothBrush;
        }
    }
    return nil;
}



@end
