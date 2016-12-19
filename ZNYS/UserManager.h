//
//  UserManager.h
//  ZNYS
//
//  Created by yu243e on 16/12/16.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface UserManager : NSObject


+ (instancetype)sharedInstance;

//ALL User
- (NSInteger)currentUserCount;

//当前 User
- (NSString *)currentUserUUID;
- (NSString *)currentUserName;
- (NSString *)currentUserBirthday;
- (NSString *)currentUserGender;
- (NSInteger)currentUserLevel;
- (NSInteger)currentUserPhotoNumber;
- (NSInteger)currentUserStarsOwned;
- (NSInteger)currentUserTokenOwned;
- (NSInteger)currentUsersNumberOfToothBushes;

//操作数量
- (BOOL)changeCurrentTokensByAdding:(NSInteger)number;

@end
