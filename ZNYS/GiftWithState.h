//
//  GiftWithStatus.h
//  ZNYS
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 Woodseen. All rights reserved.
//

#import "Gift.h"
#import "GiftState.h"

@interface GiftWithState : Gift
{
    GiftState *state;
    NSArray *STATE; 

}

@property GiftState* state;


//指定初始化方法，这里把state初始化为NotActivated
- (instancetype) initWithGiftName:(NSString *)giftName
                  starsToActivate:(int)starsToActivate;

//用一个gift来初始化,且设置state为NotActivate
- (instancetype) initWithGift:(Gift *)gift;

@end
