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
#import "ItemStatusManagerFile.h"
#import "NSArray+ForceBound.h"
#import "DialogView.h"
#import "ToolMacroes.h"
#import "UILabel+Font.h"
#import "VerifyPasswordViewController.h"
#import "ConnectingViewController.h"
@interface CabinetViewController ()

#pragma mark - UI 控件的 Outlet —— 两个 ScrollView

@property (weak, nonatomic) IBOutlet UIScrollView *gloryScrollView;   //奖品柜上层，存放荣誉奖杯等
@property (weak,nonatomic) IBOutlet UIScrollView *bathItemScrollView; //奖品柜下层，存放浴室关键物件

#pragma mark - UI 控件的 Outlet —— 用户状态

@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *stars;//屏幕上显示的星星数
@property (weak, nonatomic) IBOutlet UIImageView *cartoonHead;  //奖品柜上的卡通人头。。它会根据性别显示蓝色这个或者粉红色的另一个
@property (weak, nonatomic) IBOutlet UILabel *level;

#pragma mark - UI 控件的 Outlet —— 按钮

@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
@property (weak, nonatomic) IBOutlet UIButton *calendarButton;
@property (weak, nonatomic) IBOutlet UIButton *connectToothBrushButton;

@property (weak, nonatomic) IBOutlet UIButton *bookButton;  //这个是日历按钮左边的按钮，看起来像一本书……

#pragma mark - UI 控件的 Outlet —— 通知中心、广告

@property (weak, nonatomic) IBOutlet UIImageView *ADBackroung;//广告位的背景图片
@property (weak, nonatomic) IBOutlet UIImageView *advertismentLabel;//广告位Label


//- (IBAction)settingButtonTouched:(id)sender;
@property (strong, nonatomic) UILabel *label;

#pragma mark -

@property UserData *giftStatusManager;
@property (strong,nonatomic) NSMutableDictionary *tagDict;   //保存tag的列表的词典
@property (strong,nonatomic) NSMutableArray *bathItemList;  //保存浴室标志性物品
@property (nonatomic,strong) NSMutableArray * gloryList;   //保存勋章物品

@end

@implementation CabinetViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initPageJumps];
    [self setupCabinet];

    [self.view layoutIfNeeded];
    
    //设置屏幕上的信息
    self.stars.text = [[NSString alloc] initWithFormat:@"%d",self.giftStatusManager.currentValidNumberOfStars];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self setItemScrollView:self.gloryScrollView
                   itemList:self.giftStatusManager.gloryItemList
                     height:self.gloryScrollView.frame.size.height
                      width:self.gloryScrollView.frame.size.width
               itemEachPage:4 selector:@selector(itemWasTouched:) tagListName:@"gloryItemTagList"
                   startTag:TAG_GLORY_ITEM];
    
    [self setItemScrollView:self.bathItemScrollView
                   itemList:self.bathItemList
                     height:self.bathItemScrollView.frame.size.height
                      width:self.bathItemScrollView.frame.size.width
               itemEachPage:4
                   selector:@selector(itemWasTouched:)
                tagListName:@"bathItemTagList" startTag:TAG_BATH_ITEM ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    
}

#pragma mark - 设置奖品柜的数据

- (void)setupCabinet
{
    //初始化tag字典
    self.tagDict = [[NSMutableDictionary alloc] init];
    
    //创建两个列表,添加若干小车到里面
    self.gloryList = [[NSMutableArray alloc] init];
    NSString *littleCar = @"小车_已兑换";
    for(int i = 1;i <= 30;i++)
    {
        ItemWithState *gloryItem = [[ItemWithState alloc] initWithItemName:@"littleCar"  imageName:littleCar];
        
        [self.gloryList addObject:gloryItem];
    }
    
    
   // NSArray *giftList = [self.gloryList copy];
    NSString *littleBasketball = @"小篮球_已兑换";
    self.bathItemList = [[NSMutableArray alloc] init];
    for(int i = 1;i <= 30;i++)
    {
        ItemWithState *bathItem = [[ItemWithState alloc] initWithItemName:@"littleBasketball"  imageName:littleBasketball];
        [self.bathItemList addObject:bathItem];
    }
    
    UserData *userData = [[UserData alloc] initWithCurrentValidNumbersOfStars:22 gloryItemList:self.gloryList bathItemList:self.bathItemList];
    self.giftStatusManager = userData;
}

