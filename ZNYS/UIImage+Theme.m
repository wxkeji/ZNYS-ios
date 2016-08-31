//
//  UIImage+Theme.m
//  ZNYS
//
//  Created by yu243e on 16/8/26.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "UIImage+Theme.h"
#import "ThemeManager.h"

//如果不存在对等的 girl 主题，全部使用 boy 主题，实际最终应该去除！！ temp 测试用!
#ifdef DEBUG
static const NSString *defaultDebugTheme = @"boy";
#endif

@implementation UIImage (Theme)

+ (UIImage *)themedImageWithNamed:(NSString *)name {
    UIImage *image;
    image = [UIImage imageNamed:name];
    if (!image) {
        NSString *suffix = [ThemeManager sharedManager].currentThemeName;
        NSString *imageRealName = [[NSString alloc]initWithFormat:@"%@_%@", name, suffix];
        image = [UIImage imageNamed:imageRealName];
#       ifdef DEBUG
        if (!image) {
            NSLog(@"no image:%@",imageRealName);
            imageRealName = [[NSString alloc]initWithFormat:@"%@_%@", name, defaultDebugTheme];
            image = [UIImage imageNamed:imageRealName];
        }
#       endif
    }
    if (!image) {
        NSLog(@"can't fetch image:%@", name);
    }
    return image;
}
@end
