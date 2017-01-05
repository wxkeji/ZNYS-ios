//
//  UserCollectionViewCell.m
//  ZNYS
//
//  Created by yu243e on 16/12/28.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "UserCollectionViewCell.h"
#import "ToolMacroes.h"
@implementation UserCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userImageView.layer.cornerRadius = self.userImageView.bounds.size.width / 2;
    self.userImageView.clipsToBounds = YES;
    UIView *dimmingView = [[UIView alloc] init];
    dimmingView.backgroundColor = RGBACOLOR(0, 0, 0, 0.25);
    self.selectedBackgroundView = dimmingView;
}
@end
