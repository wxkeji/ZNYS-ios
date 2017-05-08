//
//  ToothBrushFindViewController.m
//  ZNYS
//
//  Created by 张恒铭 on 4/23/17.
//  Copyright © 2017 Woodseen. All rights reserved.
//

#import "ToothBrushFindViewController.h"
#import "ToothBrushManagentFindView.h"
#import "ToothBrushCollectionViewCell.h"
#import "ToothBrush+CoreDataClass.h"
#import "BluetoothServer.h"
#import "ZNYSPeripheral.h"
#import "ToothbrushManager.h"
#import "UserManager.h"
#import "User+CoreDataClass.h"

@interface ToothBrushFindViewController ()
@property (nonatomic, strong) ToothBrush *currentSelectedBrush;
@property (nonatomic, strong) NSMutableArray *toothBrushesArray;
@property (nonatomic, strong) ToothBrushManagentFindView *findView;
@end

@implementation ToothBrushFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ToothBrushManagentFindView *view = [[ToothBrushManagentFindView alloc] initWithFrame:CGRectMake(0, 0.298*kSCREEN_HEIGHT, kSCREEN_WIDTH, (1-0.298)*kSCREEN_HEIGHT)];
    view.bindedActionBlock = ^(UICollectionView *collectionView, NSIndexPath *indexpath) {
        
    };
    view.newToothbrushActionBlock = ^(UICollectionView *collectionView, NSIndexPath *indexPath) {
        
    };
    [view addSyncButton];
    self.findView = view;
    view.viewController = self;
    view.findNewToothBrushCollectionView.dataSource = self;
    view.babysToothBrushCollectionView.dataSource = self;
    [view.findNewToothBrushCollectionView reloadData];
    [view.babysToothBrushCollectionView reloadData];
    self.view.backgroundColor = [UIColor clearColor];
    
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT - view.height)];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBackgroundViewClicked)];
    [backgroundView addGestureRecognizer:tapGesture];
    
    [self.view addSubview:backgroundView];
    [self.view addSubview:view];
    
    
    self.toothBrushesArray = [NSMutableArray array];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[BluetoothServer defaultServer] scanWithCompletionBlock:^(NSArray<ZNYSPeripheral*>* peripherals) {
        for (ZNYSPeripheral *peripheral in peripherals) {
            if ([peripheral.advertiseName isEqualToString:@"Mita Brush"]) {
                ToothBrush *brush = [[ToothbrushManager sharedInstance] createInstance];
                brush.user = [UserManager sharedInstance].currentUser;
                brush.userUUID = [UserManager sharedInstance].currentUser.uuid;
                [self.toothBrushesArray addObject:brush];
            }
        }
        [self.findView.findNewToothBrushCollectionView reloadData];
    }];
}

- (void)dealloc {
    for (ToothBrush *toothbrush in self.toothBrushesArray) {
        [[CoreDataHelper sharedInstance].context deleteObject:toothbrush];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onBackgroundViewClicked  {
    NSLog(@"background clicked");
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - collection datasource related 

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
//    return 3;
    if (collectionView == self.findView.babysToothBrushCollectionView) {
        return 8;
    } else if (collectionView == self.findView.findNewToothBrushCollectionView) {
        return self.toothBrushesArray.count;
    }
    return 10;
}




- (UICollectionViewCell *)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (collectionView == self.findView.babysToothBrushCollectionView) {
        ToothBrushCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:bindBrushCellID forIndexPath:indexPath];
        if (!cell) {
            NSLog(@"no cell!");  
        }
        NSIndexPath* selectedIndexPath = self.findView.currentSelectedBindIndex;
        BOOL isIndexPathEqual = selectedIndexPath&&(indexPath.section == selectedIndexPath.section && indexPath.row == selectedIndexPath.row);
        if (!isIndexPathEqual || self.findView.selectedType != selectedCollectionViewTypeBinded) {
            [cell setBackgroundColor:cellOriginalColor];
        } else {
            [cell setBackgroundColor:cellSelectedColor];
        }
        return cell;
    } else if (collectionView == self.findView.findNewToothBrushCollectionView) {
        ToothBrushCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:findToothBrushCellID forIndexPath:indexPath];
        if (!cell) {
            NSLog(@"no cell!");
        }
        [cell setToothBrush:self.toothBrushesArray[indexPath.row]];
        NSIndexPath* selectedIndexPath = self.findView.currentSelectedBindIndex;
        BOOL isIndexPathEqual = selectedIndexPath&&(indexPath.section == selectedIndexPath.section && indexPath.row == selectedIndexPath.row);
        if (!isIndexPathEqual || self.findView.selectedType != selectedCollectionViewTypeNewFind) {
            [cell setBackgroundColor:cellOriginalColor];
        } else {
            [cell setBackgroundColor:cellSelectedColor];
        }
        return cell;

    }
    return nil;
    
    
}

@end
