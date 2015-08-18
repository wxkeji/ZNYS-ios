//
//  GiftWithStatus.m
//  ZNYS
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 Woodseen. All rights reserved.
//

#import "GiftWithState.h"
#import "GiftState.h"

@implementation GiftWithState

@synthesize state = _state;

//指定初始化方法，这里把state初始化为NotActivated
- (instancetype) initWithGiftName:(NSString *)giftName
                  starsToActivate:(int)starsToActivate
{
    if(self = [super initWithGiftName:giftName starsToActivate:starsToActivate])
    {
        self.state = [[GiftState alloc] init];
        self.state.state = NotActiveted;
    }
    return self;
}

//用一个gift来初始化,且设置state为NotActivate
- (instancetype) initWithGift:(Gift *)gift
{
    self = [self initWithGiftName:gift.name starsToActivate:gift.starsToActivate];
    return self;
}

@end//  GiftWithState
