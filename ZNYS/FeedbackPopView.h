//
//  FeedbackPopView.h
//  ZNYS
//
//  Created by jerry on 15/10/7.
//  Copyright © 2015年 Woodseen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedbackPopView : UIView

@property (nonatomic, strong) UIView *logoView;
@property (nonatomic, strong) UILabel *detailLabel;

+ (void)showPopViewInView:(UIView*)view InController:(UIViewController*)vc  WithFormerVc:(UIViewController*)formerVc;
- (instancetype)init;
+ (instancetype)shared;
+ (void)Hide;
-(void)setPopView;

@end
