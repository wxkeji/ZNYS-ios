//
//  GiftState.h
//  ZNYS
//
//  Created by mac on 15/8/18.
//  Copyright (c) 2015年 Woodseen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,GiftStateEnum){
    Obtained,
    ActivatedNotObtained,
    NotActiveted
};

@interface GiftState : NSObject
{
    unsigned int state;
}

- (instancetype) init;

- (void) setState:(GiftStateEnum)s;

- (GiftStateEnum) state;

- (NSString *) toString;

@end
