//
//  ViewController.m
//  UserAccountModule
//
//  Created by Ellise on 15/12/17.
//  Copyright © 2015年 ellise. All rights reserved.
//

#import "AddAccountViewController.h"
#import <Masonry.h>
#import "AppDelegate.h"
#import "SelectBirthView.h"
#import "ToolMacroes.h"
#import "CoreDataHelper.h"
#import <SVProgressHUD.h>
#import "CabinetViewController.h"

@interface AddAccountViewController ()

@property (nonatomic,strong) UIButton * addButton;

@property (nonatomic,strong) UIButton * backgroundButton;

@property (nonatomic,copy) NSString * year;

@property (nonatomic,copy) NSString * month;

@property (nonatomic,copy) NSString * day;

@property (nonatomic,strong) SelectBirthView * selectView;

@end

@implementation AddAccountViewController

#pragma mark life cycle

- (void)dealloc{
    _addAccountView = nil;
    _addButton = nil;
    _backgroundButton = nil;
    _year = nil;
    _month = nil;
    _day = nil;
    _selectView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.addAccountView];
    [self.view addSubview:self.addButton];
    [self.view addSubview:self.selectView];

    
    WS(weakSelf, self);
    [self.addAccountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).with.offset(0);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.height.mas_equalTo(CustomHeight(430.5));
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.addAccountView.mas_bottom).with.offset(CustomHeight(51));
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.width.mas_equalTo(CustomWidth(117));
        make.height.mas_equalTo(CustomHeight(117));
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [[TheAppDelegate window] addSubview:self.backgroundButton];
    [[TheAppDelegate window] bringSubviewToFront:_backgroundButton];
    
    WS(weakSelf, self);
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.view.frame = CGRectMake(0, -146, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_addAccountView.nameTextField resignFirstResponder];

    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [_backgroundButton removeFromSuperview];
    
    WS(weakSelf, self);
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.view.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    }];
}


#pragma mark UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return [[self.selectView.dataArray objectAtIndex:0] count];
    }else if (component == 1){
        return [[self.selectView.dataArray objectAtIndex:1] count];
    }else{
        NSInteger selectRow = [pickerView selectedRowInComponent:1];
        NSInteger monthRow = selectRow+1;
        if ((monthRow<7 && !(monthRow%2) && monthRow!=2)||(monthRow>7 && monthRow%2)) {
            return 30;
        }else if(monthRow == 2){
            NSInteger yearRow = [pickerView selectedRowInComponent:0];
            NSString * year = [[self.selectView.dataArray objectAtIndex:0] objectAtIndex:yearRow];
            if (!([year integerValue]%4)) {
                return 29;
            }else{
                return 28;
            }
        }else{
            return 31;
        }
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return [[self.selectView.dataArray objectAtIndex:0] objectAtIndex:row];
    }else if(component == 1){
        return [[self.selectView.dataArray objectAtIndex:1] objectAtIndex:row];
    }else {
        return [[self.selectView.dataArray objectAtIndex:2] objectAtIndex:row];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    if (component == 0) {
        return 80;
    }
    return 40;
}

#pragma mark UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        [pickerView reloadComponent:2];
         self.year = [[self.selectView.dataArray objectAtIndex:0]objectAtIndex:[pickerView selectedRowInComponent:0]];
    }else if (component == 1){
        [pickerView reloadComponent:2];
         self.month = [[self.selectView.dataArray objectAtIndex:1] objectAtIndex:[pickerView selectedRowInComponent:1]];
    }else if (component == 2){
        self.day = [[self.selectView.dataArray objectAtIndex:2] objectAtIndex:[pickerView selectedRowInComponent:2]];
    }
    
    [self.addAccountView.birthButton setTitle:[NSString stringWithFormat:@"%@年%@月%@日",self.year,self.month,self.day] forState:UIControlStateNormal];
}

#pragma mark ChooseThumbDelegate

- (void)changeChoice:(UIButton *)choose{
    if (choose.tag) {
        _addAccountView.girlsButton.selected = YES;
        _addAccountView.boysButton.selected = NO;
        [_addAccountView.girlsButton setBackgroundColor:[UIColor redColor]];
        [_addAccountView.boysButton setBackgroundColor:[UIColor yellowColor]];
    }else{
        _addAccountView.girlsButton.selected = NO;
        _addAccountView.boysButton.selected = YES;
        [_addAccountView.girlsButton setBackgroundColor:[UIColor yellowColor]];
        [_addAccountView.boysButton setBackgroundColor:[UIColor redColor]];
    }
}

- (void)showPickerView{
    WS(weakSelf, self);
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.selectView.frame = CGRectMake(0, kSCREEN_HEIGHT-230, kSCREEN_WIDTH, 230);
    }];
}

- (void)dismissButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark event action

