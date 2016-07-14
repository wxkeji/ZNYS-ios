//
//  ToothBrush.h
//  ZNYS
//
//  Created by 张恒铭 on 12/19/15.
//  Copyright © 2015 Woodseen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BrushingStatistics, User;

NS_ASSUME_NONNULL_BEGIN

@interface ToothBrush : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
@property (nonatomic,assign) BOOL isConnected;

@end

NS_ASSUME_NONNULL_END

#import "ToothBrush+CoreDataProperties.h"
