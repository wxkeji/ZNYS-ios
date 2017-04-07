//
//  UserManager.m
//  ZNYS
//
//  Created by yu243e on 16/12/16.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "UserManager.h"
#import "User+CoreDataProperties.h"
#import "CoreDataHelper.h"

@interface UserManager()
@property (nonatomic, strong, readwrite) User *user;
@end

@implementation UserManager
#pragma mark - singlton
+ (instancetype)sharedInstance
{
    static UserManager* sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[UserManager alloc] init];
    });
    return sharedManager;
}

#pragma mark - all
-(NSArray *)retrieveUsers:(NSPredicate*)predicate
{
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    [request setPredicate:predicate];
    return [[CoreDataHelper sharedInstance].context executeFetchRequest:request error:nil];
}

- (NSInteger)currentUserCount {
    return [self allUsers].count;
}

- (NSArray *)allUsers {
    return [self retrieveUsers:nil];
}

-(BOOL)whetherThereIsUser
{
    if([self retrieveUsers:nil].count)
    {
        return YES;
    }
    else
        return NO;
}
// 传入 nil 则取当前用户以外的所有用户
- (NSArray *)allUsersExceptUUID:(NSString *)uuid {
    NSMutableArray *retrieveUsers = [[self retrieveUsers:nil] mutableCopy];
    if (uuid == nil) {
        for (int i = 0; i < retrieveUsers.count; i++) {
            if ([[self currentUser].uuid isEqualToString:((User *)retrieveUsers[i]).uuid]) {
                [retrieveUsers removeObjectAtIndex:i];
                break;
            }
        }
    } else {
        for (int i = 0; i < retrieveUsers.count; i++) {
            if ([uuid isEqualToString:((User *)retrieveUsers[i]).uuid]) {
                [retrieveUsers removeObjectAtIndex:i];
                break;
            }
        }
    }
    return retrieveUsers;
}

//符合黄丕臻的要求的返回数据  传入 nil 即排除当前 user
- (NSArray *)retrieveOtherUsersExcept:(NSString *)uuid
{
    NSArray* tempResult;
    if (uuid == nil) {
        tempResult = [self allUsersExceptUUID:nil];
    } else {
        tempResult = [self retrieveUsers:[NSPredicate predicateWithFormat:@"uuid != %@",uuid]];
    }
    NSMutableArray *arrayReturned = [[NSMutableArray alloc] init];
    if (tempResult.count > 0)
    {
        for (User *user in tempResult)
        {
            [arrayReturned addObject:@{@"name":user.nickName,@"thumb":user.photoNumber,@"uuid":user.uuid}];
        }
        return arrayReturned;
        
    }
    else return nil;
}
#pragma mark - currentUser read
- (User *)currentUser
{
    //!!! 这种方式必须保证修改用户语句不在此处之外
    if (!self.user) {
        NSString * uuid =   [[NSUserDefaults standardUserDefaults] objectForKey:@"currentUserUID"];
        if(uuid)
        {
            //+++ 应考虑数据库异常
            User * currentUser =   [self retrieveUsers:[NSPredicate predicateWithFormat:@"uuid = %@",uuid]][0];
            self.user = currentUser;
        } else {
            //否则设定用户为第一个用户
            User * currentUser =   [self retrieveUsers:[NSPredicate predicateWithFormat:@"uuid = %@",uuid]][0];
            [self setUser:currentUser];
        }
    }
    return self.user;
}

- (ZNYSThemeStyle)currentUserThemeStyle {
    NSLog(@"++++ %@", [self currentUserGender]);
    if ([[self currentUser].gender isEqualToString:@"0"]) {
        return ZNYSThemeStyleBlue;
    } else {
        return ZNYSThemeStylePink;
    }
}

- (NSString *)currentUserName
{
    return [self currentUser].nickName;
}
- (NSString *)currentUserBirthday
{
    return [self currentUser].birthday;
}
- (NSNumber *)currentUserCycleCountOfHighestLevel
{
    return [self currentUser].cycleCountOfHighestLevel;
}
- (NSString *)currentUserGender
{
    return [self currentUser].gender;
}
- (NSInteger)currentUserLevel
{
    return [[self currentUser].level integerValue];
}
- (NSInteger)currentUserPhotoNumber
{
    return [[self currentUser].photoNumber integerValue];
}
- (NSInteger)currentUserStarsOwned
{
    return [[self currentUser].starsOwned integerValue];
}
- (NSInteger)currentUserTokenOwned
{
    return [[self currentUser].tokenOwned integerValue];
}
- (NSString *)currentUserUUID
{
    return [self currentUser].uuid;
}
- (NSInteger)currentUsersNumberOfToothBushes
{
    return [self currentUser].possessToothBrushes.count;
}

#pragma mark - currentUser write
- (void)changeCurrentUser:(User *)user {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:user.uuid forKey:@"currentUserUID"];
    self.user = user;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userDidSwitch" object:nil];
}
/**
 改变代币数

 @param numbers 可以是整数或复数
 @return 成功返回YES
 */
- (BOOL)changeCurrentTokensByAdding:(NSInteger)number {
    NSInteger lastToken = [self currentUserTokenOwned] - number;
    if (lastToken > 0) {
        [self currentUser].tokenOwned = @([self currentUserTokenOwned] - number);
    } else {
        return false;
    }
    return true;
}
@end
