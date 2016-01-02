//
//  SelectBirthView.h
//  UserAccountModule
//
//  Created by Ellise on 15/12/18.
//  Copyright © 2015年 ellise. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DismissBlock)();

@interface SelectBirthView : UIView

@property (nonatomic,strong) UIPickerView * pickerView;

@property (nonatomic,copy) DismissBlock dismissBlock;

@property (nonatomic,strong) NSMutableArray * dataArray;

@end
