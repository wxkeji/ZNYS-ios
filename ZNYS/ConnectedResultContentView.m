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
@end

@implementation ConnectedResultContentView

#pragma mark life cycle
- (void)dealloc {
    _countLabels = nil;
    _reinForceImageViews = nil;
    _detailModels = nil;
    _dateLabel = nil;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.dateLabel];
        for (UILabel *countLabel in self.countLabels) {
            [self addSubview:countLabel];
        }
        for (UIImageView *imageView in self.reinForceImageViews) {
            [self addSubview:imageView];
        }
        
        WS(weakSelf, self);
        
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.top.equalTo(weakSelf.mas_top).with.offset(5);
            make.width.equalTo(weakSelf.mas_width).multipliedBy(0.3);
        }];
        
        for (NSInteger i = 0; i < [self.reinForceImageViews count]; i++) {
            [self.reinForceImageViews[i] mas_makeConstraints:^(MASConstraintMaker*make){
                make.left.equalTo(weakSelf.mas_left);
            }];
        }
        
        for (NSInteger i = 0; i < [self.countLabels count]; i++) {
            [self.countLabels[i] mas_makeConstraints:^(MASConstraintMaker*make){
                make.left.equalTo(weakSelf.mas_left);
            }];
        }
        
    }
    return self;
}
#pragma mark private method
- (NSMutableArray<CalendarDetailModel *> *)transformCalendarItemToDetailModels:(CalendarItem *)calendarItem {
    NSMutableArray<CalendarDetailModel *> * calendarDetailModels = [[NSMutableArray alloc] init];
    
    if (!calendarItem) {
        return  calendarDetailModels;
    }
    if ([calendarItem.morningStarNumber integerValue]> 0) {
        CalendarDetailModel * calendarDetailModel = [[CalendarDetailModel alloc]init];
        calendarDetailModel.pictureURL = [NSString stringWithFormat:@"dayTimeReward"];
        calendarDetailModel.reinforcerPictureURL = [NSString stringWithFormat:@"star"];
        calendarDetailModel.reinforcerCount = [calendarItem.morningStarNumber integerValue];
        [calendarDetailModels addObject:calendarDetailModel];
    }
    
    if ([calendarItem.eveningStarNumber integerValue] > 0) {
        CalendarDetailModel * calendarDetailModel = [[CalendarDetailModel alloc]init];
        calendarDetailModel.pictureURL = [NSString stringWithFormat:@"nightReward"];
        calendarDetailModel.reinforcerPictureURL = [NSString stringWithFormat:@"star"];
        calendarDetailModel.reinforcerCount = [calendarItem.eveningStarNumber integerValue];
        [calendarDetailModels addObject:calendarDetailModel];
    }
    
    if ([calendarItem.connectStarNumber integerValue] > 0) {
        CalendarDetailModel * calendarDetailModel = [[CalendarDetailModel alloc]init];
        calendarDetailModel.pictureURL = [NSString stringWithFormat:@"bluetoothReward"];
        calendarDetailModel.reinforcerPictureURL = [NSString stringWithFormat:@"star"];
        calendarDetailModel.reinforcerCount = [calendarItem.connectStarNumber integerValue];
        [calendarDetailModels addObject:calendarDetailModel];
    }
    
    return calendarDetailModels;
}

#pragma mark getters and setters
- (NSMutableArray<UIImageView *> *)reinForceImageViews {
    if (!_reinForceImageViews) {
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
        }
    }
    return _countLabels;
}
- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.text = self.model.date;
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
