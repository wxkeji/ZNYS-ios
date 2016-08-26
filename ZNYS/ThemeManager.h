//
//  ThemeManager.h
//  ZNYS
//
//  Created by yu243e on 16/8/25.
//  Copyright © 2016年 Woodseen. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface ThemeManager : NSObject
+ (ThemeManager *)sharedManager;
- (BOOL)configureThemeWithNamed:(NSString *)name;
- (NSString *)currentThemeName;
@end