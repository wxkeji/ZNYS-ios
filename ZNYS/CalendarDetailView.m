//
//  CalendarDetailView.m
//  ZNYS
//
//  Created by yu243e on 16/6/29.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "CalendarDetailView.h"
#import "MAKAFakeRootAlertView.h"

@interface CalendarDetailView()

@property UIScrollView *scrollView;

@end

@implementation CalendarDetailView

#pragma mark life cycle
- (void)dealloc{
    _dismissBlock = nil;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor blueColor]];
    }
    return self;
}

- (instancetype)initWithModel:(CalendarItem *)model {
    self = [self init];
    if (self) {
        
    }
    return self;
}
@end
