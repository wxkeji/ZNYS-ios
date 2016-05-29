//
//  Award+CoreDataProperties.h
//  ZNYS
//
//  Created by 张恒铭 on 4/24/16.
//  Copyright © 2016 Woodseen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Award.h"




NS_ASSUME_NONNULL_BEGIN

@interface Award (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *awardDescription;
@property (nullable, nonatomic, retain) NSString *exchangeData;
@property (nullable, nonatomic, assign) NSUInteger *id;
@property (nullable, nonatomic, assign) NSUInteger *level;
@property (nullable, nonatomic, retain) NSString *name;




/**
 *  奖品图片文件的名字
 */
@property (nullable, nonatomic, retain) NSString *pitcureURL;
/**
 *  默认的兑换金币数
 */
@property (nullable, nonatomic, assign) NSUInteger *price;
/**
 *  最小金币数
 */
@property (nullable, nonatomic, assign) NSUInteger *minPrice;
/**
 *  最大金币数
 */
@property (nullable, nonatomic, assign) NSUInteger *maxPrice;

/**
 *  对应且只有,已添加和未添加@"added",@"notAdded"
 */
@property (nullable, nonatomic, retain) NSString *status;
/**
 *  奖品类型，@"consume",@"possess",@"activity"，对应消费类，拥有类，huodonglei
 */
@property (nullable, nonatomic, retain) NSString *type;
/**
 *  奖品对应的用户UUID
 */
@property (nullable, nonatomic, retain) NSString *userID;
/**
 *  奖品的UUID
 */
@property (nullable, nonatomic, retain) NSString *uuid;

/**
 *  奖品的录音文件的路径
 */
@property (nullable, nonatomic, retain) NSString *voice;


@property (nullable, nonatomic, assign) NSUInteger *priority;

@property (nullable, nonatomic, retain) User *bePossessedByUser;

@end

NS_ASSUME_NONNULL_END
