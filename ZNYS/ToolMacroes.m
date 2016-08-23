//
//  ToolMacroes.m
//  ZNYS
//
//  Created by yu243e on 16/8/23.
//  Copyright © 2016年 Woodseen. All rights reserved.
//
#import "ToolMacroes.h"
@implementation ToolMacroes
+ (CGFloat)getUniversalSizeByWidth320:(CGFloat)w320
                             width375:(CGFloat)w375
                             width414:(CGFloat)w414 {
    switch ((NSInteger)(kSCREEN_WIDTH+0.01f)) {
        case 320:
            return w320;
            break;
        case 375:
            return w375;
            break;
        case 414:
            return w414;
            break;
        default:
            //ipad？
            break;
    }
    return 0;
}

+ (CGFloat)getUniversalSizeBy2x:(CGFloat)x2 and3x:(CGFloat)x3 {
    return [self getUniversalSizeByWidth320:x2 width375:x2 width414:x3];
}
@end
