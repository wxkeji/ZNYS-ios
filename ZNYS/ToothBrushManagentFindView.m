//
//  ToothBrushManagentFindView.m
//  ZNYS
//
//  Created by 张恒铭 on 7/14/16.
//  Copyright © 2016 Woodseen. All rights reserved.
//

#import "ToothBrushManagentFindView.h"
#import "CollectionViewLayout.h"
#import "ToothBrushCollectionViewCell.h"
#import "BindToothBrushCollectionViewDatasource.h"
#import "FindNewToothBrushCollectionviewDatasource.h"



@interface ToothBrushManagentFindView()<UICollectionViewDelegate,UICollectionViewDataSource>



@property(nonatomic,strong) CollectionViewLayout* linearLayout;



@property(nonatomic,strong) BindToothBrushCollectionViewDatasource* bindedDataSouce;

@property(nonatomic,strong) FindNewToothBrushCollectionviewDatasource* foundDataSouce;


@property (nonatomic,strong) UILabel* babysToothBrushHintLabel;
@property (nonatomic,strong) UILabel* findNewToothBrushHintLabel;

@property (nonatomic,strong) UIButton* syncButton;

@end
@implementation ToothBrushManagentFindView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.bindedDataSouce = [BindToothBrushCollectionViewDatasource sharedInstance];
    self.foundDataSouce = [FindNewToothBrushCollectionviewDatasource sharedInstance];
    self.bindedDataSouce.findView = self;
    self.foundDataSouce.findView = self;
    [self setBackgroundColor:[UIColor whiteColor]];
    
    [self addSubview:self.babysToothBrushCollectionView];
    
    [self addSubview:self.findNewToothBrushCollectionView];
    
    
    [self addSubview:self.babysToothBrushHintLabel];
    [self addSubview:self.findNewToothBrushHintLabel];
    
    
    [self addConstraints];
    
    

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame viewController:(UIViewController *)viewController {
    self = [self initWithFrame:frame];
    self.viewController = viewController;
    return self;
}


- (void)addConstraints {
    WS(weakSelf, self);
    [self.babysToothBrushHintLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10);
        make.top.equalTo(weakSelf.mas_top).with.offset(10);
    }];
//    
//    [self.babysToothBrushCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf.mas_left);
//        make.right.equalTo(weakSelf.mas_right);
//        make.height.equalTo(@(CustomHeight(150)));
//        make.top.equalTo(weakSelf.babysToothBrushHintLabel.mas_bottom).with.offset(10);
//    }];
//
    [self.findNewToothBrushHintLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        make.left.equalTo(weakSelf.babysToothBrushHintLabel);
        //make.bottom.equalTo(weakSelf.findNewToothBrushCollectionView.mas_top).with.offset(-10);
        make.top.equalTo(weakSelf.babysToothBrushCollectionView.mas_bottom).with.offset(10);
    }];
    
//    [self.findNewToothBrushCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.findNewToothBrushHintLabel.mas_bottom).offset(10);
//        make.height.equalTo(@(CustomHeight(150)));
//        make.left.equalTo(weakSelf.mas_left);
//        make.right.equalTo(weakSelf.mas_right);
//    }];
    

    
}

- (void)addSyncButton {
    [self addSubview:self.syncButton ];
}
-(void)enableSyncButton {
    [self.syncButton setBackgroundColor:cellOriginalColor];
    self.syncButton.userInteractionEnabled = YES;
}
-(void)disableSyncButton {
    [self.syncButton setBackgroundColor:[UIColor grayColor]];
    self.syncButton.userInteractionEnabled = NO;
}
-(void)onSyncButtonClicked:(UIButton*)button {
    if (self.syncButtonActionBlock) {
        self.syncButtonActionBlock(button);
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *selectedCell = [collectionView cellForItemAtIndexPath:indexPath];
    [selectedCell setBackgroundColor:cellSelectedColor];
    
    UICollectionViewCell *previousSelectedCell;
    
    
    
    if (collectionView == self.babysToothBrushCollectionView) {
        if (self.bindedActionBlock) {
            self.bindedActionBlock(collectionView,indexPath);
        }
        self.currentSelectedBindIndex = indexPath;
        [[self.findNewToothBrushCollectionView cellForItemAtIndexPath:self.currentSelectedNewFindIndex] setBackgroundColor:cellOriginalColor];
//        [self.findNewToothBrushCollectionView reloadItemsAtIndexPaths:@[self.currentSelectedNewFindIndex]];
        self.selectedType = selectedCollectionViewTypeBinded;
    } else if(collectionView == self.findNewToothBrushCollectionView){
        if (self.newToothbrushActionBlock) {
            self.newToothbrushActionBlock(collectionView,indexPath);
        }
        
        self.currentSelectedNewFindIndex = indexPath;
        self.currentSelectedBindIndex = indexPath;
        [[self.babysToothBrushCollectionView cellForItemAtIndexPath:self.currentSelectedBindIndex] setBackgroundColor:cellOriginalColor];
//        [self.babysToothBrushCollectionView reloadItemsAtIndexPaths:@[self.currentSelectedBindIndex]];
        self.selectedType = selectedCollectionViewTypeNewFind;
    }
    [self.findNewToothBrushCollectionView reloadData];
    [self.babysToothBrushCollectionView reloadData];

}


#pragma mark - getters
- (UICollectionView *)babysToothBrushCollectionView {
	if(!_babysToothBrushCollectionView ) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(CustomWidth(180), CustomHeight(130));
        
        
        _babysToothBrushCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 30, kSCREEN_WIDTH, CustomHeight(150)) collectionViewLayout:layout];
