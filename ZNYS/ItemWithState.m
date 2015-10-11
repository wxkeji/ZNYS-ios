//
//  GiftWithStatus.m
//  ZNYS
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 Woodseen. All rights reserved.
//

#import "ItemWithState.h"
#import "ItemState.h"

@implementation ItemWithState

@synthesize state = _state;

//指定初始化方法，这里把state初始化为NotActivated
- (instancetype) initWithItemName:(NSString *)giftName
                        imageName:(NSString *)imageName
{
    if(self = [super initWithItemName:giftName imageName:imageName])
    {
        self.state = [[ItemState alloc] init];
        self.state.state = NotActiveted;
    }
    return self;
}

- (instancetype) initWithGiftName:(NSString *)giftName
{
    if(self = [super initWithItemName:giftName imageName:nil])
    {
        self.state = [[ItemState alloc] init];
        self.state.state = NotActiveted;
    }
    return self;

}

//用一个gift来初始化,且设置state为NotActivate
- (instancetype) initWithItem:(Item *)item
{
    self = [self initWithItemName:item.itemName imageName:item.imageName];
    return self;
}

@end//  GiftWithState
