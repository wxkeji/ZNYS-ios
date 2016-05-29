//
//  RewardListViewController.m
//  ZNYS
//
//  Created by Ellise on 16/1/14.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "RewardListViewController.h"
#import "ZNYSBaseNavigationBar.h"
#import "rewardListModel.h"
#import "AddRewardButtonView.h"
#import "CoreDataHelper.h"
#import "AwardManager.h"
#import "Award+CoreDataProperties.h"
#import "Award.h"
#import "User.h"

@interface RewardListViewController ()

@property (nonatomic,strong) UIImageView * imageView;

@property (nonatomic,strong) UIScrollView * rewardScrollView;

@property (nonatomic,strong) NSMutableArray<rewardListModel *> * dataArray;

@property (nonatomic,strong) NSMutableArray<RewardItemView *> * itemArray;

@property (nonatomic,assign) BOOL isInDeleteMode;

@property (nonatomic) CGFloat contentOffsetX;

@end

@implementation RewardListViewController

#pragma mark life cycle

- (void)dealloc{
    _imageView = nil;
    _rewardScrollView = nil;
    _dataArray = nil;
    _itemArray = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isInDeleteMode = NO;
    self.contentOffsetX = 0;
    
    self.nav.hidden = NO;
    self.nav.delegate = self;
    [self.nav.rightButton setTitle:@"删除" forState:UIControlStateNormal];
    UIColor * backColor = [UIColor redColor];
    UIColor * titleColor = [UIColor whiteColor];
    [self setNavBarWithTitle:@"奖励清单" Color:backColor TextColor:titleColor];
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.rewardScrollView];
    WS(weakSelf, self);
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.top.equalTo(weakSelf.nav.mas_bottom).with.offset(CustomHeight(3));
        make.height.mas_equalTo(CustomHeight(144));
    }];
    
    
    
    UIButton* addTestDataButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addTestDataButton setTitle:@"添加数据" forState:UIControlStateNormal];
    [addTestDataButton setBackgroundColor:[UIColor greenColor]];
    [addTestDataButton sizeToFit];
    [addTestDataButton setFrame:CGRectMake(50, 50, 100, 100)];
    [addTestDataButton addTarget:self action:@selector(addTestData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addTestDataButton];
    
    
    UIButton* testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [testButton setTitle:@"测试数据" forState:UIControlStateNormal];
    [testButton setBackgroundColor:[UIColor blackColor]];
    [testButton sizeToFit];
    [testButton setFrame:CGRectMake(150, 50, 100, 100)];
    [testButton addTarget:self action:@selector(testButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testButton];
    
    
}

- (void)refreshScrollView{
    [self.rewardScrollView removeFromSuperview];
    self.rewardScrollView = nil;
    
    [self.itemArray removeAllObjects];
    
    [self.view addSubview:self.rewardScrollView];
}

#pragma mark ZNYSBaseNavigationBarDelegate

- (void)rightButtonClicked{
    NSArray * tempArr = [NSArray arrayWithArray:self.itemArray];
    for (RewardItemView * item in tempArr) {
        if (item.isSelected) {
            [self.itemArray removeObjectAtIndex:item.tag];
            [self.dataArray removeObjectAtIndex:item.tag];
        }
    }
    
    self.isInDeleteMode = NO;
    self.contentOffsetX = self.rewardScrollView.contentOffset.x;
    
    [self refreshScrollView];
    
    self.nav.rightButton.hidden = !self.isInDeleteMode;
}

#pragma mark RewardItemViewDelegate

- (void)startDelete{
    self.nav.rightButton.hidden = NO;
    self.isInDeleteMode = YES;
    self.contentOffsetX = self.rewardScrollView.contentOffset.x;
    
    [self refreshScrollView];
}

- (void)playRecord:(rewardListModel *)model{

}

- (void)showNextPage:(rewardListModel *)model{
   
}

#pragma mark private method

- (void)addItemToScrollView{
    CGFloat width = CustomWidth(107);
    CGFloat height = CustomHeight(142);
    
    for (NSInteger i = 0; i<self.dataArray.count; i++) {
        NSInteger num = i+1;
        RewardItemView * item = [[RewardItemView alloc] initWithFrame:CGRectMake(13+(num%3)*CustomWidth(120),CustomHeight(14)+(num/3)*CustomHeight(175),width,height) type:RecordType model:[self.dataArray objectAtIndex:i]];
        item.tag = [self.dataArray objectAtIndex:i].coins;
        item.selectButton.hidden = self.isInDeleteMode ? NO : YES;
        item.coinLabel.text = [NSString stringWithFormat:@"x %ld",(long)[self.dataArray objectAtIndex:i].coins];
        item.delegate = self;
        [self.rewardScrollView addSubview:item];
        [self.itemArray addObject:item];
    }

}

- (void)addAddItemButton{
    CGFloat width = CustomWidth(107);
    CGFloat height = CustomHeight(142);
    
    AddRewardButtonView * addButton = [[AddRewardButtonView alloc] initWithFrame:CGRectMake(CustomWidth(17), CustomHeight(14), width, height)];
    [_rewardScrollView addSubview:addButton];

}

- (void)deleteItemInScrollView{
    NSArray * tempArr = [NSArray arrayWithArray:self.itemArray];
    for (RewardItemView * item in tempArr) {
        [item removeFromSuperview];
        [self.itemArray removeObjectAtIndex:item.tag];
    }
}

#pragma mark getters and setters

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor yellowColor];
    }
    return _imageView;
}

