//
//  ChooseNumberScrollView.m
//  ZNYS
//
//  Created by Ellise on 16/4/29.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ChooseNumberScrollView.h"

@interface ChooseNumberScrollView ()

@end
@implementation ChooseNumberScrollView

#pragma mark life cycle

- (instancetype)initWithModel:(Award *)model andFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.model = model;
        self.backgroundColor = [UIColor clearColor];
     //   self.pagingEnabled = YES;
        self.scrollEnabled = YES;
//        self.clipsToBounds = NO;
        self.contentSize = CGSizeMake(CustomWidth(106), (model.maxPrice-model.minPrice+3)*CustomHeight(30));
        
        for (NSInteger i = model.minPrice-1, j = 0; i <= model.maxPrice+1 ; i++,j++) {
            UIView * v = [[UIView alloc] initWithFrame:CGRectMake(0, j*CustomHeight(30), CustomWidth(106), CustomHeight(30))];
            v.backgroundColor = [UIColor clearColor];
            
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CustomWidth(106), CustomHeight(30))];
            label.backgroundColor = [UIColor clearColor];
            if (i == (model.minPrice-1) || i == model.maxPrice+1) {
                label.text = @" ";
            }else{
             label.text = [NSString stringWithFormat:@"%ld",(long)i];
            }
            label.textColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:14.f];
            label.tag = i;
            [v addSubview:label];
            
            [self addSubview:v];
        }
    }
    return self;
}

- (NSInteger)getSetPrice{
    CGFloat height = CustomHeight(30);
    NSInteger price = self.model.minPrice+((self.contentOffset.y/height));
    return price;
}
@end
