//
//  UIColor+Helper.m
//  ZNYS
//
//  Created by yu243e on 16/8/25.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "UIColor+Helper.h"
#import "UIImage+Helper.h"

@implementation UIColor (Helper)

+ (UIColor *)colorWithImageNamed:(NSString *)name {
    return [UIColor colorWithPatternImage:[UIImage imageNamed:@"name"]];
}
@end
