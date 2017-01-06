//
//  MyUserDetailsView.h
//  ZNYS
//
//  Created by yu243e on 17/1/4.
//  Copyright © 2017年 Woodseen. All rights reserved.
//

//  前缀不能与无 storyboard 的 ViewController 相同

#import "ZNYSBaseView.h"

@interface MyUserDetailsView : ZNYSBaseView

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *coinLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *synchronizationTimeLabel;

+ (instancetype)loadViewFromNib;
@end
