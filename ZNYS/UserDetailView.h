//
//  UserDetailView.h
//  ZNYS
//
//  Created by Ellise on 16/1/5.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ZNYSBaseView.h"

typedef void(^ModifyButtonBlock)();

@interface UserDetailView : ZNYSBaseView

@property (nonatomic,strong) UIImageView * thumbImage;

@property (nonatomic,strong) UILabel * nameLabel;

@property (nonatomic,strong) UILabel * birthdayLabel;

@property (nonatomic,strong) UILabel * coinLabel;

@property (nonatomic,strong) UILabel * brushLabel;

@property (nonatomic,copy) ModifyButtonBlock modifyButtonBlock;

@end
