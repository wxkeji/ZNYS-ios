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
#warning 实现 currentUserCount
- (NSInteger)currentUserCount {
    return [self allUsers].count;
}

- (NSArray *)allUsers {
    return [[CoreDataHelper sharedInstance] retrieveUsers:nil];
}

#pragma mark - currentUser read
- (User *)currentUser
{
    //+++ !!! 这种方式必须保证修改用户语句不在此处之外
    if (!self.user) {
        NSString * uuid =   [[NSUserDefaults standardUserDefaults] objectForKey:@"currentUserUID"];
        if(uuid)
        {
            //+++ 应考虑数据库异常
            User * currentUser =   [[CoreDataHelper sharedInstance] retrieveUsers:[NSPredicate predicateWithFormat:@"uuid = %@",uuid]][0];
            self.user = currentUser;
        } else {
            //+++ NSUserDefault没有当前 User 应有默认或异常处理。
        }
    }
    return self.user;
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
