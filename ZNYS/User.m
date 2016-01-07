//
//  User.m
//  ZNYS
//
//  Created by 张恒铭 on 12/19/15.
//  Copyright © 2015 Woodseen. All rights reserved.
//

#import "User.h"
#import "Award.h"
#import "Belongings.h"
#import "CustomerServices.h"
#import "ToothBrush.h"
#import "CoreDataHelper.h"
@implementation User

// Insert code here to add functionality to your managed object subclass
+(User*)currentUser
{
    NSString* uuid =   [[NSUserDefaults standardUserDefaults] objectForKey:@"currentUserUID"];
    if(uuid)
    {
        User* user =   [[CoreDataHelper sharedInstance] retrieveUsers:[NSPredicate predicateWithFormat:@"uuid = %@",uuid]][0];
        return user;
    }
    else return nil;
}
+(NSString*)currentUserName
{
    return [self currentUser].nickName;
}
+(NSString*)currentUserBirthday
{
    return [self currentUser].birthday;
}
+(NSNumber*)currentUserCycleCountOfHighestLevel
{
    return [self currentUser].cycleCountOfHighestLevel;
}
+(NSString*)currentUserGender
{
    return [self currentUser].gender;
}
+(NSNumber*)currentUserLevel
{
    return [self currentUser].level;
}
+(NSNumber*)currentUserPhotoNumber
{
    return [self currentUser].photoNumber;
}
+(NSNumber*)currentUserStarsOwned
{
    return [self currentUser].starsOwned;
}
+(NSNumber*)currentUserTokenOwned
{
    return [self currentUser].tokenOwned;
}
+(NSString*)currentUserUUID
{
    return [self currentUser].uuid;
}
+(NSUInteger)currentUsersNumberOfToothBushes
{
    return [self currentUser].possessToothBrushes.count;
}
@end
