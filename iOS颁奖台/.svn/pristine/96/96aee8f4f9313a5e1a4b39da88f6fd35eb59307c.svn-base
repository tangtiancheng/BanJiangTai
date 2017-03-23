//
//  NSCalendar+XPKit.m
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

#import "NSCalendar+XPKit.h"

@implementation NSCalendar (XPKit)

+ (XPDayOfTheWeekType)dayOfTheWeekOnYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
	if (year > 1582) {
		if (month < 3) {
			year--;
			month += 12;
		}

		NSInteger val;
		val = (year + (int)(year / 4) - (int)(year / 100) + (int)(year / 400)
		       + (int)((13 * month + 8) / 5) + day) % 7;
		return (XPDayOfTheWeekType)val;
	}

	return kUndefined;
}

static NSArray *wdays;
+ (NSString *)nameOfTheDayOfTheWeekType:(XPDayOfTheWeekType)wday {
	wdays = [NSArray arrayWithObjects:@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];

	if (wday >= kUndefined && (NSUInteger)wday < wdays.count) {
		return [wdays objectAtIndex:(NSUInteger)wday];
	}

	return @"";
}

static NSArray *monthNames;
+ (NSArray *)chineseMonthNames {
	monthNames = [NSArray arrayWithObjects:@"一月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月", @"九月", @"十月", @"十一月", @"十二月", nil];
	return monthNames;
}

+ (NSString *)nameOfMonth:(NSInteger)month {
	NSArray *lMonthNames = [NSCalendar chineseMonthNames];

	if (month >= 1 && (NSUInteger)month <= lMonthNames.count) {
		return [lMonthNames objectAtIndex:(NSUInteger)(month - 1)];
	}

	return @"";
}

@end
