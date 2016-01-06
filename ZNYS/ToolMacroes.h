//
//  ToolMacroes.h
//  ZNYS
//
//  Created by Ellise on 16/1/2.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

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

#define CustomWidth(width)  (width/375.0f)*kSCREEN_WIDTH
#define CustomHeight(height)  (height/667.0f)*kSCREEN_HEIGHT

#endif /* ToolMacroes_h */