- (void)setItemScrollView:(UIScrollView *)scrollView
                 itemList:(NSMutableArray *)giftList
                   height:(float)height
                    width:(float)width
             itemEachPage:(int)itemEachPage
                 selector:(SEL)selecor
              tagListName:(NSString *)tagListName
                 startTag:(long)startTag
{
    //根据奖品列表获得礼品柜的个数
    long n = ([giftList count] - 1) / itemEachPage + 1;
    
    [self initScrollView:scrollView
               WithWidth:width
                  height:height
               totalPage:n];
    
    //把奖品柜的宽度n等分
    CGFloat imgW = width / itemEachPage;
    
    NSMutableArray *tagList = [[NSMutableArray alloc] init];
    
    //在奖品柜视图里添加礼物的图片,并把对应的Tag保存在giftGridListTag里，然后为每一个奖品添加触摸手势
    for(int i=0;i<[giftList count];i++)
    {
        //从奖品管理器中获取第i个奖品
        ItemWithState *itemWithState = giftList[i];
        
        //创建一个button和imageView，用imageView作为button的子View
        UIButton *button = [[UIButton alloc] init];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:itemWithState.imageName];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        // nx 和 ny表示在 4 * 2 的奖品方阵中中的位置
        //根据奖品在奖品奖品列表中的位置i算出它在4 * 2方阵中的对应位置
        int nx,ny;
        nx = i;
        ny = 0;
        
        button.frame = [self getRectOfItemAt:(int)nx
                                   itemWidth:imgW
                                  scrollViewHeight:height];
        CGFloat buttonHeight = button.frame.size.height;
        imageView.frame = CGRectMake(0,buttonHeight / 5.0,imgW,3.0 / 5 * height);
        
        [button addSubview:imageView];
        
        //为button添加点击事件
        [button addTarget:self action:selecor forControlEvents:UIControlEventTouchUpInside];
        
        //把奖品button添加到奖品柜视图
        [scrollView addSubview:button];
        
        //设置button的tag，后面可以用tag找到对应的奖品
        button.tag = startTag + i;
        
        //把奖品的imageView的Tag添加到 gfitGridListTag 数组中
        [tagList addObject:[[NSNumber alloc] initWithLong:[button tag]]];
        
    }
    
     [self.tagDict setObject:tagList forKey:tagListName];

}

- (void)initScrollView:(UIScrollView *)scrollView
             WithWidth:(CGFloat)width
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


#pragma mark - 事件响应函数

//响应item的点击事件
- (void) itemWasTouched:(id)sender
{
    //获取这个item的tag
    long tag = [sender tag];
    
    //index表示这个item在item列表是第几个
    long index=-1;
    
    NSArray *keys = [self.tagDict allKeys];
    
    for(NSString *key in keys)
    {
        NSMutableArray * tagList = [self.tagDict objectForKey:key];
        unsigned long length = [tagList count];
        
        //通过Tag与 itemTagList 中的 tag 值一一比较从而确定当前被触摸的是第几个奖品
        for(int i=0;i<length;i++)
        {
            NSNumber *currentTag = tagList[i];
            if([currentTag longValue] == tag)
            {
                index = i;
                long indexOfScrollView = tag / 1000 - 1;
                //NSLog(@"Item %ld is touched.Tag is %ld.In scrollView %ld",index,tag,indexOfScrollView);
                
                NSString *itemName,*conditionToGet;
                ItemWithState *item;
                if(indexOfScrollView == 0)
                {
                     item= self.giftStatusManager.gloryItemList[index];
                }
                else
                {
                    item= self.bathItemList[index];
                }
                itemName = item.itemName;
                conditionToGet = [NSString stringWithFormat:@"得到%d颗星星",5];
                
                DialogView *dialogView = [DialogView instanceDialogViewWithItemName:itemName conditionToGet:conditionToGet];
                dialogView.alpha = 1.0;
                dialogView.frame = self.view.bounds;
                [self.view addSubview:dialogView];
                [self.view bringSubviewToFront:dialogView];
                NSLog(@"Subview added.");
                
                return;
            }
        }
    }
        
    NSLog(@"Tag not found");
}

#pragma mark - 页面跳转

- (void)initPageJumps
{
    [self.calendarButton addTarget:self action:@selector(toCalendar) forControlEvents:UIControlEventTouchUpInside];
    [self.settingsButton addTarget:self action:@selector(toSetting) forControlEvents:UIControlEventTouchUpInside];
    [self.connectToothBrushButton addTarget:self action:@selector(toConnectBrush) forControlEvents:UIControlEventTouchUpInside];
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