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


static NSString* const cellId = @"collectionViewCellIdentifier";
static NSString* const headerId = @"collectionViewHeaderIdentifier";
static NSString* const footerId = @"collectionViewFooterIdentifier";

@interface ToothBrushManagentFindView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView* babysToothBrushCollectionView;
@property (nonatomic,strong) UICollectionView* findNewToothBrushCollectionView;

@property(nonatomic,strong) CollectionViewLayout* linearLayout;


@property (nonatomic,strong) UILabel* babysToothBrushHintLabel;
@property (nonatomic,strong) UILabel* findNewToothBrushHintLabel;

@end
@implementation ToothBrushManagentFindView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    [self setBackgroundColor:[UIColor whiteColor]];
    
    [self addSubview:self.babysToothBrushCollectionView];
    
    [self addSubview:self.findNewToothBrushCollectionView];
    return self;
}



#pragma mark - collectionveiw datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 5;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ToothBrushCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    

    
    
    
    return cell;
}

// 和UITableView类似，UICollectionView也可设置段头段尾
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    if([kind isEqualToString:UICollectionElementKindSectionHeader])
//    {
//        UICollectionReusableView *headerView = [self.babysToothBrushCollectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
//        if(headerView == nil)
//        {
//            headerView = [[UICollectionReusableView alloc] init];
//        }
//        headerView.backgroundColor = [UIColor grayColor];
//        
//        return headerView;
//    }
//    else if([kind isEqualToString:UICollectionElementKindSectionFooter])
//    {
//        UICollectionReusableView *footerView = [self.babysToothBrushCollectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerId forIndexPath:indexPath];
//        if(footerView == nil)
//        {
//            footerView = [[UICollectionReusableView alloc] init];
//        }
//        footerView.backgroundColor = [UIColor lightGrayColor];
//        
//        return footerView;
//    }
//    
//    return nil;
//}


#pragma mark - getters
- (UICollectionView *)babysToothBrushCollectionView {
	if(_babysToothBrushCollectionView == nil) {
        _babysToothBrushCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 30, kSCREEN_WIDTH, 200) collectionViewLayout:self.linearLayout];
        [_babysToothBrushCollectionView setBackgroundColor:[UIColor whiteColor]];
//        _babysToothBrushCollectionView.collectionViewLayout = self.linearLayout;
        _babysToothBrushCollectionView.delegate = self;
        _babysToothBrushCollectionView.dataSource = self;
        

        [_babysToothBrushCollectionView registerClass:[ToothBrushCollectionViewCell class] forCellWithReuseIdentifier:cellId];
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
	if(_findNewToothBrushCollectionView == nil) {
		_findNewToothBrushCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds) - 200 - 30, kSCREEN_WIDTH, 200) collectionViewLayout:self.linearLayout];
        
        [_findNewToothBrushCollectionView setBackgroundColor:[UIColor whiteColor]];
        //        _babysToothBrushCollectionView.collectionViewLayout = self.linearLayout;
        _findNewToothBrushCollectionView.delegate = self;
        _findNewToothBrushCollectionView.dataSource = self;
        
        
        [_findNewToothBrushCollectionView registerClass:[ToothBrushCollectionViewCell class] forCellWithReuseIdentifier:cellId];
        [_findNewToothBrushCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
        [_findNewToothBrushCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
	}
	return _findNewToothBrushCollectionView;
}

@end
