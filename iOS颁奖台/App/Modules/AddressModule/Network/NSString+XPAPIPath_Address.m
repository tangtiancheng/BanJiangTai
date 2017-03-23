
//
//  NSString+XPAPIPath_Address.m
//  XPApp
//
//  Created by xinpinghuang on 1/21/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "NSString+XPAPIPath.h"
#import "NSString+XPAPIPath_Address.h"

@implementation NSString (XPAPIPath_Address)

+ (NSString *)api_address_path
{
    return [@"/ernie/user/userAddressManagement.check" fillBaseAPIPath];
}

+ (NSString *)api_address_create_path
{
    return [@"/ernie/user/insertUserDeliveryAddress.check" fillBaseAPIPath];
}

+ (NSString *)api_address_update_path
{
    return [@"/ernie/user/changeUserDeliveryAddress.check" fillBaseAPIPath];
}

+ (NSString *)api_address_delete_path
{
    return [@"/ernie/user/deleteUserDeliveryAddress.check" fillBaseAPIPath];
}

@end
