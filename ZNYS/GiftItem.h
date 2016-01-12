//
//  GiftItem.h
//  ZNYS
//
//  Created by Mac on 16/1/12.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "CabinetItem.h"

@interface GiftItem : CabinetItem

- (instancetype)initWithDictionary:(NSDictionary *)dict tag:(NSInteger)tag style:(NSInteger)style;

@end
