//
//  NSCalendar+XPKit.h
//  XPKit
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014 - 2015 Fabrizio Brancati. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
#import <Foundation/Foundation.h>

typedef enum _XPDayOfTheWeekType {
	kUndefined = -1,
	kSunday = 0,
	kMonday,
	kTuesday,
	kWednesday,
	kThursday,
	kFriday,
	kSaturday
}XPDayOfTheWeekType;

/**
 *  This class add some useful methods to NSCalendar
 */
@interface NSCalendar (XPKit)

/**
 *  calutator day name
 *
 *  @param year  year
 *  @param month month
 *  @param day   day
 *
 *  @return Return day name
 */
+ (XPDayOfTheWeekType)dayOfTheWeekOnYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

/**
 *  Convert to name string
 *
 *  @param wday wday
 *
 *  @return Return name string
 */
+ (NSString *)nameOfTheDayOfTheWeekType:(XPDayOfTheWeekType)wday;

/**
 *  Get chinese month names
 *
 *  @return Return month names array
 */
+ (NSArray *)chineseMonthNames;

/**
 *  Get chinese name with month
 *
 *  @param month month
 *
 *  @return Return chinese name string
 */
+ (NSString *)nameOfMonth:(NSInteger)month;

@end
