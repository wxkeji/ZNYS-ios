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
#import "NSDate+Helper.h"
#import <UIKit/UIKit.h>

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

#pragma mark - helper
+ (NSInteger)levelFromHistoryTokens:(NSInteger)historyTokens {
    NSInteger level = 1;
    while (historyTokens >= 0) {
        level += 1;
        historyTokens = historyTokens - (NSInteger)pow(level - 1, 2);
    }
    level -= 1;
    return level;
}

//根据用户性别返回用户头像，后期再加入判断是否已有头像图片
+ (UIImage *)userAvatarImageWithUser:(User *)user {
    UIImage *image;
    if (!user.gender) {
        image = [UIImage imageNamed:@"user/boyDefault"];
    } else {
        image = [UIImage imageNamed:@"user/girlDefault"];
    }
    return image;
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

//thumb 决定黄丕臻写的选择用户界面的背景颜色，原为 photoNumber 字段
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
            [arrayReturned addObject:@{@"name":user.nickName,@"thumb":@(user.gender),@"uuid":user.uuid}];
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

//此版本根据性别生成用户头像
- (UIImage *)currentUserAvatarImage {
    UIImage *image = [UserManager userAvatarImageWithUser:[self currentUser]];
    return image;
}

- (ZNYSThemeStyle)currentUserThemeStyle {
    if ([self currentUser].gender == NO) {
        return ZNYSThemeStyleBlue;
    } else {
        return ZNYSThemeStylePink;
    }
}

#pragma mark - currentUser write
- (void)changeCurrentUser:(User *)user {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:user.uuid forKey:@"currentUserUID"];
    self.user = user;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userDidSwitch" object:nil];
}
/**
 改变代币数，如果增加同时改变历史代币数

 @param numbers 可以是正数或负数
 @return 成功返回YES
 */
- (BOOL)changeCurrentTokensByAdding:(NSInteger)number {
    if (number > 0) {
        [self currentUser].tokensOwned += number;
        [self currentUser].historyTokens += number;
    } else {
        NSInteger lastToken = [self currentUser].tokensOwned + number;
        if (lastToken > 0) {
            [self currentUser].tokensOwned = [self currentUser].tokensOwned + number;
        } else {
            return false;
        }
    }
    return true;
}

//test +++
-(NSString*)createUserWithBirthday:(NSString*)birthday
                            gender:(BOOL)gender
                          nickName:(NSString*)nickName
{
    User* user =  [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:[CoreDataHelper sharedInstance].context];
    
    user.birthday = birthday;
    
    user.gender = gender;
    user.nickName = nickName;
    user.starsOwned = 3;    //test
    user.tokensOwned = 20;
    user.historyTokens = 30;
    user.level = [UserManager levelFromHistoryTokens:user.historyTokens];
    user.uuid = [[NSUUID UUID] UUIDString];
    
    [[CoreDataHelper sharedInstance] save];
    
    [[NSUserDefaults standardUserDefaults]setObject:user.uuid forKey:@"currentUserUID"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userDidCreate" object:nil];
    return user.uuid;
}

- (BOOL)modifyUserInfoWithUUID:(NSString*)UUID
                      birthday:(NSString*)birthday
                        gender:(BOOL)gender
                      nickname:(NSString*)nickname
{
    User* userToBeModified  =  [self retrieveUsers:[NSPredicate predicateWithFormat:@"uuid = %@",UUID]][0];
    userToBeModified.birthday = birthday;
    userToBeModified.gender = gender;
    userToBeModified.nickName = nickname;
    [[CoreDataHelper sharedInstance] save];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userDetailDidChange" object:nil];
    return YES;
}

@end
