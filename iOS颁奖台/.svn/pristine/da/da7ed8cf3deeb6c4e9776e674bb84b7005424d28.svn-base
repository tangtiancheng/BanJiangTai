//
//  dateTool.m
//  XPApp
//
//  Created by Pua on 16/3/22.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "dateTool.h"

@implementation dateTool
+(NSInteger)day:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitDay) fromDate:date];
    return [components day];
}


+(NSInteger)month:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar]components:(NSCalendarUnitMonth) fromDate:date];
    return [components month];
}

+(NSInteger)year:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar]components:(NSCalendarUnitYear) fromDate:date];
    return [components year];
}

+(NSInteger)firstWeekdayInThisMonth:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday -1;
    
}

+(NSInteger)totaldaysInMonth:(NSDate *)date
{
    NSRange dayInOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return dayInOfMonth.length;
}
+(NSDate *)lastMonth:(NSDate *)date
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar]dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}
+(NSDate*)nextMonth:(NSDate *)date
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar]dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

@end
