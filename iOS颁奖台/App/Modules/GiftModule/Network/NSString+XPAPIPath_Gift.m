//
//  NSString+XPAPIPath_Gift.m
//  XPApp
//
//  Created by xinpinghuang on 1/21/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "NSString+XPAPIPath.h"
#import "NSString+XPAPIPath_Gift.h"

@implementation NSString (XPAPIPath_Gift)

+ (NSString *)api_gift_path
{
    return [@"/ernie/prize/getSendPrizesList.check" fillBaseAPIPath];
}

+ (NSString *)api_gift_create_path
{
    return [@"/ernie/prize/sendPrizes.check" fillBaseAPIPath];
}

+ (NSString *)api_gift_group_list_path
{
    return [@"/ernie/user/myGroupList.check" fillBaseAPIPath];
}

+ (NSString *)api_gift_group_create_path
{
    return [@"/ernie/user/createGroup.check" fillBaseAPIPath];
}

@end
