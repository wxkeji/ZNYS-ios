//
//  ToothBrush+CoreDataProperties.m
//  
//
//  Created by 张恒铭 on 4/18/17.
//
//

#import "ToothBrush+CoreDataProperties.h"

@implementation ToothBrush (CoreDataProperties)

+ (NSFetchRequest<ToothBrush *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ToothBrush"];
}

@dynamic bindTime;
@dynamic lastConnectTime;
@dynamic macAddress;
@dynamic nickname;
@dynamic photoNumber;
@dynamic toothbrushID;
@dynamic userUUID;
@dynamic brushingStatistic;
@dynamic user;

@end
