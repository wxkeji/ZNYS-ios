//
//  CalendarView.m
//  ZNYS
//
//  Created by yu243e on 16/6/22.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "CalendarView.h"
#import "CalendarModel.h"

@interface CalendarView()

@property (nonatomic, strong) NSMutableArray <CalendarModel *> * models;
@property (nonatomic, strong) NSMutableArray <UIButton *> * dayButtonArray;
@property (nonatomic, strong) NSMutableArray <UILabel *> * dayButtonStarNumLabelArray;
@property (nonatomic, strong) NSMutableArray <UILabel *> * weekLabelArray;
@property (nonatomic, assign) NSInteger firstDayWeek;

@end

@implementation CalendarView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = RGBCOLOR(180, 239, 192);
        
        for (UILabel *weekLabel in self.weekLabelArray) {
            [self addSubview:weekLabel];
        }
        for(UIButton *dayButton in self.dayButtonArray) {
            [self addSubview:dayButton];
            [dayButton addTarget:self action:@selector(dayButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //周高度
    CGFloat weekLabelHeightScale = 0.6;
    //空白间隔
    CGFloat interval = self.frame.size.width/100;
    //日按钮宽
    CGFloat width = self.frame.size.width/7.0 - interval*2;
    //日按钮高
    CGFloat height = self.frame.size.height/(3 + weekLabelHeightScale) - interval*2;
    
    UILabel *weekLabel;
    for (NSInteger i = 0; i < 7; i++) {
        NSInteger theDay = self.firstDayWeek + i;
        if (theDay > 7) {
            theDay = theDay - 7;
        }
        weekLabel = [self.weekLabelArray objectAtIndex:(theDay-1)];
        weekLabel.frame = CGRectMake((interval*1.3 + (self.frame.size.width)/7.0*(i%7)), (interval * 0.5), width, height * weekLabelHeightScale);
    }
    
    UIButton *dayButton;
    for (NSInteger i = 0; i < 21; i++) {
        dayButton = [self.dayButtonArray objectAtIndex:i];
        //微调星星位置 如果有
        dayButton.imageEdgeInsets = UIEdgeInsetsMake(height*0.05, 0.0, 0.0, 0.0);
        dayButton.frame = CGRectMake((interval + (self.frame.size.width)/7.0*(i%7)), (interval + self.frame.size.height/3.6 * (weekLabelHeightScale + (i/7))), width, height);
    }
    
    for (UILabel *dayButtonStarNumLabel in self.dayButtonStarNumLabelArray) {
        dayButtonStarNumLabel.frame = CGRectMake(0, 0, width, height);
    }
}

#pragma mark - public method
- (void)changeTodayButtonColor:(NSInteger)tag {
    if (tag >= 0 && tag < 21) {
        [self.dayButtonArray[tag] setBackgroundImage:[UIImage imageWithColor:RGBCOLOR(237,133,51)] forState:UIControlStateNormal];
    } else {
        NSLog(@"tag invalid 当天不在当前日历中");
    }
}

- (void)setModels:(NSMutableArray<CalendarModel *> *) models {
    if ([models count] != 21) {
        NSLog(@"models count != 21 ");
        return ;
    }
    _models = models;
    for (CalendarModel *model in _models) {
        if (model.future == YES) {
            self.dayButtonArray[model.tag].userInteractionEnabled = NO;
        } else {
            if (model.validData == YES) {
                [self addStarImageAndLabel:self.dayButtonArray[model.tag] withModel:model];
            }
        }
    }
}

- (void)setFirstDayWeek:(NSInteger)firstDayWeek {
    if (_firstDayWeek == firstDayWeek) {
        return;
    }
    if (firstDayWeek < 0 || firstDayWeek > 7) {
        firstDayWeek = 1;
    }
    _firstDayWeek = firstDayWeek;
    
    [self setNeedsLayout];
}
#pragma mark - private method
- (void)addStarImageAndLabel:(UIButton *)dayButton withModel:(CalendarModel *)model {
    //加入星星
    UIImage *starImage =[UIImage imageNamed:@"calendar/star"];
    [dayButton setImage:starImage forState:UIControlStateNormal];
    
    //加入文字
    UILabel *starNumLabel = [[UILabel alloc]init];
    //WithFrame:CGRectMake(0, 0, width, height)];不能在这里设置 frame
    [starNumLabel setText:[NSString stringWithFormat:@"%ld",model.starNum]];
    [starNumLabel setTextColor:[UIColor grayColor]];
    [starNumLabel setTextAlignment:NSTextAlignmentCenter];
    starNumLabel.adjustsFontSizeToFitWidth = YES;
    [self.dayButtonStarNumLabelArray addObject:starNumLabel];
    [dayButton addSubview:starNumLabel];
}

- (NSString *)changeNumberToString:(NSInteger)number{
    switch (number - 1) {
        case 0:
            return @"日";
            break;
            
        case 1:
            return @"一";
            break;
            
        case 2:
            return @"二";
            break;
            
        case 3:
            return @"三";
            break;
            
        case 4:
            return @"四";
            break;
            
        case 5:
            return @"五";
            break;
            
        case 6:
            return @"六";
            break;
        
        default:
            return nil;
            break;
    }
}

#pragma mark - event action
- (void)dayButtonAction:(UIButton*)button {
    if (self.buttonClickBlock) {
        self.buttonClickBlock(button.tag);
    }
}

#pragma mark - getters and setters
@synthesize firstDayWeek = _firstDayWeek;
- (NSInteger)firstDayWeek {
    if (_firstDayWeek == 0) {
        _firstDayWeek = 1;
    }
    return _firstDayWeek;
}

- (NSMutableArray <UIButton *> *)dayButtonArray {
    if (!_dayButtonArray) {
        _dayButtonArray = [[NSMutableArray alloc]initWithCapacity:21];
        for (NSInteger i = 0; i < 21; i++) {
            UIButton *dayButton = [UIButton buttonWithType:UIButtonTypeCustom];
            UIColor *dayButtonColor = nil;
            switch (i / 7) {
                case 0:
                    dayButtonColor = RGBCOLOR(48,225,183);
                    break;
                case 1:
                    dayButtonColor = RGBCOLOR(107,212,247);
                    break;
                case 2:
                    dayButtonColor = RGBCOLOR(68,182,219);
                    break;
            }
            [dayButton setBackgroundImage:[UIImage imageWithColor:dayButtonColor] forState:UIControlStateNormal];
            
            dayButton.layer.masksToBounds = YES;
            dayButton.layer.cornerRadius = 6.0;
            
            dayButton.tag = i;
            
            //为星星准备 布局相关
            dayButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
            
            [_dayButtonArray addObject:dayButton];
        }
    }
    return _dayButtonArray;
}

- (NSMutableArray <UILabel *> *)dayButtonStarNumLabelArray {
    if (!_dayButtonStarNumLabelArray) {
        _dayButtonStarNumLabelArray = [[NSMutableArray alloc]init];
    }
    return _dayButtonStarNumLabelArray;
}

- (NSMutableArray <UILabel *> *)weekLabelArray {
    if (!_weekLabelArray) {
        _weekLabelArray = [[NSMutableArray alloc]initWithCapacity:7];
        for (NSInteger i = 0; i < 7; i++) {
            UILabel *label = [[UILabel alloc] initWithCustomFont:50.f];
            label.textColor = RGBCOLOR(113,177,200);
            label.text = [[NSString alloc]initWithFormat: @"周%@",[self changeNumberToString:(i+1)]];
            //布局相关
            label.adjustsFontSizeToFitWidth = YES;
            
            [_weekLabelArray addObject:label];
        }
        
    }
    return _weekLabelArray;
}
@end