- (UIScrollView *)rewardScrollView{
    if (!_rewardScrollView) {
        _rewardScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CustomHeight(202), kSCREEN_WIDTH, CustomHeight(446))];
        _rewardScrollView.backgroundColor = [UIColor whiteColor];
        _rewardScrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, ((self.dataArray.count/3)+1)*CustomHeight(200));
        _rewardScrollView.pagingEnabled = NO;
        _rewardScrollView.showsVerticalScrollIndicator = FALSE;
        _rewardScrollView.showsHorizontalScrollIndicator = YES;
        [_rewardScrollView setContentOffset:CGPointMake(_contentOffsetX, 0)];
        
        //添加奖品blockview
        [self addItemToScrollView];
        
        //添加添加奖品按钮
        [self addAddItemButton];
    }
    return _rewardScrollView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i<30; i++) {
            rewardListModel * model = [[rewardListModel alloc] init];
            model.coins = i;
            [_dataArray addObject:model];
        }
    }
    return _dataArray;
}

- (NSMutableArray *)itemArray{
    if (!_itemArray) {
        _itemArray = [[NSMutableArray alloc]init];
    }
    return _itemArray;
}



- (void)addTestData
{
    Award* testAward1 = [[CoreDataHelper sharedInstance] createAward];
    testAward1.pitcureURL = @"testImage1";
    testAward1.minPrice = 1;
    testAward1.price = 5;
    testAward1.maxPrice = 10;
    testAward1.voice = @"录音路径.mp3";
    testAward1.status = @"notAdded";
    testAward1.type = @"consume";
    testAward1.userID = [User currentUserUUID];
    testAward1.uuid = [[NSUUID UUID] UUIDString];
    
    
    Award* testAward2 = [[CoreDataHelper sharedInstance] createAward];
    testAward2.pitcureURL = @"testImage2";
    testAward2.minPrice = 5;
    testAward2.price = 8;
    testAward2.maxPrice = 10;
    testAward2.voice = @"录音路径.mp3";
    testAward2.status = @"notAdded";
    testAward2.type = @"possess";
    testAward2.userID = [User currentUserUUID];
    testAward2.uuid = [[NSUUID UUID] UUIDString];
    

    
    Award* testAward3 = [[CoreDataHelper sharedInstance] createAward];
    testAward3.pitcureURL = @"testImage3";
    testAward3.minPrice = 1;
    testAward3.price = 5;
    testAward3.maxPrice = 10;
    testAward3.voice = @"录音路径.mp3";
    testAward3.status = @"notAdded";
    testAward3.type = @"activity";
    testAward3.userID = [User currentUserUUID];
    testAward3.uuid = [[NSUUID UUID] UUIDString];
    

    
    Award* testAward4 = [[CoreDataHelper sharedInstance] createAward];
    testAward4.pitcureURL = @"testImage1";
    testAward4.minPrice = 10;
    testAward4.price = 20;
    testAward4.maxPrice = 30;
    testAward4.voice = @"录音路径.mp3";
    testAward4.status = @"added";
    testAward4.type = @"consume";
    testAward4.userID = [User currentUserUUID];
    testAward4.uuid = [[NSUUID UUID] UUIDString];
    
    
    Award* testAward5 =[[CoreDataHelper sharedInstance] createAward];
    testAward5.pitcureURL = @"testImage1";
    testAward5.minPrice = 1;
    testAward5.price = 5;
    testAward5.maxPrice = 10;
    testAward5.voice = @"录音路径.mp3";
    testAward5.status = @"added";
    testAward5.type = @"possess";
    testAward5.userID = [User currentUserUUID];
    testAward5.uuid = [[NSUUID UUID] UUIDString];
    

    
    Award* testAward6 = [[CoreDataHelper sharedInstance] createAward];
    testAward6.pitcureURL = @"testImage2";
    testAward6.minPrice = 12;
    testAward6.price = 13;
    testAward6.maxPrice = 15;
    testAward6.voice = @"录音路径.mp3";
    testAward6.status = @"added";
    testAward6.type = @"activity";
    testAward6.userID = [User currentUserUUID];
    testAward6.uuid = [[NSUUID UUID] UUIDString];
    

    
    Award* testAward7 = [[CoreDataHelper sharedInstance] createAward];
    testAward7.pitcureURL = @"testImage2";
    testAward7.minPrice = 6;
    testAward7.price = 9;
    testAward7.maxPrice = 10;
    testAward7.voice = @"录音路径.mp3";
    testAward7.status = @"added";
    testAward7.type = @"consume";
    testAward7.userID = [User currentUserUUID];
    testAward7.uuid = [[NSUUID UUID] UUIDString];
    

    
    Award* testAward8 =[[CoreDataHelper sharedInstance] createAward];
    testAward8.pitcureURL = @"testImage3";
    testAward8.minPrice = 1;
    testAward8.price = 5;
    testAward8.maxPrice = 10;
    testAward8.voice = @"录音路径.mp3";
    testAward8.status = @"notAdded";
    testAward8.type = @"consume";
    testAward8.userID = [User currentUserUUID];
    testAward8.uuid = [[NSUUID UUID] UUIDString];
    

    
    Award* testAward9 =[[CoreDataHelper sharedInstance] createAward];
    testAward9.pitcureURL = @"testImage2";
    testAward9.minPrice = 1;
    testAward9.price = 5;
    testAward9.maxPrice = 10;
    testAward9.voice = @"录音路径.mp3";
    testAward9.status = @"notAdded";
    testAward9.type = @"consume";
    testAward9.userID = [User currentUserUUID];
    testAward9.uuid = [[NSUUID UUID] UUIDString];
    

    
    Award* testAward10 = [[CoreDataHelper sharedInstance] createAward];
    testAward10.pitcureURL = @"testImage4";
    testAward10.minPrice = 1;
    testAward10.price = 5;
    testAward10.maxPrice = 10;
    testAward10.voice = @"录音路径.mp3";
    testAward10.status = @"notAdded";
    testAward10.type = @"consume";
    testAward10.userID = [User currentUserUUID];
    testAward10.uuid = [[NSUUID UUID] UUIDString];
    

    
    
    Award* testAward11 = [[CoreDataHelper sharedInstance] createAward];
    testAward11.pitcureURL = @"testImage1";
    testAward11.minPrice = 1;
    testAward11.price = 5;
    testAward11.maxPrice = 10;
    testAward11.voice = @"录音路径.mp3";
    testAward11.status = @"notAdded";
    testAward11.type = @"consume";
    testAward11.userID = [User currentUserUUID];
    testAward11.uuid = [[NSUUID UUID] UUIDString];
 
    
    [[CoreDataHelper sharedInstance] save];

}


- (void)testButtonClicked
{
    NSArray* shit;
    shit = [[AwardManager sharedInstance] getAllAddedAwardWithUseruuid:[User currentUserUUID]];
    Award* firstResult = (Award*)shit[0];
    
    NSLog(@"看看结果是什么来的%d",firstResult.minPrice);
    
    
    NSArray* shit2;
    shit2 = [[AwardManager sharedInstance] getAddedAwardWithUseruuid:[User currentUserUUID]];
    
    NSArray* shit3;
    shit3 = [[AwardManager sharedInstance] getNotAddedAwardWithUseruuid:[User currentUserUUID]];
    
    for(Award* fuck in shit)
    {
        [[AwardManager sharedInstance] exchangeAwardWithAwarduuid:fuck.uuid];
    }
    
    NSArray* shitshit;
    shitshit = [[AwardManager sharedInstance] getAllAddedAwardWithUseruuid:[User currentUserUUID]];
    
    for(Award* aaaa in shitshit)
    {
        NSLog(@"状态%@",aaaa.status);
    }
    
    
}
@end
