//
//  UserDetailInformationView.h
//  ZNYS
//
//  Created by yu243e on 16/10/5.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ZNYSBaseView.h"
@class User;
@protocol UserDetailInforationViewDelegate;
@protocol UserDetailInforationViewDatasource;

@interface UserDetailInformationView : ZNYSBaseView

@property (nonatomic, weak) id<UserDetailInforationViewDelegate> delegate;

- (void)showAnimationWithDelay:(NSTimeInterval)delay;
- (NSTimeInterval)showCloseAnimation;

@end

@protocol UserDetailInforationViewDelegate <NSObject>

- (void)dismissUserDetailView;

@end
@protocol UserDetailInforationViewDatasource <NSObject>

//requestUserAcount 以确定是否加入切换条
- (NSInteger)numberOfUsers;
- (User *)userAtIndex:(NSInteger)index;
@end