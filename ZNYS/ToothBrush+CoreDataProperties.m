//
//  ToothBrush+CoreDataProperties.m
//  
//
//  Created by yu243e on 2017/4/12.
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
@dynamic bePossessedByUser;
@dynamic possessBrushingStatistics;

@end
