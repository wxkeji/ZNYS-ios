//
//  ConnectedResultContentView.m
//  ZNYS
//
//  Created by yu243e on 16/7/14.
//  Copyright © 2016年 Woodseen. All rights reserved.
//
#import "ConnectedResultContentView.h"
#import "CalendarDetailModel.h"
@interface ConnectedResultContentView()

@property (nonatomic, strong) NSMutableArray<UILabel *> *countLabels;
@property (nonatomic, strong) NSMutableArray<UIImageView *> *reinForceImageViews;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) NSMutableArray<CalendarDetailModel *> * detailModels;
- (NSMutableArray<CalendarDetailModel *> *)transformCalendarItemToDetailModels:(CalendarItem *)calendarItem;
- (void)setConstraints;
@end

@implementation ConnectedResultContentView

#pragma mark life cycle
- (void)dealloc {
    _countLabels = nil;
    _reinForceImageViews = nil;
    _detailModels = nil;
    _dateLabel = nil;
}

- (instancetype)initWithModel:(CalendarItem *)model
{
    self = [super init];
    if (self)
    {
        self.model = model;
        //[self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.dateLabel];
        for (UILabel *countLabel in self.countLabels) {
            [self addSubview:countLabel];
        }
        for (UIImageView *imageView in self.reinForceImageViews) {
            
            [self addSubview:imageView];
        }
        
        NSLog(@"addddddd dateLabel %@\n ",self.dateLabel.text);
        
        [self setConstraints];
        
    }
    return self;
}

//- (void)setFrame:(CGRect)frame {
//    [super setFrame:frame];
//    [self setConstraints];
//}
#pragma mark private method
- (void)setConstraints {
    WS(weakSelf, self);
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(weakSelf.mas_top).with.offset(5);
        make.width.equalTo(weakSelf.mas_width).multipliedBy(0.8);
    }];
    
    NSInteger heightOffset = kSCREEN_WIDTH*0.2;
    for (NSInteger i = 0; i < [self.reinForceImageViews count]; i++) {
        [self.reinForceImageViews[i] mas_makeConstraints:^(MASConstraintMaker*make){
            make.left.equalTo(weakSelf.mas_left).offset(5);
            make.width.equalTo(weakSelf.mas_width).multipliedBy(0.2);
            make.height.equalTo(weakSelf.mas_width).multipliedBy(0.2);
            make.top.equalTo(weakSelf.dateLabel.mas_bottom).offset(15 + heightOffset * i);
        }];
    }
    
    for (NSInteger i = 0; i < [self.countLabels count]; i++) {
        [self.countLabels[i] mas_makeConstraints:^(MASConstraintMaker*make){
        make.left.equalTo(weakSelf.mas_left).offset(kSCREEN_WIDTH*0.5);
        make.top.equalTo(weakSelf.dateLabel.mas_bottom).offset(15 + heightOffset * i);
//            make.centerX.equalTo(weakSelf.mas_centerX);
//            make.centerY.equalTo(weakSelf.mas_centerY);
        }];
        
    }

}
- (NSMutableArray<CalendarDetailModel *> *)transformCalendarItemToDetailModels:(CalendarItem *)calendarItem {
    NSMutableArray<CalendarDetailModel *> * calendarDetailModels = [[NSMutableArray alloc] init];
    
    if (!calendarItem) {
        return  calendarDetailModels;
    }
    if (calendarItem.morningStarNumber> 0) {
        CalendarDetailModel * calendarDetailModel = [[CalendarDetailModel alloc]init];
        calendarDetailModel.pictureURL = [NSString stringWithFormat:@"dayTimeReward"];
        calendarDetailModel.reinforcerPictureURL = [NSString stringWithFormat:@"star"];
        calendarDetailModel.reinforcerCount = calendarItem.morningStarNumber;
        [calendarDetailModels addObject:calendarDetailModel];
    }
    
    if (calendarItem.eveningStarNumber > 0) {
        CalendarDetailModel * calendarDetailModel = [[CalendarDetailModel alloc]init];
        calendarDetailModel.pictureURL = [NSString stringWithFormat:@"nightReward"];
        calendarDetailModel.reinforcerPictureURL = [NSString stringWithFormat:@"star"];
        calendarDetailModel.reinforcerCount = calendarItem.eveningStarNumber;
        [calendarDetailModels addObject:calendarDetailModel];
    }
    
    if (calendarItem.connectStarNumber > 0) {
        CalendarDetailModel * calendarDetailModel = [[CalendarDetailModel alloc]init];
        calendarDetailModel.pictureURL = [NSString stringWithFormat:@"bluetoothReward"];
        calendarDetailModel.reinforcerPictureURL = [NSString stringWithFormat:@"star"];
        calendarDetailModel.reinforcerCount = calendarItem.connectStarNumber;
        [calendarDetailModels addObject:calendarDetailModel];
    }
    
    return calendarDetailModels;
}

#pragma mark getters and setters
- (NSMutableArray<UIImageView *> *)reinForceImageViews {
    if (!_reinForceImageViews) {
        _reinForceImageViews = [[NSMutableArray alloc]init];
        for (CalendarDetailModel * detailModel in self.detailModels) {
            UIImageView *imageView = [[UIImageView alloc]init];
            [imageView setImage:[UIImage imageNamed:detailModel.pictureURL]];
            [_reinForceImageViews addObject:imageView];
        }
    }
    return _reinForceImageViews;
}
- (NSMutableArray<UILabel *> *)countLabels {
    if (!_countLabels) {
        _countLabels = [[NSMutableArray alloc]init];
        for (CalendarDetailModel * detailModel in self.detailModels) {
            UILabel *label = [[UILabel alloc]init];
            label.text = [NSString stringWithFormat:@"x %ld",detailModel.reinforcerCount];
            label.font = [UIFont systemFontOfSize:50];
            label.textColor = RGBCOLOR(147, 214, 243);
            
            label.adjustsFontSizeToFitWidth = YES;
            label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
            [_countLabels addObject:label];
        }
    }
    return _countLabels;
}
- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]init];
        NSLog(@"%@",self.model);
        _dateLabel.text = self.model.date;
        _dateLabel.textColor = [UIColor whiteColor];
        _dateLabel.font = [UIFont systemFontOfSize:35];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
//        _dateLabel.backgroundColor = [UIColor blackColor];
    }
    return _dateLabel;
}
- (NSMutableArray<CalendarDetailModel *> *)detailModels {
    if(!_detailModels) {
        _detailModels = [self transformCalendarItemToDetailModels:self.model];
    }
    return _detailModels;
}


@end
