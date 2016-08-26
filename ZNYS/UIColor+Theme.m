//
//  UIColor+Theme.m
//  ZNYS
//
//  Created by yu243e on 16/8/26.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "UIColor+Theme.h"
#import "UIImage+Theme.h"
@implementation UIColor (Theme)

+ (UIColor *)colorWithThemedImageNamed:(NSString *)name {
     return [UIColor colorWithPatternImage:[UIImage themedImageWithNamed:name]];
}
@end
