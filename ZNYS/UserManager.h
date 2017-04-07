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
@interface UserManager : NSObject


+ (instancetype)sharedInstance;

//ALL Users
- (NSInteger)currentUserCount;
- (NSArray *)allUsers;
- (NSArray *)allUsersExceptUUID:(NSString *)uuid;
- (NSArray *)retrieveOtherUsersExcept:(NSString *)uuid;
- (BOOL)whetherThereIsUser;

//当前 User
- (User *)currentUser;
- (NSString *)currentUserUUID;
- (NSString *)currentUserName;
- (NSString *)currentUserBirthday;
- (NSString *)currentUserGender;
- (NSInteger)currentUserLevel;
- (NSInteger)currentUserPhotoNumber;
- (NSInteger)currentUserStarsOwned;
- (NSInteger)currentUserTokenOwned;
- (NSInteger)currentUsersNumberOfToothBushes;

- (ZNYSThemeStyle)currentUserThemeStyle;

//write
- (void)changeCurrentUser:(User *)user;
- (BOOL)changeCurrentTokensByAdding:(NSInteger)number;

@end
