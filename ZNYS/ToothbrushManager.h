//
//  ToothbrushManager.h
//  ZNYS
//
//  Created by 张恒铭 on 7/13/16.
//  Copyright © 2016 Woodseen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataHelper.h"
#import "ToothBrush+CoreDataProperties.h"
#import "ToothBrush+CoreDataClass.h"
#import "BluetoothServer.h"
@interface ToothbrushManager : NSObject<BluetoothServerProtocol>


+ (instancetype)sharedInstance;

-(void)releaseInstance;

- (ToothBrush *)createInstance;

- (ToothBrush *)createTempInstance;

- (BOOL)saveInstance:(ToothBrush *)toothBrush;

- (NSArray*)getCurrentUsersToothBrushes;

- (ToothBrush*)getCurrentConnectedToothBrush;

@end
