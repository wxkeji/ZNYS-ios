//
//  AppDelegate.m
//  ZNYS
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 Woodseen. All rights reserved.
//

#import "AppDelegate.h"
#import "UserManager.h"
#import "CabinetViewController.h"
#import "AddAccountViewController.h"
#import "TestManager.h"
#import "ChildrenHomeViewController.h"

static AppDelegate* singleton;
@interface AppDelegate ()

@property(nonatomic,strong) UINavigationController* currentNavi;

@end

@implementation AppDelegate

+(instancetype)sharedInstance {
    return singleton;
}

- (UIViewController*)getCurrentTopViewController {
    return self.currentNavi.topViewController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if (!singleton) {
        singleton = self;
    }
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Cabinet" bundle:[NSBundle mainBundle]];
    if ([[UserManager sharedInstance] whetherThereIsUser]) {
//        CabinetViewController * viewController = [storyBoard instantiateViewControllerWithIdentifier:@"CabinetViewController"];
        ChildrenHomeViewController *viewController = [[ChildrenHomeViewController alloc] init];
         UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:viewController];
        nav.navigationBarHidden = YES;
        self.window.rootViewController = nav;
        self.currentNavi = nav;
        [self.window makeKeyAndVisible];
    }else{
        AddAccountViewController * viewController = [[AddAccountViewController alloc] init];
        viewController.style = 1;
         UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:viewController];
        nav.navigationBarHidden = YES;
        self.window.rootViewController = nav;
        [self.window makeKeyAndVisible];
    }
    
    
    return YES;
}

//禁止横屏
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
