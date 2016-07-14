//
//  ToothBrushManagentFindView.h
//  ZNYS
//
//  Created by 张恒铭 on 7/14/16.
//  Copyright © 2016 Woodseen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZNYSBaseView.h"
#import "ToothBrushManagentMainView.h"

static NSString* const cellId = @"collectionViewCellIdentifier";
static NSString* const headerId = @"collectionViewHeaderIdentifier";
static NSString* const footerId = @"collectionViewFooterIdentifier";

typedef void(^BindToothBrushClickBlock)(UICollectionView* collectionView,NSIndexPath* indexPath);
typedef void(^NewFindToothBrushClickBlock)(UICollectionView* collectionView,NSIndexPath* indexPath);
typedef void (^SyncButtonAction)(UIButton* button);

typedef NS_ENUM(NSInteger,SelectedCollectionViewType) {
    selectedCollectionViewTypeBinded,
    selectedCollectionViewTypeNewFind
};
@protocol FindViewControllerProtocol <NSObject>



@end

@interface ToothBrushManagentFindView : ZNYSBaseView
/**
 *  已绑定的牙刷CollectionView 点击回调
 */
@property (nonatomic,copy) BindToothBrushClickBlock bindedActionBlock;
/**
 *  新发现的牙刷CollectionView 点击回调
 */
@property(nonatomic,copy) NewFindToothBrushClickBlock  newToothbrushActionBlock;

/**
 *  同步数据按钮点击回调
 */
@property(nonatomic,copy) SyncButtonAction syncButtonActionBlock;


@property(nonatomic,assign)SelectedCollectionViewType selectedType;

@property(nonatomic,weak) id<FindViewControllerProtocol> viewController;

/**
 *  如果是从主页面中弹出来的，那么要添加同步按钮
 */
-(void)addSyncButton;
-(void)enableSyncButton;
-(void)disableSyncButton;
@property(nonatomic,weak) NSIndexPath* currentSelectedBindIndex;
@property(nonatomic,weak) NSIndexPath* currentSelectedNewFindIndex;



@end
