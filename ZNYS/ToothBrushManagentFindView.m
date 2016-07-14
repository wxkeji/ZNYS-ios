//
//  ToothBrushManagentFindView.m
//  ZNYS
//
//  Created by 张恒铭 on 7/14/16.
//  Copyright © 2016 Woodseen. All rights reserved.
//

#import "ToothBrushManagentFindView.h"
#import "CollectionViewLayout.h"
@interface ToothBrushManagentFindView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView* babysToothBrushCollectionView;
@property (nonatomic,strong) UICollectionView* findNewToothBrushCollectionView;

@property(nonatomic,strong) CollectionViewLayout* linearLayout;

@end
@implementation ToothBrushManagentFindView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    [self addSubview:self.babysToothBrushCollectionView];
    
    
    return self;
}


#pragma mark - getters
- (UICollectionView *)babysToothBrushCollectionView {
	if(_babysToothBrushCollectionView == nil) {
		_babysToothBrushCollectionView = [[UICollectionView alloc] init];
        _babysToothBrushCollectionView.collectionViewLayout = self.linearLayout;
        _babysToothBrushCollectionView.delegate = self;
        _babysToothBrushCollectionView.dataSource = self;
	}
	return _babysToothBrushCollectionView;
}

- (CollectionViewLayout *)linearLayout {
	if(_linearLayout == nil) {
		_linearLayout = [[CollectionViewLayout alloc] init];
	}
	return _linearLayout;
}
@end
