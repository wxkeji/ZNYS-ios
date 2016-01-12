//
//  ViewController.m
//  ZNYS
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 Woodseen. All rights reserved.
//

#import "CabinetViewController.h"
#import "CalendarViewController.h"
#import "IsParentViewController.h"
#import "Config.h"
#import "NSArray+ForceBound.h"
#import "DialogView.h"
#import "ToolMacroes.h"
#import "UILabel+Font.h"
#import "VerifyPasswordViewController.h"
#import "ConnectingViewController.h"
#import "User.h"
#import "CabinetItem.h"
#import "GiftItem.h"
@interface CabinetViewController ()

//奖品柜的两个ScrollView

@property (weak, nonatomic) IBOutlet UIScrollView *gloryScrollView;   //奖品柜上层，存放荣誉奖杯等
@property (weak,nonatomic) IBOutlet UIScrollView *bathItemScrollView; //奖品柜下层，存放浴室关键物件

@property (strong, nonatomic) NSMutableArray *gloryList;
@property (strong, nonatomic) NSMutableArray *giftList;

//用户状态控件

@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *stars;//屏幕上显示的星星数
@property (weak, nonatomic) IBOutlet UIImageView *cartoonHead;  //奖品柜上的卡通人头。。它会根据性别显示蓝色这个或者粉红色的另一个
@property (weak, nonatomic) IBOutlet UILabel *level;

//按钮

@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
@property (weak, nonatomic) IBOutlet UIButton *calendarButton;
@property (weak, nonatomic) IBOutlet UIButton *connectToothBrushButton;

@property (weak, nonatomic) IBOutlet UIButton *bookButton;  //这个是日历按钮左边的按钮，看起来像一本书

//通知中心、广告

@property (weak, nonatomic) IBOutlet UIImageView *ADBackroung;//广告位的背景图片
@property (weak, nonatomic) IBOutlet UIImageView *advertismentLabel;//广告位Label

@property (strong, nonatomic) NSNumber* userLevel;

@end

@implementation CabinetViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view layoutIfNeeded];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDetailChange) name:@"userDidSwitch" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDetailChange) name:@"userDidCreate" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDetailChange) name:@"userDetailDidChange" object:nil];
    
    //设置屏幕上的信息
    
    self.userLevel = [User currentUserLevel];
    [self addObserver:self forKeyPath:@"userLevel" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    self.level.text = [NSString stringWithFormat:@"LV%ld",[self.userLevel integerValue]];
    self.username.text = [User currentUserName];
    self.stars.text = [NSString stringWithFormat:@"%@",[User currentUserStarsOwned]];
    
    //测试等级按钮
    UIButton * levelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    levelButton.frame = CGRectMake(0, 100, 80, 60);
    levelButton.backgroundColor = [UIColor purpleColor];
    [levelButton setTitle:@"等级测试" forState:UIControlStateNormal];
    [levelButton addTarget:self action:@selector(changeLevel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:levelButton];
    
    [self initButtonEvents];
    [self initCabinet];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"userLevel"];
}

#pragma mark - Private Methods

- (void)changeLevel{
    NSInteger level =[self.userLevel integerValue];
    NSInteger addResult = (++level)%11;
    if (addResult == 0) {
        addResult++;
    }
    NSNumber * result = [NSNumber numberWithInteger:addResult];
    [self setValue:result forKey:@"userLevel"];
}

- (void)userDetailChange{
    self.userLevel = [User currentUserLevel];
    self.level.text = [NSString stringWithFormat:@"LV%@",self.userLevel];
    self.username.text = [User currentUserName];
    self.stars.text = [NSString stringWithFormat:@"%@",[User currentUserStarsOwned]];
    [self refreshCabinet];
}

