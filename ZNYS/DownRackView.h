//
//  DownRackView.h
//  ZNYS
//
//  Created by yu243e on 2017/4/26.
//  Copyright © 2017年 Woodseen. All rights reserved.
//

#import "ZNYSBaseView.h"
@protocol DownRackViewDataSource <NSObject>
- (NSUInteger)numberOfItemsInDownRack;
- (UIImage *)downRackItemImageAtIndex:(NSUInteger)index;
@end

@interface DownRackView : ZNYSBaseView
@property (nonatomic, weak) id<DownRackViewDataSource> datasource;
- (void)configureTheme;
- (void)reloadData;
@end
