//
//  ViewController.h
//  UserAccountModule
//
//  Created by Ellise on 15/12/17.
//  Copyright © 2015年 ellise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddAccountView.h"

@interface AddAccountViewController : UIViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,ChooseThumbDelegate>

@property (nonatomic,strong) AddAccountView * addAccountView;

/**
 *  viewcontroller的类型，0为修改用户信息界面，1为首次添加新用户页面，2为用户管理界面内添加新用户界面
 */
@property (nonatomic,assign) NSInteger style;

@end