- (void)initButtonEvents
{
    [self.calendarButton addTarget:self action:@selector(toCalendar) forControlEvents:UIControlEventTouchUpInside];
    [self.settingsButton addTarget:self action:@selector(toSetting) forControlEvents:UIControlEventTouchUpInside];
    [self.connectToothBrushButton addTarget:self action:@selector(toConnectBrush) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initCabinet
{
    //创建两个列表,添加若干小车到里面
    [self initGloryList];
    [self initGiftList];
    
    [self setItemScrollView:self.gloryScrollView
                   itemList:self.gloryList
               itemEachPage:4
                onItemClick:@selector(itemWasTouched:)];
    
    [self setItemScrollView:self.bathItemScrollView
                   itemList:self.giftList
               itemEachPage:4
                onItemClick:@selector(itemWasTouched:)];
}

- (void)initGloryList{
    [self.gloryList removeAllObjects];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MetalList" ofType:@"plist"];
    NSArray *jsonArray = [NSArray arrayWithContentsOfFile:path];
    
   // self.giftStatusManager.gloryItemList = [[NSMutableArray alloc] init];
    NSString *littleCar = @"小车";
    for(NSInteger i = 1;i <= 10;i++)
    {
        ItemStateEnum state;
        if(i <= [self.userLevel integerValue]){
            state = Obtained;
        }
        else{
            state = NotActiveted;
        }
        
        NSDictionary * itemDic = [jsonArray objectAtIndex:(i-1)];
        CabinetItem *gloryItem = [[CabinetItem alloc] initWithDictionary:[itemDic objectForKey:[NSString stringWithFormat:@"Level%ld",(long)i]] imageName:littleCar state:state tag:i style:0 starsToActivate:i];
        [self.gloryList addObject:gloryItem];
    }
    
}

/*
 *
 *  这个函数需要GiftList.plist文件，文件中的每一个子项目需要有：
 *      1、title                 ：   NSString
 *      2、description           ：   NSString
 *      3、shadow-description    ：   NSString
 *      4、iamge-name            ：   NSString
 *      5、item-state            ：   NSNumber        其中0、1、2分别代表Obtained、ActivatedNotObtained、NotActivate三种状态
 *      6、stars-to-activate     ：   NSNumber
 *
 */
- (void)initGiftList {
    [self.giftList removeAllObjects];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"GiftList" ofType:@"plist"];
    NSArray *jsonArray = [NSArray arrayWithContentsOfFile:path];
    
    NSInteger i = 0;
    for(NSDictionary *itemDict in jsonArray)
    {
        GiftItem *giftItem = [[GiftItem alloc] initWithDictionary:itemDict tag:i style:1];
        i++;
        [self.giftList addObject:giftItem];
    }
    
}


//把对应的item的View添加到ScrollView中
- (void)setItemScrollView:(UIScrollView *)scrollView
                 itemList:(NSMutableArray *)giftList
             itemEachPage:(int)itemEachPage
                 onItemClick:(SEL)onItemClickSelecor
{
    //根据奖品列表获得礼品柜的个数
    long n = ([giftList count] - 1) / itemEachPage + 1;
    
    CGFloat width = scrollView.frame.size.width;
    CGFloat height = scrollView.frame.size.height;
    
    [self initScrollView:scrollView
               WithContentWidth:width
                  height:height
               totalPage:n];
    
    //把奖品柜的宽度n等分
    CGFloat itemWidth = width / itemEachPage;
    
    //在奖品柜视图里添加礼物的图片,然后为每一个奖品添加触摸手势
    for(NSInteger i=0;i<[giftList count];i++)
    {
        //从奖品管理器中获取第i个奖品
        CabinetItem *itemWithState = giftList[i];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:itemWithState.imageName];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        // nx 和 ny表示在 4 * 2 的奖品方阵中中的位置
        //根据奖品在奖品奖品列表中的位置i算出它在4 * 2方阵中的对应位置
        NSInteger nx;
        nx = i;
        
        CGRect itemRect = [self getRectOfItemAt:(int)nx
                                    itemWidth:itemWidth
                             scrollViewHeight:height];
        CGFloat itemHeight = itemRect.size.height;
        imageView.frame = CGRectMake(itemRect.origin.x,itemRect.origin.y + itemHeight / 5.0,itemWidth,3.0 / 5 * height);
        
        imageView.userInteractionEnabled = YES;
        
        //把奖品button添加到奖品柜视图
        [scrollView addSubview:imageView];
        
        UITapGestureRecognizer *tapRecog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemWasTouched:)];
        tapRecog.numberOfTapsRequired = 1;
        tapRecog.numberOfTouchesRequired = 1;
        
        [imageView addGestureRecognizer:tapRecog];
        
        //设置button的tag，后面可以用tag找到对应的奖品
        imageView.tag = i;
    }
}

