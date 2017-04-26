//
//  DownRackViewCell.m
//  ZNYS
//
//  Created by yu243e on 2017/4/26.
//  Copyright © 2017年 Woodseen. All rights reserved.
//

#import "DownRackViewCell.h"

@implementation DownRackViewCell
#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.awardImageView];
        self.awardImageView.frame = self.bounds;
    }
    return self;
}

#pragma mark - setters and getters
- (UIImageView *)awardImageView {
    if (!_awardImageView) {
        _awardImageView = [[UIImageView alloc] init];
        _awardImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _awardImageView;
}
@end
