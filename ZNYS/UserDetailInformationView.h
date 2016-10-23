//
//  UserDetailInformationView.h
//  ZNYS
//
//  Created by yu243e on 16/10/5.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ZNYSBaseView.h"
@protocol UserDetailInforationViewDelegate;
static const CGFloat mainHeight = 200;
static const CGFloat switchHeight = 100;

@interface UserDetailInformationView : ZNYSBaseView

@property (nonatomic, weak) id<UserDetailInforationViewDelegate> delegate;
@property (nonatomic, assign, readonly) BOOL hasSwitchView;   //是否有两个用户
- (void)showAnimationWithDelay:(NSTimeInterval)delay;
- (NSTimeInterval)showCloseAnimation;

@end

@protocol UserDetailInforationViewDelegate <NSObject>

- (void)dismissUserDetailView;

@end