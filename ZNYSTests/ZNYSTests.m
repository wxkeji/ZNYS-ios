//
//  ZNYSTests.m
//  ZNYSTests
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 Woodseen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "GiftStatusManager.h"

@interface ZNYSTests : XCTestCase

@end


@interface GiftWithState(Test)

- (void)print;

@end

@implementation GiftWithState(Test)

- (void)print
{
    NSLog(@"Name:%@\tstarsToActvat:%d\tState:%@",self.name,self.starsToActivate,self.state.toString);
}

@end


@interface GiftStatusManager(Test)

- (void)printGiftList;

@end

@implementation GiftStatusManager(Test)

- (void)printGiftList
{
    for(GiftWithState *g in self.giftList)
    {
        [g print];
    }
}

@end




@implementation ZNYSTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    NSMutableArray *list = [[NSMutableArray alloc] init];
    for(int i=0;i<8;i++)
    {
        GiftWithState *gws = [[GiftWithState alloc] initWithGiftName:[NSString stringWithFormat:@"Gift %d",i] starsToActivate:i];
        [list addObject:gws];
    }
    NSArray *giftList = [list copy];
    GiftStatusManager *gsm = [[GiftStatusManager alloc] initWithCurrentNumbersOfStars:100 giftList:(NSArray *)giftList];
    [gsm checkGiftStateOfPage:0];
    [gsm printGiftList];
    
    //增加一些星星，看看礼品状态的变化
    [gsm increaseStars:5];
    [gsm checkGiftStateOfPage:0];
    [gsm printGiftList];
    
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
