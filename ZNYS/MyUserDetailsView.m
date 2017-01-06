//
//  MyUserDetailsView.m
//  ZNYS
//
//  Created by yu243e on 17/1/4.
//  Copyright © 2017年 Woodseen. All rights reserved.
//

//  前缀不能与无 storyboard 的 ViewController 相同

#import "MyUserDetailsView.h"

@implementation MyUserDetailsView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.userImageView.layer.cornerRadius = self.userImageView.bounds.size.width / 2;
    self.userImageView.clipsToBounds = YES;
}

+ (instancetype)loadViewFromNib {
    MyUserDetailsView *view = [[NSBundle mainBundle] loadNibNamed:@"MyUserDetailsView" owner:nil options:nil].firstObject;
    return view;
}
@end
