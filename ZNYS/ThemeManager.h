//
//  ThemeManager.h
//  ZNYS
//
//  Created by yu243e on 16/8/25.
//  Copyright © 2016年 Woodseen. All rights reserved.
//
#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, ZNYSThemeStyle) {
    ZNYSThemeStyleUnspecified,
    ZNYSThemeStyleBlue,
    ZNYSThemeStylePink
};

@interface ThemeManager : NSObject
@property (nonatomic, readonly, assign) ZNYSThemeStyle themeStyle;

+ (ThemeManager *)sharedManager;
- (BOOL)configureTheme:(ZNYSThemeStyle)themeStyle;
- (NSString *)currentThemeName;
@end
