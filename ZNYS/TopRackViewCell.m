//
//  TopRackViewCell.m
//  ZNYS
//
//  Created by yu243e on 2017/4/23.
//  Copyright © 2017年 Woodseen. All rights reserved.
//

#import "TopRackViewCell.h"

@implementation TopRackViewCell
#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.medalImageView];
        self.medalImageView.frame = self.bounds;
    }
    return self;
}

#pragma mark - setters and getters
- (UIImageView *)medalImageView {
    if (!_medalImageView) {
        _medalImageView = [[UIImageView alloc] init];
    }
    return _medalImageView;
}
@end
