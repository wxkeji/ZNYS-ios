//
//  TopRackView.m
//  ZNYS
//
//  Created by yu243e on 2017/4/23.
//  Copyright © 2017年 Woodseen. All rights reserved.
//

#import "TopRackView.h"
#import "TopRackViewCell.h"
@interface TopRackView()<UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation TopRackView

static NSString *cellIdentifier = @"topRackCell";

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self.collectionView registerClass:[TopRackViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        
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
    return [self.datasource numberOfItemsInTopRack];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TopRackViewCell *cell = (TopRackViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell.medalImageView setImage:[self.datasource topRackItemImageAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - public methods
- (void)configureTheme {
    self.tintColor = [UIColor colorWithThemedImageNamed:@"color/primary_dark"];
}

- (void)reloadData {
    [self.collectionView reloadData];
}
#pragma mark - getters and setters
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(60, 60);
        layout.minimumInteritemSpacing = 0;
        //6p:68 6:50 se:25
        layout.minimumLineSpacing = ZNYSGetSizeByWidth(25, 50, 68);
        layout.sectionInset = UIEdgeInsetsMake(30, 0, 10, 0);

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        
        _collectionView.pagingEnabled = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}
@end
