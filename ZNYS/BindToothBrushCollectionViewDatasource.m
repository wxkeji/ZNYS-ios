//
//  BindToothBrushCollectionViewDatasource.m
//  ZNYS
//
//  Created by 张恒铭 on 7/14/16.
//  Copyright © 2016 Woodseen. All rights reserved.
//

#import "BindToothBrushCollectionViewDatasource.h"
#import "ToothBrushCollectionViewCell.h"
#import "ToothBrushManagentFindView.h"
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


@end
