//
//  BindToothBrushCollectionViewDatasource.m
//  ZNYS
//
//  Created by 张恒铭 on 7/14/16.
//  Copyright © 2016 Woodseen. All rights reserved.
//

#import "BindToothBrushCollectionViewDatasource.h"
#import "ToothBrushCollectionViewCell.h"
#import "ToothbrushManager.h"
@implementation BindToothBrushCollectionViewDatasource

+(instancetype)sharedInstance {
    static BindToothBrushCollectionViewDatasource* instance;
    if (!instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [[BindToothBrushCollectionViewDatasource alloc] init];
        });
    }
    return instance;
}

#pragma mark - collectionveiw datasource
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    
//    return 1;
//}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"current index %@, collectionView is %@",indexPath,collectionView);
    
    ToothBrushCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:bindBrushCellID forIndexPath:indexPath];
    NSIndexPath* selectedIndexPath = self.findView.currentSelectedBindIndex;
    BOOL isIndexPathEqual = selectedIndexPath&&(indexPath.section == selectedIndexPath.section && indexPath.row == selectedIndexPath.row);
    if (!isIndexPathEqual || self.findView.selectedType != selectedCollectionViewTypeBinded) {
        [cell setBackgroundColor:cellOriginalColor];
    } else {
        [cell setBackgroundColor:cellSelectedColor];
    }
    
    return cell;
}


@end
