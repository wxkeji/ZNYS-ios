//
//  CollectionViewLayout.m
//  ZNYS
//
//  Created by 张恒铭 on 7/13/16.
//  Copyright © 2016 Woodseen. All rights reserved.
//


#define itemWidth CustomWidth(180)
#define itemHeight CustomHeight(130)

#import "CollectionViewLayout.h"
#import "ToolMacroes.h"
@implementation CollectionViewLayout

-(instancetype)init {
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.itemSize = CGSizeMake(itemWidth, itemHeight);
        self.minimumLineSpacing = CustomWidth(10);
        self.minimumInteritemSpacing = CustomWidth(10);
//        self.sectionInset = UIEdgeInsetsMake(CustomWidth(10),CustomWidth(10),CustomWidth(10), CustomWidth(10));

    }
    return self;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attributes = [NSMutableArray array];
    for(NSInteger i=0 ; i < self.collectionView.numberOfSections; i++) {
        for (NSInteger j=0 ; j < [self.collectionView numberOfItemsInSection:i]; j++) {
            NSIndexPath* indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
        }
    }
    return attributes;
}
@end
