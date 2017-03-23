/**
 *  XPStorage+NSNumber.m
 *  ShareMerge
 *
 *  Created by huangxp on 2015-09-01.
 *
 *  插入数值
 *
 *  Copyright (c) www.sharemerge.com All rights reserved.
 */

/** @file */    // Doxygen marker

#import "XPStorage+NSNumber.h"
#import "XPStorage+NSString.h"

@implementation XPStorage (NSNumber)

- (void)putNumber:(NSNumber *)number withId:(NSString *)id {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    NSString *result = [numberFormatter stringFromNumber:number];
    [self putString:result withId:id];
}

- (NSNumber*)getNumberById:(NSString *)id {
    NSString *result = [self getStringById:id];
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    return [f numberFromString:result];
}

@end
