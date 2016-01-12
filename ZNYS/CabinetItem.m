//
//  GiftWithStatus.m
//  ZNYS
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 Woodseen. All rights reserved.
//

#import "CabinetItem.h"
#import "ItemState.h"

@interface CabinetItem()



@end

@implementation CabinetItem

//指定初始化方法，这里把state初始化为NotActivated
- (instancetype) initWithDictionary:(NSDictionary *)dict
                        imageName:(NSString *)imageName
                            state:(ItemStateEnum)s
                              tag:(NSInteger)tag
                            style:(NSInteger)style
                    starsToActivate:(NSInteger)stars
{
    NSString *giftName = dict[@"title"];
    NSString *description;
    if(s == Obtained) {
        description = dict[@"description"];
    }
    else {
        description = dict[@"shadow-description"];
    }
    if(self = [super init])
    {
        self.itemName = giftName;
        _state = [[ItemState alloc] init];
        self.state.state = s;
        if(s == Obtained) {
            self.imageName = [imageName stringByAppendingString:@"_已兑换"];
        }
        else
        {
            self.imageName = [imageName stringByAppendingString:@"_未兑换"];
        }
        _style = style;
        _tag = tag;
        _descriptionText = description;
        _starsToActivate = stars;
    }
    return self;
}

@end
