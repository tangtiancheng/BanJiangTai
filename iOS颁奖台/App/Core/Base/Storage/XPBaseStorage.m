//
//  XPBaseStorage.m
//  XPApp
//
//  Created by huangxinping on 15/9/2.
//  Copyright © 2015年 iiseeuu.com. All rights reserved.
//

#import "XPBaseStorage.h"
#import <XPStorage/XPStorage+NSArray.h>
#import <XPStorage/XPStorage+NSData.h>
#import <XPStorage/XPStorage+NSDictionary.h>
#import <XPStorage/XPStorage+NSNumber.h>
#import <XPStorage/XPStorage+NSString.h>

@implementation XPBaseStorage

- (BOOL)putValue:(id)value forKey:(NSString *)key
{
    NSAssert(key != nil, @"Storage Layer:key is nil!");
    NSAssert(value != nil, @"Storage Layer:value is nil!");
    if([value isKindOfClass:[NSString class]]) {
        [[XPStorage sharedStorage] putString:value withId:key];
    } else if([value isKindOfClass:[NSArray class]]) {
        [[XPStorage sharedStorage] putArray:value withId:key];
    } else if([value isKindOfClass:[NSDictionary class]]) {
        [[XPStorage sharedStorage] putDictionary:value withId:key];
    } else if([value isKindOfClass:[NSNumber class]]) {
        [[XPStorage sharedStorage] putNumber:value withId:key];
    } else if([value isKindOfClass:[NSData class]]) {
        [[XPStorage sharedStorage] putData:value withId:key];
    } else {
        return NO;
    }
    
    return YES;
}

- (id)getValueForKey:(NSString *)key
{
    NSAssert(key != nil, @"Storage Layer:key is nil!");
    
    XPStorageItem *item = [[XPStorage sharedStorage] getXPStorageItemById:key];
    if(item) {
        return item.object;
    }
    
    return nil;
}

- (NSArray *)getAllItems
{
    return [[XPStorage sharedStorage] getAllItems];
}

- (XPStorageItem *)getXPStorageItemForKey:(NSString *)key
{
    return [[XPStorage sharedStorage] getXPStorageItemById:key];
}

- (void)deleteObjectForKey:(NSString *)key
{
    [[XPStorage sharedStorage] deleteObjectById:key];
}

- (void)deleteObjectsForKeyArray:(NSArray *)keyArray
{
    [[XPStorage sharedStorage] deleteObjectsByIdArray:keyArray];
}

- (void)deleteObjectsByKeyPrefix:(NSString *)keyPrefix
{
    [[XPStorage sharedStorage] deleteObjectsByIdPrefix:keyPrefix];
}

@end
