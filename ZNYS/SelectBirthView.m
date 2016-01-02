//
//  SelectBirthView.m
//  UserAccountModule
//
//  Created by Ellise on 15/12/18.
//  Copyright © 2015年 ellise. All rights reserved.
//

#import "SelectBirthView.h"
#import "ToolMacroes.h"

@interface SelectBirthView()

@property (nonatomic,strong) UIButton * certifyButton;

@end

@implementation SelectBirthView

#pragma mark life cycle

- (void)dealloc{
    _pickerView = nil;
    _certifyButton = nil;
    _dataArray = nil;
    _dismissBlock = nil;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.pickerView];
        [self addSubview:self.certifyButton];
        
        NSMutableArray * years = [[NSMutableArray alloc]init];
        for (NSInteger i = 2006; i <= 2016; i++) {
            [years addObject:[NSString stringWithFormat:@"%ld",(long)i]];
        }
        
        NSMutableArray * months = [[NSMutableArray alloc]init];
        for (NSInteger i = 1; i <= 12; i++) {
            [months addObject:[NSString stringWithFormat:@"%ld",(long)i]];
        }
        
        NSMutableArray * days = [[NSMutableArray alloc]init];
        for (NSInteger i = 1; i <= 31; i++) {
            [days addObject:[NSString stringWithFormat:@"%ld",(long)i]];
        }
        
        _dataArray = [[NSMutableArray alloc] init];
        [_dataArray addObject:years];
        [_dataArray addObject:months];
        [_dataArray addObject:days];
    }
    return self;
}

#pragma mark private method

- (void)dismiss{
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

#pragma getters and setters

- (UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 230)];
        _pickerView.showsSelectionIndicator=YES;
        _pickerView.backgroundColor = [UIColor grayColor];
        _pickerView.layer.opacity = 0.8f;
    }
    return _pickerView;
}

- (UIButton *)certifyButton{
    if (!_certifyButton) {
        _certifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _certifyButton.frame = CGRectMake(kSCREEN_WIDTH-70, 10, 60, 25);
        _certifyButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [_certifyButton setTitle:@"确定" forState:UIControlStateNormal];
        [_certifyButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _certifyButton;
}



@end