//        _babysToothBrushCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 30, kSCREEN_WIDTH, CustomHeight(150))];
//        _babysToothBrushCollectionView.collectionViewLayout = self.linearLayout;
        [_babysToothBrushCollectionView setBackgroundColor:[UIColor whiteColor]];
//        _babysToothBrushCollectionView.collectionViewLayout = self.linearLayout;
        _babysToothBrushCollectionView.delegate = self;
//        _babysToothBrushCollectionView.dataSource = self.bindedDataSouce;
        _babysToothBrushCollectionView.dataSource = self.viewController;
        [_babysToothBrushCollectionView registerClass:[ToothBrushCollectionViewCell class] forCellWithReuseIdentifier:bindBrushCellID];
        [_babysToothBrushCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
        [_babysToothBrushCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
	}
    return _babysToothBrushCollectionView;
}

- (CollectionViewLayout *)linearLayout {
	if(_linearLayout == nil) {
		_linearLayout = [[CollectionViewLayout alloc] init];
        
	}
	return _linearLayout;
}

- (UILabel *)babysToothBrushHintLabel {
    if(_babysToothBrushHintLabel == nil) {
        _babysToothBrushHintLabel = [[UILabel alloc] initWithCustomFont:15.0f];
        _babysToothBrushHintLabel.text = @"宝宝的牙刷";
        [_babysToothBrushHintLabel setTextColor:[UIColor grayColor]];
    }
    return _babysToothBrushHintLabel;
}

- (UILabel *)findNewToothBrushHintLabel {
    if(_findNewToothBrushHintLabel == nil) {
        _findNewToothBrushHintLabel = [[UILabel alloc] initWithCustomFont:15.0f];
        _findNewToothBrushHintLabel.text = @"新发现的牙刷";
        [_findNewToothBrushHintLabel setTextColor:[UIColor grayColor]];
    }
    return _findNewToothBrushHintLabel;
}

- (UICollectionView *)findNewToothBrushCollectionView {
	if(!_findNewToothBrushCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(CustomWidth(180), CustomHeight(130));
		_findNewToothBrushCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds) - 200 - 30, kSCREEN_WIDTH, CustomHeight(150)) collectionViewLayout:layout];
//        _findNewToothBrushCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds) - 200 - 30, kSCREEN_WIDTH, CustomHeight(150))];
//        _findNewToothBrushCollectionView.collectionViewLayout = self.linearLayout;
        [_findNewToothBrushCollectionView setBackgroundColor:[UIColor whiteColor]];
        //        _babysToothBrushCollectionView.collectionViewLayout = self.linearLayout;
        _findNewToothBrushCollectionView.delegate = self;
        _findNewToothBrushCollectionView.dataSource = self.foundDataSouce;

        
        [_findNewToothBrushCollectionView registerClass:[ToothBrushCollectionViewCell class] forCellWithReuseIdentifier:findToothBrushCellID];
        [_findNewToothBrushCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
        [_findNewToothBrushCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
	}
	return _findNewToothBrushCollectionView;
}

- (UIButton *)syncButton {
	if(_syncButton == nil) {
		_syncButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_syncButton setFrame:CGRectMake(CGRectGetWidth(self.frame)/2 - CustomWidth(350)/2, CGRectGetHeight(self.frame) - CustomHeight(45) - 10, CustomWidth(350), CustomHeight(45))];
        _syncButton.layer.cornerRadius = 8.0f;
        [_syncButton setBackgroundColor:[UIColor grayColor]];
        [_syncButton addTarget:self action:@selector(onSyncButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _syncButton.selected = NO;
        [_syncButton setTitle:@"同步数据" forState:UIControlStateNormal];
	}
	return _syncButton;
}

@end
