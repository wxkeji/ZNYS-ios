//
//  AwardManager.h
//  ZNYS
//
//  Created by 张恒铭 on 4/27/16.
//  Copyright © 2016 Woodseen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Award.h"
#warning 这样把 Award 直接 import 进来，就会直接被调用，是否有问题？
#import "CoreDataHelper.h"

@interface AwardManager : NSObject
+ (instancetype)sharedInstance;
- (void)createWithAward:(Award*)award;
- (void)retrieveWithUUID:(NSString*)award;
- (void)updateAward:(Award*)award;
- (void)deleteAward:(Award*)award;


/**
 *  获取未添加的奖品
 *
 *  @param uuid 用户uuid
 *
 *  @return 返回一个数组（消费类，拥有类，活动类），然后每个数组包含每一类的model数组
 */
- (NSMutableArray <NSMutableArray<Award *> *>*)getNotAddedAwardWithUseruuid:(NSString*)uuid;


/**
 *  获取已添加的奖品
 *
 *  @param uuid 用户uuid
 *
 *  @return 返回一个数组（消费类，拥有类，活动类），然后每个数组包含每一类的model数组
 */
- (NSMutableArray <NSMutableArray<Award *> *>*)getAddedAwardWithUseruuid:(NSString*)uuid;


/**
 *  点击添加奖品按钮后，设置奖品的语音路径和金币数
 *
 *  @param uuid      奖品的uuid
 *  @param voicePath 语音路径
 *  @param coin      兑换的金币数
 *
 *  @return 返回是否添加成功
 */
- (BOOL)addAwardWithAwarduuid:(NSString*)uuid voicePath:(NSString*)voicePath coin:(int32_t)coin;


/**
 *  兑换奖品接口
 *
 *  @param awarduuid 奖品的uuid
 *
 *  @return 是否兑换成功
 */
- (BOOL)exchangeAwardWithAwarduuid:(NSString*)awarduuid;

/**
 *  删除奖品接口
 *
 *  @param awarduuid 奖品的uuid
 *
 *  @return 是否删除成功
 */
- (BOOL)deleteAwardWithAwardUUID:(NSString *)awarduuid;

/**
 *  获取用户全部已添加的奖品(不会按照)
 *
 *  @param userUUID 用户的UUid
 *
 *  @return 包含所有已添加奖品的model的数组
 */
- (NSMutableArray <Award *>*)getAllAddedAwardWithUseruuid:(NSString*)userUUID;
@end
