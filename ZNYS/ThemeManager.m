//
//  ThemeManager.m
//  ZNYS
//
//  Created by yu243e on 16/8/25.
//  Copyright © 2016年 Woodseen. All rights reserved.
//
#import "ThemeManager.h"

static ThemeManager *_themeManager = nil;

@interface ThemeManager()
@property (nonatomic, assign) ZNYSThemeStyle themeStyle;
@end

@implementation ThemeManager
+ (ThemeManager *)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _themeManager = [[ThemeManager alloc]init];
    });
    
    return _themeManager;
}

- (BOOL)configureTheme:(ZNYSThemeStyle)themeStyle {
    if (self.themeStyle == themeStyle) {
        return NO;
    } else {
        if (self.themeStyle == ZNYSThemeStyleUnspecified && themeStyle == ZNYSThemeStyleBlue) {
            self.themeStyle = themeStyle;
            return NO;
        }
        self.themeStyle = themeStyle;
        return YES;
    }
}

- (NSString *)currentThemeName {
    switch (self.themeStyle) {
        case ZNYSThemeStyleUnspecified:
            //no_break
        case ZNYSThemeStyleBlue:
            return @"boy";
            break;
        case ZNYSThemeStylePink:
            return @"girl";
            break;
    }
}
@end
