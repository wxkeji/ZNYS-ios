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
#import "Award+CoreDataClass.h"
#import "Award+CoreDataProperties.h"
#import <SVProgressHUD.h>
#import "ChildrenHomeViewController.h"
#import "UserManager.h"

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
    
    [self configureTheme];
    
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
        [_addAccountView.girlsButton setBackgroundColor:[UIColor clearColor]];
        [_addAccountView.boysButton setBackgroundColor:RGBACOLOR(0, 0, 0, 0.3)];
    }else{
        _addAccountView.girlsButton.selected = NO;
        _addAccountView.boysButton.selected = YES;
        [_addAccountView.girlsButton setBackgroundColor:RGBACOLOR(0, 0, 0, 0.3)];
        [_addAccountView.boysButton setBackgroundColor:[UIColor clearColor]];
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

#pragma mark private method
- (void)configureTheme {
    self.addButton.tintColor = [UIColor colorWithThemedImageNamed:@"color/primary_dark"];
    [self.addAccountView configureTheme];
}

- (void)addRewardData{
    
    Award* testAward1 = [[CoreDataHelper sharedInstance] createAward];
    testAward1.pitcureURL = @"testImage1";
    testAward1.minPrice = 1;
    testAward1.price = 5;
    testAward1.maxPrice = 10;
    testAward1.voice = @"录音路径.mp3";
    testAward1.status = @"notAdded";
    testAward1.type = @"consume";
    testAward1.userID = [[UserManager sharedInstance] currentUser].uuid;
    testAward1.uuid = [[NSUUID UUID] UUIDString];
    
    
    Award* testAward2 = [[CoreDataHelper sharedInstance] createAward];
    testAward2.pitcureURL = @"testImage2";
    testAward2.minPrice = 5;
    testAward2.price = 8;
    testAward2.maxPrice = 10;
    testAward2.voice = @"录音路径.mp3";
    testAward2.status = @"notAdded";
    testAward2.type = @"possess";
    testAward2.userID = [[UserManager sharedInstance] currentUser].uuid;
    testAward2.uuid = [[NSUUID UUID] UUIDString];
    
    
    
    Award* testAward3 = [[CoreDataHelper sharedInstance] createAward];
    testAward3.pitcureURL = @"testImage3";
    testAward3.minPrice = 1;
    testAward3.price = 5;
    testAward3.maxPrice = 10;
    testAward3.voice = @"录音路径.mp3";
    testAward3.status = @"notAdded";
    testAward3.type = @"activity";
    testAward3.userID = [[UserManager sharedInstance] currentUser].uuid;
    testAward3.uuid = [[NSUUID UUID] UUIDString];
    
    
    
    Award* testAward4 = [[CoreDataHelper sharedInstance] createAward];
    testAward4.pitcureURL = @"testImage1";
    testAward4.minPrice = 10;
    testAward4.price = 20;
    testAward4.maxPrice = 30;
    testAward4.voice = @"录音路径.mp3";
    testAward4.status = @"added";
    testAward4.type = @"consume";
    testAward4.userID = [[UserManager sharedInstance] currentUser].uuid;
    testAward4.uuid = [[NSUUID UUID] UUIDString];
    
    
    Award* testAward5 =[[CoreDataHelper sharedInstance] createAward];
    testAward5.pitcureURL = @"testImage1";
    testAward5.minPrice = 1;
    testAward5.price = 5;
    testAward5.maxPrice = 10;
    testAward5.voice = @"录音路径.mp3";
    testAward5.status = @"added";
    testAward5.type = @"possess";
    testAward5.userID = [[UserManager sharedInstance] currentUser].uuid;
    testAward5.uuid = [[NSUUID UUID] UUIDString];
    
    
    
    Award* testAward6 = [[CoreDataHelper sharedInstance] createAward];
    testAward6.pitcureURL = @"testImage2";
    testAward6.minPrice = 12;
    testAward6.price = 13;
    testAward6.maxPrice = 15;
    testAward6.voice = @"录音路径.mp3";
    testAward6.status = @"added";
    testAward6.type = @"activity";
    testAward6.userID = [[UserManager sharedInstance] currentUser].uuid;
    testAward6.uuid = [[NSUUID UUID] UUIDString];
    
    
    
    Award* testAward7 = [[CoreDataHelper sharedInstance] createAward];
    testAward7.pitcureURL = @"testImage2";
    testAward7.minPrice = 6;
    testAward7.price = 9;
    testAward7.maxPrice = 10;
    testAward7.voice = @"录音路径.mp3";
    testAward7.status = @"added";
    testAward7.type = @"consume";
    testAward7.userID = [[UserManager sharedInstance] currentUser].uuid;
    testAward7.uuid = [[NSUUID UUID] UUIDString];
    
    
    
    Award* testAward8 =[[CoreDataHelper sharedInstance] createAward];
    testAward8.pitcureURL = @"testImage3";
    testAward8.minPrice = 1;
    testAward8.price = 5;
    testAward8.maxPrice = 10;
    testAward8.voice = @"录音路径.mp3";
    testAward8.status = @"notAdded";
    testAward8.type = @"consume";
    testAward8.userID = [[UserManager sharedInstance] currentUser].uuid;
    testAward8.uuid = [[NSUUID UUID] UUIDString];
    
    
    
    Award* testAward9 =[[CoreDataHelper sharedInstance] createAward];
    testAward9.pitcureURL = @"testImage2";
    testAward9.minPrice = 1;
    testAward9.price = 5;
    testAward9.maxPrice = 10;
    testAward9.voice = @"录音路径.mp3";
    testAward9.status = @"notAdded";
    testAward9.type = @"consume";
    testAward9.userID = [[UserManager sharedInstance] currentUser].uuid;
    testAward9.uuid = [[NSUUID UUID] UUIDString];
    
    
    
    Award* testAward10 = [[CoreDataHelper sharedInstance] createAward];
    testAward10.pitcureURL = @"testImage4";
    testAward10.minPrice = 1;
    testAward10.price = 5;
    testAward10.maxPrice = 10;
    testAward10.voice = @"录音路径.mp3";
    testAward10.status = @"notAdded";
    testAward10.type = @"consume";
    testAward10.userID = [[UserManager sharedInstance] currentUser].uuid;
    testAward10.uuid = [[NSUUID UUID] UUIDString];
    
    
    
    
    Award* testAward11 = [[CoreDataHelper sharedInstance] createAward];
    testAward11.pitcureURL = @"testImage1";
    testAward11.minPrice = 1;
    testAward11.price = 5;
    testAward11.maxPrice = 10;
    testAward11.voice = @"录音路径.mp3";
    testAward11.status = @"notAdded";
    testAward11.type = @"consume";
    testAward11.userID = [[UserManager sharedInstance] currentUser].uuid;
    testAward11.uuid = [[NSUUID UUID] UUIDString];
    
    
    [[CoreDataHelper sharedInstance] save];
    

}

#pragma mark event action

- (void)addButtonAction{
    
    BOOL gender;
    //都未选中的初始状态为 BOY
    if (self.addAccountView.girlsButton.selected) {
        gender = YES;
    }else{
        gender = NO;
    }
    
    NSString * name = [[NSString alloc] init];
    if (self.addAccountView.nameTextField.text.length) {
        name = self.addAccountView.nameTextField.text;
    }else{
        name = @"宝宝";
    }
    
    
    if (self.style == 0) {
        NSString * uuid = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentUserUID"];
        if ([[UserManager sharedInstance] modifyUserInfoWithUUID:uuid birthday:self.addAccountView.birthButton.titleLabel.text gender:gender nickname:name]) {
            [SVProgressHUD showInfoWithStatus:@"修改用户成功"];
            
        }else{
            [SVProgressHUD showInfoWithStatus:@"修改失败，请重试"];
        }
    }else if(self.style == 1){
        NSString * uid = [[UserManager sharedInstance] createUserWithBirthday:self.addAccountView.birthButton.titleLabel.text gender:gender nickName:name];
        if (uid) {
             [[NSUserDefaults standardUserDefaults]setObject:uid forKey:@"currentUserUID"];
            [self addRewardData];
            
            [SVProgressHUD showInfoWithStatus:@"添加用户成功"];
            ChildrenHomeViewController *viewController = [[ChildrenHomeViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
        }else{
           [SVProgressHUD showInfoWithStatus:@"添加用户失败，请重试"];
        }
    }else{
        NSString * uid = [[UserManager sharedInstance] createUserWithBirthday:self.addAccountView.birthButton.titleLabel.text gender:gender nickName:name];
        if (uid) {
            [self addRewardData];
            
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
            _addAccountView.nameTextField.text = [[UserManager sharedInstance] currentUser].nickName;
            [_addAccountView.birthButton setTitle:[[UserManager sharedInstance] currentUser].birthday forState:UIControlStateNormal];
            if (![[UserManager sharedInstance] currentUser].gender) {
                _addAccountView.boysButton.selected = YES;
                _addAccountView.girlsButton.selected = NO;
                [_addAccountView.boysButton setBackgroundColor:[UIColor clearColor]];
                [_addAccountView.girlsButton setBackgroundColor:RGBACOLOR(0, 0, 0, 0.3)];
            } else {
                _addAccountView.boysButton.selected = NO;
                _addAccountView.girlsButton.selected = YES;
                [_addAccountView.girlsButton setBackgroundColor:[UIColor clearColor]];
                [_addAccountView.boysButton setBackgroundColor:RGBACOLOR(0, 0, 0, 0.3)];
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
        UIImage *image = [UIImage imageNamed:@"check"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_addButton setImage:image forState:UIControlStateNormal];
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