- (void)addButtonAction{
    
    NSString * gender = [[NSString alloc]init];
    if (self.addAccountView.boysButton.selected) {
        gender = @"0";
    }else{
        gender = @"1";
    }
    
    NSString * name = [[NSString alloc] init];
    if (self.addAccountView.nameTextField.text.length) {
        name = self.addAccountView.nameTextField.text;
    }else{
        name = @"宝宝";
    }
    
    
    if (self.style == 0) {
        NSString * uuid = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentUserUID"];
        if ([[CoreDataHelper sharedInstance] modifyUserInfoWithUUID:uuid birthday:self.addAccountView.birthButton.titleLabel.text gender:gender nickname:name]) {
            [SVProgressHUD showInfoWithStatus:@"修改用户成功"];
            
        }else{
            [SVProgressHUD showInfoWithStatus:@"修改失败，请重试"];
        }
    }else if(self.style == 1){
        NSString * uid = [[CoreDataHelper sharedInstance] createUserWithBirthday:self.addAccountView.birthButton.titleLabel.text gender:gender nickName:name];
        if (uid) {
             [[NSUserDefaults standardUserDefaults]setObject:uid forKey:@"currentUserUID"];
            
            [SVProgressHUD showInfoWithStatus:@"添加用户成功"];
            UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Cabinet" bundle:[NSBundle mainBundle]];
            CabinetViewController * viewController = [storyBoard instantiateViewControllerWithIdentifier:@"CabinetViewController"];
            [self.navigationController pushViewController:viewController animated:YES];
        }else{
           [SVProgressHUD showInfoWithStatus:@"添加用户失败，请重试"];
        }
    }else{
        NSString * uid = [[CoreDataHelper sharedInstance] createUserWithBirthday:self.addAccountView.birthButton.titleLabel.text gender:gender nickName:name];
        if (uid) {
           
            [SVProgressHUD showInfoWithStatus:@"添加用户成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
         [SVProgressHUD showInfoWithStatus:@"添加用户失败，请重试"];
        }
    }
}

- (void)dismiss{
    [_addAccountView.nameTextField resignFirstResponder];
    
    WS(weakSelf, self);
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.selectView.frame = CGRectMake(0, kSCREEN_HEIGHT+200, kSCREEN_WIDTH, 250);
    }];}

#pragma mark getters and setters

- (AddAccountView *)addAccountView{
    if (!_addAccountView) {
        _addAccountView = [[AddAccountView alloc] init];
        _addAccountView.nameTextField.delegate = self;
        _addAccountView.delegate = self;
        
        if (self.style == 0) {
            _addAccountView.titleLabel.text = @"修改用户";
            _addAccountView.nameTextField.text = [User currentUserName];
            [_addAccountView.birthButton setTitle:[User currentUserBirthday] forState:UIControlStateNormal];
            if ([[User currentUserGender] isEqualToString:@"boy"]) {
                _addAccountView.boysButton.selected = YES;
                _addAccountView.girlsButton.selected = NO;
            }else{
                _addAccountView.boysButton.selected = NO;
                _addAccountView.girlsButton.selected = YES;
            }
        }else{
            _addAccountView.titleLabel.text = @"添加新用户";
            _addAccountView.nameTextField.placeholder = @"宝宝";
            [_addAccountView.nameTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
            [_addAccountView.birthButton setTitle:@"1996年1月1日" forState:UIControlStateNormal];
        }
        
        if (self.style == 1) {
            _addAccountView.dismissButton.hidden = YES;
        }
    }
    return _addAccountView;
}

- (UIButton *)addButton{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.backgroundColor = [UIColor yellowColor];
        [_addButton addTarget:self action:@selector(addButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

- (UIButton *)backgroundButton{
    if (!_backgroundButton) {
        _backgroundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backgroundButton.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
        [_backgroundButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backgroundButton;
}

- (NSString *)year{
    if (!_year) {
        _year = [NSString stringWithFormat:@"1996"];
    }
    return _year;
}

- (NSString *)month{
    if (!_month) {
        _month = [NSString stringWithFormat:@"1"];
    }
    return _month;
}

- (NSString *)day{
    if (!_day) {
        _day = [NSString stringWithFormat:@"1"];
    }
    return _day;
}

- (SelectBirthView *)selectView{
    WS(weakSelf, self);
    if (!_selectView) {
        _selectView = [[SelectBirthView alloc] initWithFrame:CGRectMake(0, kSCREEN_HEIGHT+200, kSCREEN_WIDTH, 230)];
        _selectView.pickerView.delegate = self;
        _selectView.pickerView.dataSource = self;
        _selectView.dismissBlock = ^{
            [weakSelf dismiss];
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.view.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
            }];
        };
    }
    return _selectView;
}

@end
