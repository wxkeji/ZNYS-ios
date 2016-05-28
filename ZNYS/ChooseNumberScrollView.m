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

- (instancetype)initWithModel:(rewardListModel *)model andFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.pagingEnabled = YES;
        self.scrollEnabled = YES;
        self.contentSize = CGSizeMake(CustomWidth(106), CustomHeight(30)*(model.range+2));
        
        for (NSInteger i = model.coins-1, j = 0; j <= model.range+2 ; i++,j++) {
            UIView * v = [[UIView alloc] initWithFrame:CGRectMake(0, j*CustomHeight(30), CustomWidth(106), CustomHeight(30))];
            v.backgroundColor = [UIColor clearColor];
            
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CustomWidth(106), CustomHeight(30))];
            label.backgroundColor = [UIColor clearColor];
            if (i == (model.coins-1) || i == model.range+2+model.coins) {
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

//- (void)layoutSubviews{
//    WS(weakSelf, self);
////    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.top.equalTo(weakSelf.mas_top).with.offset(CustomHeight(78));
////        make.left.equalTo(weakSelf.mas_left).with.offset(0);
////        make.right.equalTo(weakSelf.mas_right).with.offset(0);
////        make.height.mas_equalTo(CustomHeight(15));
////    }];
////    
////    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-CustomHeight(78));
////        make.left.equalTo(weakSelf.mas_left).with.offset(0);
////        make.right.equalTo(weakSelf.mas_right).with.offset(0);
////        make.height.mas_equalTo(CustomHeight(2));
////    }];
//
//}
//
@end
