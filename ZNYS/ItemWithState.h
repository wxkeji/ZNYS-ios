//
//  GiftWithStatus.h
//  ZNYS
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 Woodseen. All rights reserved.
//

#import "Item.h"
#import "ItemState.h"

@interface ItemWithState : Item

@property (readonly) NSInteger style;
@property ItemState *state;
@property (readonly) NSInteger tag;
@property (strong, nonatomic, readonly) NSString *descriptionText;
@property (readonly) NSInteger starsToActivate;

//指定初始化方法，这里把state初始化为NotActivated
- (instancetype) initWithDictionary:(NSDictionary *)dict
                        imageName:(NSString *)imageName
                            state:(ItemStateEnum)s
                              tag:(NSInteger)tag
                            style:(NSInteger)style
                    starsToActivate:(NSInteger)stars;

//用一个gift来初始化,且设置state为NotActivate
- (instancetype) initWithGift:(Item *)item;

@end
