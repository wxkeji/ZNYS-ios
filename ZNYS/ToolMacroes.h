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

#endif /* ToolMacroes_h */
