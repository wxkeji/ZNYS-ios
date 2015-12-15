//
//  Gift.m
//  ZNYS
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 Woodseen. All rights reserved.
//

#import "Item.h"

@implementation Item

//指定初始化方法
- (instancetype) initWithItemName:(NSString *)itemName
                        imageName:(NSString *)imageName
{
    self.itemName = itemName;
    self.imageName = imageName;
    return self;
}

- (instancetype) initWithGiftName:(NSString *)itemName
{
    self = [self initWithItemName:itemName imageName:nil];
    return self;
}

@end
