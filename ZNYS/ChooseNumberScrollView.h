//
//  ChooseNumberScrollView.h
//  ZNYS
//
//  Created by Ellise on 16/4/29.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolMacroes.h"
#import <Masonry.h>
#import "Award+CoreDataClass.h"

@interface ChooseNumberScrollView : UIScrollView

@property (nonatomic,strong) Award * model;

- (instancetype)initWithModel:(Award *)model andFrame:(CGRect)frame;

- (NSInteger)getSetPrice;

@end
