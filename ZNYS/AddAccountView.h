//
//  AddAccountView.h
//  UserAccountModule
//
//  Created by Ellise on 15/12/17.
//  Copyright © 2015年 ellise. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseThumbDelegate <NSObject>

- (void)changeChoice:(UIButton *)choose;

- (void)showPickerView;

- (void)dismissButtonAction;

@end

@interface AddAccountView : UIView

@property (nonatomic,strong) UIButton * boysButton;

@property (nonatomic,strong) UIButton * girlsButton;

@property (nonatomic,strong) UITextField * nameTextField;

@property (nonatomic,strong) UIButton * birthButton;

@property (nonatomic,strong) id<ChooseThumbDelegate> delegate;

@property (nonatomic,strong) UILabel * titleLabel;

@property (nonatomic,strong) UIButton * dismissButton;

@end
