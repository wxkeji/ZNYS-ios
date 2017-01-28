//
//  FindNewToothBrushCollectionviewDatasource.m
//  ZNYS
//
//  Created by 张恒铭 on 7/14/16.
//  Copyright © 2016 Woodseen. All rights reserved.
//

#import "FindNewToothBrushCollectionviewDatasource.h"
#import "ToothBrushCollectionViewCell.h"
#import "ToothbrushManager.h"
@implementation FindNewToothBrushCollectionviewDatasource
+(instancetype)sharedInstance {
    static FindNewToothBrushCollectionviewDatasource* instance;
    if (!instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [[FindNewToothBrushCollectionviewDatasource alloc] init];
        });
    }
    return instance;
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
    
    
    //因为Cell重用的问题，这里要确认显示出来的cell如果不是选中的index，就保持原有背景色
    NSIndexPath* selectedIndexPath = self.findView.currentSelectedNewFindIndex;
    BOOL isIndexPathEqual = selectedIndexPath && (indexPath.section == selectedIndexPath.section && indexPath.row == selectedIndexPath.row);
    if (!isIndexPathEqual || self.findView.selectedType != selectedCollectionViewTypeNewFind) {
        [cell setBackgroundColor:cellOriginalColor];
    } else {
        [cell setBackgroundColor:cellSelectedColor];
    }
    
    
    return cell;
}



@end
