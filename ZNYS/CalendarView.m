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
@property (nonatomic, strong) NSMutableArray <UILabel *> * weekLabelArray;
@property (nonatomic, assign) NSInteger fisrtDayWeek;

- (void)addStarImageAndLabel:(UIButton *)dayButton  withModel:(CalendarModel *)model;
@end

@implementation CalendarView

#pragma mark life cycle

- (void)dealloc {
    _buttonClickBlock = nil;
    _weekLabelArray = nil;
}

//周日到周六 1 - 7
- (instancetype)initWithFrame:(CGRect)frame firstDay:(NSInteger)weekDay {
    self = [super initWithFrame:frame];
    if (self) {
        self.fisrtDayWeek = weekDay;
        //self.backgroundColor = RGBCOLOR(180, 239, 192);
        
        //size
        //周高度
        CGFloat weekLabelHeightScale = 0.6;
        //空白间隔
        CGFloat interval = self.frame.size.width/100;
        //宽
        CGFloat width = self.frame.size.width/7.0 - interval*2;
        //高
        CGFloat height = self.frame.size.height/(3 + weekLabelHeightScale) - interval*2;
        
        for (NSInteger i = 0; i < 7; i++) {
            NSInteger theDay = weekDay + i;
            if (theDay > 7) {
                theDay = theDay - 7;
            }
            UILabel *label = [[UILabel alloc] initWithCustomFont:50.f];
            label.text = [[NSString alloc]initWithFormat: @"周%@",[self changeNumberToString:(theDay)]];
            label.textColor = RGBCOLOR(113,177,200);
            label.adjustsFontSizeToFitWidth = YES;
            //label.backgroundColor = RGBCOLOR(175,243,227);
            label.frame = CGRectMake((interval*1.3 + (self.frame.size.width)/7.0*(i%7)), (interval * 0.5), width, height * weekLabelHeightScale);
            
            [self addSubview:label];
            [self.weekLabelArray addObject:label];

        }
        for (NSInteger i = 0; i < 21; i++) {
            //color 生成背景图片用
            UIColor *dayButtonColor;
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
                default:
                    break;
            }
            
            UIButton *dayButton = [UIButton buttonWithType:UIButtonTypeCustom];
            dayButton.frame = CGRectMake((interval + (self.frame.size.width)/7.0*(i%7)), (interval + self.frame.size.height/3.6 * (weekLabelHeightScale + (i/7))), width, height);
            [dayButton setBackgroundImage:[self imageWithColor:dayButtonColor] forState:UIControlStateNormal];
            
            
            
           
            
            //圆角
            dayButton.layer.masksToBounds = YES;
            dayButton.layer.cornerRadius = 6.0;
            
            //Tag
            dayButton.tag = i;
            
            [dayButton addTarget:self action:@selector(dayButtonAction:) forControlEvents:UIControlEventTouchUpInside];

            [self addSubview:dayButton];
            [self.dayButtonArray addObject:dayButton];
        }
    }
    return self;
}


#pragma mark private method
- (void)addStarImageAndLabel:(UIButton *)dayButton withModel:(CalendarModel *)model {
    //size
    //周高度
    CGFloat weekLabelHeightScale = 0.6;
    //空白间隔
    CGFloat interval = self.frame.size.width/100;
    //宽
    CGFloat width = self.frame.size.width/7.0 - interval*2;
    //高
    CGFloat height = self.frame.size.height/(3 + weekLabelHeightScale) - interval*2;
    
    //加入星星
    UIImage *starImage =[UIImage imageNamed:@"star"];
    [dayButton setImage:starImage forState:UIControlStateNormal];
    dayButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    //微调位置
    dayButton.imageEdgeInsets = UIEdgeInsetsMake(height*0.05, 0.0, 0.0, 0.0);
    
    //加入文字
    UILabel *starNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    [starNumLabel setText:[NSString stringWithFormat:@"%ld",model.starNum]];
    [starNumLabel setTextColor:[UIColor grayColor]];
    [starNumLabel setTextAlignment:NSTextAlignmentCenter];
    starNumLabel.adjustsFontSizeToFitWidth = YES;

}

//颜色→UIimage 为了动画效果
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
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
#pragma mark event action

- (void)changeTodayButtonColor:(NSInteger) tag {
    if (tag >= 0 && tag < 21) {
        [self.dayButtonArray[tag] setBackgroundImage:[self imageWithColor:RGBCOLOR(237,133,51)] forState:UIControlStateNormal];
    } else {
        NSLog(@"tag invalid");
    }
}

- (void)dayButtonAction:(UIButton*)button {
    if (self.buttonClickBlock) {
        self.buttonClickBlock(button.tag);
    }
}

#pragma mark getters and setters
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

- (NSMutableArray <UIButton *> *)dayButtonArray {
    if (!_dayButtonArray) {
        _dayButtonArray = [[NSMutableArray alloc]initWithCapacity:21];    }
    return _dayButtonArray;
}

- (NSMutableArray <UILabel *> *)weekLabelArray {
    if (!_weekLabelArray) {
        _weekLabelArray = [[NSMutableArray alloc]initWithCapacity:7];    }
    return _weekLabelArray;
}
@end
