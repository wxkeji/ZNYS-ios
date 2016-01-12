//
//  GiftItem.m
//  ZNYS
//
//  Created by Mac on 16/1/12.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "GiftItem.h"

@implementation GiftItem

- (instancetype)initWithDictionary:(NSDictionary *)dict tag:(NSInteger)tag style:(NSInteger)style
{
    NSString *imageName = dict[@"image-name"];
    ItemStateEnum s = [dict[@"item-state"] integerValue];
    NSInteger stars = [dict[@"stars-to-activate"] integerValue];
    self = [super initWithDictionary:dict imageName:imageName state:s tag:tag style:style starsToActivate:stars];
    return self;
}

@end
