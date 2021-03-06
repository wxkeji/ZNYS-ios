//
//  TopRackView.h
//  ZNYS
//
//  Created by yu243e on 2017/4/23.
//  Copyright © 2017年 Woodseen. All rights reserved.
//

#import "ZNYSBaseView.h"
@protocol TopRackViewDataSource <NSObject>
- (NSUInteger)numberOfItemsInTopRack;
- (UIImage *)topRackItemImageAtIndex:(NSUInteger)index;
@end

@interface TopRackView : ZNYSBaseView

@property (nonatomic, weak) id<TopRackViewDataSource> datasource;
- (void)configureTheme;
- (void)reloadData;

@end
