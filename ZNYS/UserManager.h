//
//  UserManager.h
//  ZNYS
//
//  Created by yu243e on 16/12/16.
//  Copyright © 2016年 Woodseen. All rights reserved.
//
#import "User+CoreDataClass.h"
#import "themeManager.h"
#import <Foundation/Foundation.h>
@class UIImage;

@interface UserManager : NSObject

+ (instancetype)sharedInstance;

//Helper
+ (UIImage *)userAvatarImageWithUser:(User *)user;

//ALL Users
- (NSInteger)currentUserCount;
- (NSArray *)allUsers;
- (NSArray *)allUsersExceptUUID:(NSString *)uuid;
- (NSArray *)retrieveOtherUsersExcept:(NSString *)uuid;
- (BOOL)whetherThereIsUser;

//当前 User
- (User *)currentUser;
- (UIImage *)currentUserAvatarImage;
- (ZNYSThemeStyle)currentUserThemeStyle;

//write
- (void)changeCurrentUser:(User *)user;
- (BOOL)changeCurrentTokensByAdding:(NSInteger)number;

- (NSString*)createUserWithBirthday:(NSString *)birthday
                            gender:(BOOL)gender
                          nickName:(NSString *)nickName;
- (BOOL)modifyUserInfoWithUUID:(NSString *)UUID
                     birthday:(NSString *)Birthday
                       gender:(BOOL)gender
                     nickname:(NSString *)nickname;
@end
