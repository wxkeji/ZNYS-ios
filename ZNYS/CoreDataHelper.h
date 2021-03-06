//
//  CoreDataHelper.h
//  ZNYS
//
//  Created by 张恒铭 on 12/16/15.
//  Copyright © 2015 Woodseen. All rights reserved.
//

#define debug 1//1 for opening debug mode(output logs) 0 fot closing
#define checkDatabase 1//如果想查看数据库里的内容，把它设置为1，否则设置为0

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ToothBrush+CoreDataClass.h"
@class Award;

@interface CoreDataHelper :NSObject
@property (nonatomic, readonly) NSManagedObjectContext* context;
@property (nonatomic, readonly) NSManagedObjectModel* model;
@property (nonatomic, readonly) NSPersistentStoreCoordinator* coordinator;
@property (nonatomic, readonly) NSPersistentStore *store;
+ (instancetype)sharedInstance;
//- (void)setupCoreData;
- (void)loadStore;
- (void)save;
//对于Core Data里的实体类，请勿直接用 [[Class alloc]init]的方法生成实例。若要获取新的实例，请调用createXX方法，或者用retrieveXXX的方法来获取已经存储的实例。predicate参数指定筛选条件，若将全部数据取出，设置其为Nil，在NSArray中返回数据库中得所有实例。


- (Award*)createAward;
- (Award*)createNewAwardWithAward:(Award*)award;
-(NSArray*)retrieveAwardsWithPredicate:(NSPredicate*)predicate;


- (ToothBrush*)createToothBrush;
- (NSArray*)retrieveToothBrushWithPredicate:(NSPredicate*)predicate;
@end
