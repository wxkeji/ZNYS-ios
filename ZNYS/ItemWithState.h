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

@property NSInteger style;
@property ItemState *state;
@property (nonatomic,assign) NSInteger tag;


//指定初始化方法，这里把state初始化为NotActivated
- (instancetype) initWithItemName:(NSString *)itemName
                        imageName:(NSString *)imageName
                            state:(ItemStateEnum)s
                              tag:(NSInteger)tag
                            style:(NSInteger)style;

//用一个gift来初始化,且设置state为NotActivate
- (instancetype) initWithGift:(Item *)item;

@end
