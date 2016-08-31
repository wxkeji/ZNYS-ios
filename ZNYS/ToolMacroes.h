//
//  ToolMacroes.h
//  ZNYS
//
//  Created by Ellise on 16/1/2.
//  Copyright © 2016年 Woodseen. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "LayoutMacro.h"

#ifndef ToolMacroes_h
#define ToolMacroes_h

#define kSCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT	[UIScreen mainScreen].bounds.size.height

#define WS(weakobj,obj)  __weak __typeof(&*obj)weakobj = obj

#define TheAppDelegate (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define CurrentController [TheAppDelegate currentController]
#define CurrentNavController [CurrentController navigationController]

#define RGBCOLOR(r,g,b)          [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define CustomWidth(width)  ((width)/375.0f)*kSCREEN_WIDTH
#define CustomHeight(height)  ((height)/667.0f)*kSCREEN_HEIGHT

#define ZNYSGetSizeByWidth(w320, w375, w414) [ToolMacroes getUniversalSizeByWidth320:(w320) width375:(w375) width414:(w414)]
#define ZNYSGetSizeBy2x3x(x2, x3) [ToolMacroes getUniversalSizeBy2x:(x2) and3x:(x3)]
//#define ZNYSGetSizeBy1x(x1) [ToolMacroes getUniversalSizeBy1x:(x1)]

#endif /* ToolMacroes_h */

@interface ToolMacroes:NSObject
//根据不同机型5 6 6p的屏幕宽度，返回CGFloat原值
+ (CGFloat)getUniversalSizeByWidth320:(CGFloat)w320 width375:(CGFloat)w375 width414:(CGFloat)w414;
//根据2x和3x 返回CGFloat大小原值
+ (CGFloat)getUniversalSizeBy2x:(CGFloat)x2 and3x:(CGFloat)x3;
@end