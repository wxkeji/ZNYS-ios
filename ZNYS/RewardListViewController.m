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
#import "Award+CoreDataClass.h"
#import "UserManager.h"

@interface RewardListViewController ()

@property (nonatomic,strong) UIImageView * imageView;

@property (nonatomic,strong) UIScrollView * rewardScrollView;

@property (nonatomic,strong) NSMutableArray<Award *> * dataArray;

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"AddAwardSuccess" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"deleteAwardSuccess" object:nil];
    
    WS(weakSelf, self);
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.top.equalTo(weakSelf.nav.mas_bottom).with.offset(CustomHeight(3));
        make.height.mas_equalTo(CustomHeight(144));
    }];
    
//    
//    
//    UIButton* addTestDataButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [addTestDataButton setTitle:@"添加数据" forState:UIControlStateNormal];
//    [addTestDataButton setBackgroundColor:[UIColor greenColor]];
//    [addTestDataButton sizeToFit];
//    [addTestDataButton setFrame:CGRectMake(50, 50, 100, 100)];
//    [addTestDataButton addTarget:self action:@selector(addTestData) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:addTestDataButton];
//    
//    
//    UIButton* testButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [testButton setTitle:@"测试数据" forState:UIControlStateNormal];
//    [testButton setBackgroundColor:[UIColor blackColor]];
//    [testButton sizeToFit];
//    [testButton setFrame:CGRectMake(150, 50, 100, 100)];
//    [testButton addTarget:self action:@selector(testButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:testButton];
    
    
}

- (void)refreshScrollView{
    for (RewardItemView * item in self.rewardScrollView.subviews) {
        [item removeFromSuperview];
    }
    self.dataArray = nil;
    
    [self addItemToScrollView];
    [self addAddItemButton];
}

#pragma mark ZNYSBaseNavigationBarDelegate

- (void)rightButtonClicked{
    NSArray * tempArr = [NSArray arrayWithArray:self.itemArray];
    for (RewardItemView * item in tempArr) {
        if (item.isSelected) {
            [[AwardManager sharedInstance] deleteAwardWithAwardUUID:item.model.uuid];
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

- (void)playRecord:(Award *)model{

}

- (void)showNextPage:(Award *)model{
   
}

#pragma mark private method

- (void)addItemToScrollView{
    CGFloat width = CustomWidth(107);
    CGFloat height = CustomHeight(142);
    
    for (NSInteger i = 0; i<self.dataArray.count; i++) {
        NSInteger num = i+1;
        RewardItemView * item = [[RewardItemView alloc] initWithFrame:CGRectMake(13+(num%3)*CustomWidth(120),CustomHeight(14)+(num/3)*CustomHeight(175),width,height) type:RecordType model:[self.dataArray objectAtIndex:i]];
        Award * model = (Award *)[self.dataArray objectAtIndex:i];
        item.tag = model.price;
        item.model = model;
        item.selectButton.hidden = self.isInDeleteMode ? NO : YES;
        item.coinLabel.text = [NSString stringWithFormat:@"x %ld",(long)model.price];
        if ([model.pitcureURL isEqualToString:@"testImage1"]) {
            item.bgView.backgroundColor = [UIColor greenColor];
        }else if ([model.pitcureURL isEqualToString:@"testImage2"]){
            item.bgView.backgroundColor = [UIColor redColor];
        }else if ([[self.dataArray objectAtIndex:i].pitcureURL isEqualToString:@"testImage3"]){
            item.bgView.backgroundColor = [UIColor cyanColor];
        }else{
            item.bgView.backgroundColor = [UIColor yellowColor];
        }
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

- (void)refresh{
    [self refreshScrollView];
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

- (NSMutableArray<Award *> *)dataArray{
    if (!_dataArray) {
        _dataArray = [[AwardManager sharedInstance] getAllAddedAwardWithUseruuid:[[UserManager sharedInstance] currentUser].uuid];
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
}


- (void)testButtonClicked
{
//    NSArray* shit;
//    shit = [[AwardManager sharedInstance] getAllAddedAwardWithUseruuid:[[UserManager sharedInstance] currentUser].uuid];
//    Award* firstResult = (Award*)shit[0];
//    
//    NSLog(@"看看结果是什么来的%d",firstResult.minPrice);
//    
//    
//    NSArray* shit2;
//    shit2 = [[AwardManager sharedInstance] getAddedAwardWithUseruuid:[[UserManager sharedInstance] currentUser].uuid];
//    
//    NSArray* shit3;
//    shit3 = [[AwardManager sharedInstance] getNotAddedAwardWithUseruuid:[[UserManager sharedInstance] currentUser].uuid];
//    
//    for(Award* fuck in shit)
//    {
//        [[AwardManager sharedInstance] exchangeAwardWithAwarduuid:fuck.uuid];
//    }
//    
//    NSArray* shitshit;
//    shitshit = [[AwardManager sharedInstance] getAllAddedAwardWithUseruuid:[[UserManager sharedInstance] currentUser].uuid];
//    
//    for(Award* aaaa in shitshit)
//    {
//        NSLog(@"状态%@",aaaa.status);
//    }
//    
    
}
@end
