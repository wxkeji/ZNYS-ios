//
//  Gift.m
//  ZNYS
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 Woodseen. All rights reserved.
//

#import "Gift.h"

@implementation Gift

//指定初始化方法
- (instancetype) initWithGiftName:(NSString *)giftName
                  starsToActivate:(int)starsToActivate
                        imageName:(NSString *)imageName
{
    self.name = giftName;
    self.starsToActivate = starsToActivate;
    self.imageName = imageName;
    return self;
}

- (instancetype) initWithGiftName:(NSString *)giftName
                 startsToActivate:(int)starsToActivate
{
    self = [self initWithGiftName:giftName starsToActivate:starsToActivate imageName:nil];
    return self;
}

@end
