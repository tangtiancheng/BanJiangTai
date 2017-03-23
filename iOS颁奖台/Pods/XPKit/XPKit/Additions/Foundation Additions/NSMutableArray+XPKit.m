//
//  NSMutableArray+XPKit.m
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

#import "NSMutableArray+XPKit.h"
#import "NSArray+XPKit.h"

@implementation NSMutableArray (XPKit)

- (void)appendObjects:(id)firstObject, ...
{
	id currentObject;
	va_list argList;

	if (firstObject) {
		[self addObject:firstObject];
		va_start(argList, firstObject);

		while ((currentObject = va_arg(argList, id)))
			[self addObject:currentObject];
		va_end(argList);
	}
}

- (void)prependObjects:(id)firstObject, ...
{
	id currentObject = nil;
	va_list argList;
	NSUInteger idx = 0;

	if (firstObject) {
		[self insertObject:firstObject atIndex:0];
		va_start(argList, firstObject);

		while ((currentObject = va_arg(argList, id))) {
			idx++;
			[self insertObject:currentObject atIndex:idx];
		}
		va_end(argList);
	}
}

- (id)safeObjectAtIndex:(NSUInteger)index {
	if ([self count] > 0 && [self count] > index)
		return [self objectAtIndex:index];
	else
		return nil;
}

- (void)moveObjectFromIndex:(NSUInteger)from toIndex:(NSUInteger)to {
	if (to != from) {
		id obj = [self safeObjectAtIndex:from];
		[self removeObjectAtIndex:from];

		if (to >= [self count])
			[self addObject:obj];
		else
			[self insertObject:obj atIndex:to];
	}
}

- (NSMutableArray *)reversedArray {
	return (NSMutableArray *)[NSArray reversedArray:self];
}

+ (NSMutableArray *)sortArrayByKey:(NSString *)key array:(NSMutableArray *)array ascending:(BOOL)ascending {
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	[tempArray removeAllObjects];
	[tempArray addObjectsFromArray:array];

	NSSortDescriptor *brandDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
	NSArray *sortDescriptors = [NSArray arrayWithObjects:brandDescriptor, nil];
	NSArray *sortedArray = [tempArray sortedArrayUsingDescriptors:sortDescriptors];
	[tempArray removeAllObjects];
	tempArray = (NSMutableArray *)sortedArray;
	[array removeAllObjects];
	[array addObjectsFromArray:tempArray];

	return array;
}

@end
