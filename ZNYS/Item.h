//
//  Gift.h
//  ZNYS
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 Woodseen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (strong) NSString *itemName;       //礼物名称
@property NSString *imageName;

//指定初始化方法
- (instancetype) initWithItemName:(NSString *)itemName
                        imageName:(NSString *)imageName;

@end
