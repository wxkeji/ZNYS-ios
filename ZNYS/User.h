//
//  User.h
//  ZNYS
//
//  Created by 张恒铭 on 12/19/15.
//  Copyright © 2015 Woodseen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Award, Belongings, CustomerServices, ToothBrush;

NS_ASSUME_NONNULL_BEGIN

@interface User : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+(User*)currentUser;
+(NSString*)currentUserName;
+(NSString*)currentUserBirthday;
+(NSNumber*)currentUserCycleCountOfHighestLevel;
+(NSString*)currentUserGender;
+(NSNumber*)currentUserLevel;
+(NSNumber*)currentUserPhotoNumber;
+(NSNumber*)currentUserStarsOwned;
+(NSNumber*)currentUserTokenOwned;
+(NSString*)currentUserUUID;
@end

NS_ASSUME_NONNULL_END

#import "User+CoreDataProperties.h"
