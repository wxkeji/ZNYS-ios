//
//  UserDetailsView.m
//  ZNYS
//
//  Created by yu243e on 17/1/4.
//  Copyright © 2017年 Woodseen. All rights reserved.
//

#import "UserDetailsView.h"

@implementation UserDetailsView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.userImageView.layer.cornerRadius = self.userImageView.bounds.size.width / 2;
    self.userImageView.clipsToBounds = YES;
}

+ (instancetype)loadViewFromNib {
    UserDetailsView *view = [[NSBundle mainBundle] loadNibNamed:@"UserDetailsView" owner:nil options:nil].firstObject;
    return view;
}
@end
