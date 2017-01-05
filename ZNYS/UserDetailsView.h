//
//  UserDetailsView.h
//  ZNYS
//
//  Created by yu243e on 17/1/4.
//  Copyright © 2017年 Woodseen. All rights reserved.
//

#import "ZNYSBaseView.h"

@interface UserDetailsView : ZNYSBaseView

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *synchronizationTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *coinLabel;

+ (instancetype)loadViewFromNib;
@end
