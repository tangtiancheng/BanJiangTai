/**
 *  XPStorage+NSArray.m
 *  ShareMerge
 *
 *  Created by huangxp on 2015-09-01.
 *
 *  插入数组
 *
 *  Copyright (c) www.sharemerge.com All rights reserved.
 */

/** @file */    // Doxygen marker

#import "XPStorage+NSArray.h"
#import "XPStorage+NSData.h"

@implementation XPStorage (NSArray)

- (void)putArray:(NSArray *)array withId:(NSString *)id {
    NSData *result = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
    [self putData:result withId:id];
}

- (NSArray*)getArrayById:(NSString *)id {
    NSData *result = [self getDataById:id];
    return [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
}

@end
