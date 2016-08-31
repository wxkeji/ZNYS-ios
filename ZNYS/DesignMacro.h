//
//  DesignMacro.h
//  ZNYS
//
//  Created by yu243e on 16/8/31.
//  Copyright © 2016年 Woodseen. All rights reserved.
//
//设计的常量

#ifndef DesignMacro_h
#define DesignMacro_h

//布局相关
//顶部按钮距边缘的最小值 内容可以离边缘更近
#define MIN_EDGE_X 15
//iOS规范，可触摸最小区域
#define MIN_BUTTON_H_W 44

#define STATUS_BAR_HEIGHT 20
#define NAVIGATION_BUTTON_Y 8+STATUS_BAR_HEIGHT
#define NAVGATION_USER_INTERVAL 9.0
#define USER_INFORMATIN_Y NAVGATION_USER_INTERVAL+NAVIGATION_BUTTON_Y+MIN_BUTTON_H_W

//颜色相关
#define BUTTON_TOUCH_ALPHA 0.3
#define MODAL_ALPHA 0.5

#endif /* DesignMacro_h */
