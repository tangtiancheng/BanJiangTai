/**
 *  XPStorage+NSDictionary.m
 *  ShareMerge
 *
 *  Created by huangxp on 2015-09-01.
 *
 *  插入字典
 *
 *  Copyright (c) www.sharemerge.com All rights reserved.
 */

/** @file */    // Doxygen marker

#import "XPStorage+NSDictionary.h"
#import "XPStorage+NSData.h"

@implementation XPStorage (NSDictionary)

- (void)putDictionary:(NSDictionary *)dictionary withId:(NSString *)id {
    NSData *result = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
    [self putData:result withId:id];
}

- (NSDictionary*)getDictionaryById:(NSString *)id {
    NSData *result = [self getDataById:id];
    return [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
}

@end
