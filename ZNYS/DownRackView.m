//
//  DownRackView.m
//  ZNYS
//
//  Created by yu243e on 2017/4/26.
//  Copyright © 2017年 Woodseen. All rights reserved.
//

#import "DownRackView.h"
#import "DownRackViewCell.h"

@interface DownRackView ()<UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation DownRackView
static NSString *cellIdentifier = @"downRackCell";

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self.collectionView registerClass:[DownRackViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        
        [self addSubview:self.collectionView];
        
        [self setupConstraintsForSubviews];
    }
    return self;
}

- (void)setupConstraintsForSubviews {
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.datasource numberOfItemsInDownRack];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DownRackViewCell *cell = (DownRackViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell.awardImageView setImage:[self.datasource downRackItemImageAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - public methods
- (void)reloadData {
    [self.collectionView reloadData];
}

- (void)configureTheme {
    self.tintColor = [UIColor colorWithThemedImageNamed:@"color/primary_dark"];
}

#pragma mark - getters and setters
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(ZNYSGetSizeByWidth(80,100,100), ZNYSGetSizeByWidth(80,100,100));
        layout.minimumInteritemSpacing = 0;
        
        layout.minimumLineSpacing = ZNYSGetSizeByWidth(20, 19, 37);
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 8, 0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        
        _collectionView.pagingEnabled = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

@end
