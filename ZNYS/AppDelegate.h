//
//  AppDelegate.h
//  ZNYS
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 Woodseen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZNYSBaseController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (weak, nonatomic) ZNYSBaseController * currentController;

@end

