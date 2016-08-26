//
//  UIImage+Theme.m
//  ZNYS
//
//  Created by yu243e on 16/8/26.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "UIImage+Theme.h"
#import "ThemeManager.h"

@implementation UIImage (Theme)

+ (UIImage *)themedImageWithNamed:(NSString *)name {
    UIImage *image;
    image = [UIImage imageNamed:name];
    if (!image) {
        NSString *suffix = [ThemeManager sharedManager].currentThemeName;
        NSString *imageRealName = [[NSString alloc]initWithFormat:@"%@_%@", name, suffix];
        image = [UIImage imageNamed:imageRealName];
    }
    return image;
}
@end
