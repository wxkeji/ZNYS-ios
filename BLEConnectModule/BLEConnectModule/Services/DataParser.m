//
//  DataParser.m
//  bluetoothUnitTest
//
//  Created by 张恒铭 on 15/7/31.
//  Copyright © 2015年 张恒铭. All rights reserved.
//

#import "DataParser.h"

@implementation NSString(Extraction)
-(NSNumber*) hexToDecimal: (NSString*)string//An extration to NSString, aims to getting decimal format of result;
{
    unsigned long temp = strtoul([string UTF8String],0,16);
    NSNumber* result = [NSNumber numberWithLong:temp];
    return result;
}
@end

@interface DataParser()

+(long long)parseLongFromHexByte:(Byte*)data startIndex:(int)startIndex;

@end

@implementation NSMutableArray(Extention)
-(void)addLong:(long)longNumber
{
    [self addObject:[NSNumber numberWithLong:longNumber]];
}
-(void)addInt:(int)intNumber
{
    [self addObject:[NSNumber numberWithInt:intNumber]];
}
-(void)replaceInt:(int)number with:(NSUInteger)index
{
    [self replaceObjectAtIndex:index   withObject:[NSNumber numberWithInt:number]];
}
-(void)reaplaceLong:(long)number with:(NSUInteger)index
{
    [self replaceObjectAtIndex:index   withObject:[NSNumber numberWithLong:number]];
}
-(int)retrieveInt:(int)index
{
    return [[self objectAtIndex:index]intValue];
}
-(long)retrieveLong:(NSUInteger)index
{
    return [[self objectAtIndex:index]longValue];
}
@end

@implementation DataParser

#pragma mark - Pretreatment Methods

+(long long)parseLongFromHexByte:(Byte*)data startIndex:(int)startIndex
{
    long long result = ( ((data[startIndex+3]&0xffLL) << 24)+((data[startIndex+2]&0xffLL)<<16)+((data[startIndex+1]&0xffLL)<<8)+(data[startIndex]&0xffLL) );
    if (result > (1LL << 31))
    {
        result -= (1LL << 32);
    }
    return result;
}
+(int*)parseIntFromHexByte:(Byte*)data startIndex:(int)startIndex
{//the alogrithm?
     int  *result = (int*)malloc(3*sizeof(int));
//    result[0] =  ( (data[startIndex + 1] & 0x1f) << 8 ) + (data[startIndex]&0xff) ;
//    result[1] =  ( (data[startIndex + 3] & 0x03) << 11) + ((data[startIndex + 2] & 0xff) << 3 ) + (data[startIndex + 1] & 0xE0);
    
    //这里有个非常有趣的问题，根据协议，( (data[startIndex + 1] & 0x1f) << 8 ) + (data[startIndex]&0xff)应该是x轴的加速度，而在实际开发过程中我发现其实它是y轴的加速度，y轴加速度的道理也一样 by Eric Cheung
    
    
    result[1] =  ( (data[startIndex + 1] & 0x1f) << 8 ) + (data[startIndex]&0xff) ;
    result[0] =  ( (data[startIndex + 3] & 0x03) << 11) + ((data[startIndex + 2] & 0xff) << 3 ) + (data[startIndex + 1] & 0xE0);

    result[2] =  ((data[startIndex + 4] & 0x7f) << 6) + (data[startIndex + 3] & 0xfc) ;
    for (int i = 0; i<3 ; i++)
    {
        if (result[i] > 4096)
        {
            result[i] -= ( 1<<13 );
        }
    }
    return result;
}
#pragma mark - public APIS
+(NSString*)parseRTC:(NSData*)data is32Bit:(BOOL)is32Bit
{
    Byte* temp = (Byte*)[data bytes];
    long int result = 0;
    if(is32Bit)
    {
    result = ((temp[3]&0xff) << 24)+((temp[2]&0xff)<<16)+((temp[1]&0xff)<<8)+(temp[0]&0xff);
    }
    else
    {
    result =((temp[3]&0x3f) << 24)+((temp[2]&0xff)<<16)+((temp[1]&0xff)<<8)+(temp[0]&0xff);
    }
    return [NSString stringWithFormat:@"%ld",result/10];
}
+(int)parseBattery:(NSData *)data
{
    Byte* temp   = (Byte*)[data bytes];
    int   result = temp[0]&0xff;
    return result;
}
+(AccelerationPackage*) parseAcceleration:(NSData*)data;
{
    AccelerationPackage* temp       = [[AccelerationPackage alloc] init];
    NSMutableArray*      tempResult = [[NSMutableArray alloc]init];
    Byte* bytes = (Byte*)[data bytes];
    for (int j = 0 ; j < 3 ; j++)
    {
        int* acceleration = [self parseIntFromHexByte:bytes startIndex:j * 5 + 4];
        for (int i = 0; i < 3 ; i++)
        {
            [tempResult addInt:acceleration[i]];
        }
        [temp.data addObject:[NSArray arrayWithArray:tempResult]];
        [tempResult removeAllObjects];
    }
    temp.timeStamp = (long)[[self parseRTC:data is32Bit:NO] longLongValue];
    temp.pressure  = (double) (bytes[19]&0xff)/0xff*1.2;
    return temp;
}
+(QuaternionPackage*) parseQuaternion:(NSData*)data
{
    QuaternionPackage* temp = [[QuaternionPackage alloc] init];
    temp.timeStamp = (long)[[self parseRTC:data is32Bit:NO] longLongValue];
    Byte* hexBytes = (Byte*)[data bytes];
    for (int i =  0; i < 4; i++)
    {
        [temp.data addObject:[NSNumber numberWithLongLong:[self parseLongFromHexByte:hexBytes startIndex:(i+1)*4]]];
    }
    return temp;
}
+(int)parseDataType:(NSData*)data
{
    Byte* temp = (Byte*)[data bytes];
    if (temp[3] & 0x40)
        return 1;//Quaternion
        return 0;//Acceleration
}
@end