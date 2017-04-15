//
//  AreaGroup.m
//  bluetoothUnitTest
//
//  Created by 张恒铭 on 10/12/15.
//  Copyright © 2015 张恒铭. All rights reserved.
//
//The operation on areas is based on linked list
#import "AreaGroup.h"
#pragma mark - private variables and method
@interface AreaGroup()
@property Area* head;
@property Area* rear;
@property int count;

-(void)deleteArea:(Area*)area;
//-(BOOL) needSeparated:(int)oldAmplitude newAmplitude:(int)newAmplitude;
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
@end
@implementation AreaGroup
-(instancetype)init
{
    self = [super init];
    self.head = nil;
    self.rear = nil;
    self.count = 0;
    return self;
}
-(int)getAreaNumber
{
    return self.count;
}
-(long)getStartTime
{
    return self.head.startTime;
}
-(long)getEndTime
{
    return self.rear.endTime;
}

-(void)add:(long)timeStamp amplitude:(int)amplitude
{
    if (self.head == nil)
    {
        _head = [[Area alloc] init];
        _head.type = unknown;
        _head.startTime = timeStamp;
        _head.endTime = timeStamp;
        [_head.amplitudeVector addObject:[NSNumber numberWithInt:amplitude]];
        self.rear = self.head;
        self.count++;
    }
    else if(![self needSeparated: [self.rear.amplitudeVector.lastObject intValue] newAmplitude:amplitude])
        //BE CAREFUL OF TYPE OF self.rear.amplitudeVector.lastObject!!!
    {//不需要分离，该刷牙区域添加新的数据
        self.rear.endTime = timeStamp;
        [self.rear.amplitudeVector addInt:amplitude];
    }
    else
    {//添加新的区域
        self.rear.next = [[Area alloc]init];
        self.rear = self.rear.next;
        self.rear.type = unknown;
        self.rear.startTime = timeStamp;
        self.rear.endTime = timeStamp;
        [self.rear.amplitudeVector addInt:amplitude];
        self.rear.next = nil;
        self.count++;
    }
}
//Because the compiler cannot know what type the last object is before running, so
-(BOOL)needSeparated:(int)oldAmplitude newAmplitude:(int)newAmplitude;//private method
{
  //  int oldAmplitude = [oldAmplitudeObject intValue];
    oldAmplitude = abs(oldAmplitude);
    newAmplitude = abs(newAmplitude);
    if( oldAmplitude == 0 || newAmplitude == 0 )
        return YES;
    if(oldAmplitude > newAmplitude)
    {
        return (int)(oldAmplitude/newAmplitude)  >= SEPARATED_RATIO;
    }
    else
    {
        return (int)(newAmplitude / oldAmplitude) >= SEPARATED_RATIO;
    }
}
-(Area*)getArea:(int)index
{
    //should we exam that whether the index is larger than count of area linked list?
    Area* p = self.head;
    if(p==nil)
    {
        return nil;
    }
    for(int i= 0 ; i < index; i++)
    {
        p = p.next;
    }
    return p;
}
-(void)deleteUselessArea
{
    Area* p = _head;
    Area* s = [[Area alloc] init];
    while (p!=nil)
    {
        s = p.next;
        if (p.startTime == p.endTime)
        {
            [self deleteArea:p];
        }
       if(((p.endTime - p.startTime) < 1100) || ([p getAmplitudeAverage] < AMPLITUDE_THRESHOLD) )
        {
            [self deleteArea:p];
        }
        p = s;
    }//traversal the linked list to delete useless area which is shorter than time length threashold or less than amplitude average threshold
}
-(void)deleteArea:(Area*)area
{
    Area* p = _head;
    Area* p2 = _head.next;
    if(p == area)
    {
        if (_rear == area)
        _rear = _head.next;
        
        _head = _head.next;
        self.count--;
    }
    else
    {
        while (p2!=nil)
        {
            if(p2==area)
            {
                if (_rear == area)
                {
                    _rear = p;
                }
            p.next = p2.next;
            self.count--;
            break;
            }
        p = p2;
        p2=p2.next;
        }
    }
}
@end
