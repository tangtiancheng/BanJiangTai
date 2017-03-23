/**
 *  XPStorage+NSData.m
 *  ShareMerge
 *
 *  Created by huangxp on 2015-09-01.
 *
 *  插入数据流
 *
 *  Copyright (c) www.sharemerge.com All rights reserved.
 */

/** @file */    // Doxygen marker

#import "XPStorage+NSData.h"
#import "XPStorage+NSString.h"

@implementation XPStorage (NSData)

- (void)putData:(NSData *)data withId:(NSString *)id {
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self putString:result withId:id];
}

- (NSData*)getDataById:(NSString *)id {
    NSString *result = [self getStringById:id];
    return [result dataUsingEncoding:NSUTF8StringEncoding];
}

@end
