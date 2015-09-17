//
//  GiftState.h
//  ZNYS
//
//  Created by mac on 15/8/18.
//  Copyright (c) 2015年 Woodseen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,ItemStateEnum){
    Obtained,
    ActivatedNotObtained,
    NotActiveted
};

@interface ItemState : NSObject
{
    unsigned int state;
}

- (instancetype) init;

- (void) setState:(ItemStateEnum)s;

- (ItemStateEnum) state;

- (NSString *) toString;

@end