- (void)initScrollView:(UIScrollView *)scrollView
             WithContentWidth:(CGFloat)width
                height:(CGFloat)height
             totalPage:(long)totalPage
{
    //根据礼品柜的个数设置礼品柜scrollView的滚动页数
    scrollView.contentSize = CGSizeMake(width * totalPage, height);
    
    //隐藏cabinetControlView的滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    //打开scrollView的弹簧效果
    scrollView.bounces = YES;
    
    //scrollView额外滚动范围为零
    scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    //开启scrollView的分页
    [scrollView setPagingEnabled:YES];
    
    scrollView.delaysContentTouches = NO;
}

- (void)refreshCabinet
{
    for(UIView *view in self.gloryScrollView.subviews) {
        [view removeFromSuperview];
    }
    for(UIView *view in self.bathItemScrollView.subviews) {
        if([view class] == [UIImageView class]){
            [view removeFromSuperview];
        }
    }
    [self initGloryList];
    [self setItemScrollView:self.gloryScrollView itemList:self.gloryList itemEachPage:4 onItemClick:@selector(itemWasTouched:)];
    [self setItemScrollView:self.bathItemScrollView itemList:self.giftList itemEachPage:4 onItemClick:@selector(itemWasTouched:)];
    
}

//根据nx和ny进一步算出每一个奖品精确的位置
//奖品柜里面高度的比例为  星星：物品：星星：物品 = 1.52：6.88：1.52：6.88 。从而按照比例推算出定位的坐标
- (CGRect)getRectOfItemAt:(int)nx
              itemWidth:(CGFloat)itemWidth
             scrollViewHeight:(CGFloat)scrollViewHeight
{
    float buttonX,buttonY,buttonWidth,buttonHeight;
    buttonX = itemWidth * nx;
    //buttonY = 1.52 / 15.28 * height + 1.0 / 2 * height * ny;
    buttonY = 0;
    buttonWidth = itemWidth;
    buttonHeight = 6.88 / (15.28 / 2) * scrollViewHeight;
    //buttonHeight = 3.0 / 5 * scrollViewHeight;
    return CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
}

#pragma mark KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"userLevel"]) {
        self.level.text = [NSString stringWithFormat:@"LV%ld",[self.userLevel integerValue]];
        
        [self refreshCabinet];
    }
}

#pragma mark - Event Action

//响应item的点击事件
- (void) itemWasTouched:(UITapGestureRecognizer *)recognizer
{
    //index表示这个item在item列表是第几个
    UIImageView *itemView = (UIImageView *)recognizer.view;
    NSInteger index=itemView.tag;
    
    NSString *itemName,*conditionToGet;
    CabinetItem *item;
    if(itemView.superview == self.gloryScrollView)
    {
         item= self.gloryList[index];
    }
    else
    {
        item= self.giftList[index];
    }
    itemName = item.itemName;
    conditionToGet = [NSString stringWithFormat:@"兑换条件：%ld颗星星",(long)item.starsToActivate];
    
    DialogView *dialogView = [DialogView instanceDialogViewWithItemName:itemName conditionToGet:conditionToGet descriptionText:item.descriptionText];
    dialogView.alpha = 1.0;
    dialogView.frame = self.view.bounds;
    [self.view addSubview:dialogView];
    [self.view bringSubviewToFront:dialogView];
    NSLog(@"Item was touched.");
}


- (void)toCalendar
{
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Calendar" bundle:nil];
    CalendarViewController *cvc = [story instantiateViewControllerWithIdentifier:@"CalendarViewController"];
    [self.navigationController pushViewController:cvc animated:YES];
}

- (void)toSetting{
    VerifyPasswordViewController * viewController = [[VerifyPasswordViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)toConnectBrush
{
    ConnectingViewController* cvc = [[ConnectingViewController alloc] init];
    [self.navigationController pushViewController:cvc animated:YES];
}

#pragma mark - Getters 

- (NSMutableArray *)gloryList
{
    if(_gloryList == nil)
    {
        _gloryList = [[NSMutableArray alloc] init];
    }
    return _gloryList;
}

- (NSMutableArray *)giftList
{
    if(_giftList == nil)
    {
        _giftList = [[NSMutableArray alloc] init];
    }
    return _giftList;
}

#pragma mark - 历史遗留代码

- (IBAction)synchronize:(id)sender
{
    
}
//
//- (IBAction)settingButtonTouched:(id)sender {
//    IsParentViewController *ipvc = [[IsParentViewController alloc] init];
//    [self.view.window addSubview:ipvc.view];
//    [self.view.window sendSubviewToBack:self.view];
//}
- (IBAction)unwindSegue:(UIStoryboardSegue *)sender{
    
}

@end//  ViewController