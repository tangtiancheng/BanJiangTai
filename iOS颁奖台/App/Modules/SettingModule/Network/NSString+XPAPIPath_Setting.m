//
//  NSString+XPAPIPath_Setting.m
//  XPApp
//
//  Created by xinpinghuang on 1/19/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "NSString+XPAPIPath.h"
#import "NSString+XPAPIPath_Setting.h"

@implementation NSString (XPAPIPath_Setting)

+ (NSString *)api_logout_path
{
    return [@"/ernie/user/logout.check" fillBaseAPIPath];
}

+ (NSString *)api_agreement_path
{
    return [@"/ernie/client/userAgreement.ernie" fillBaseAPIPath];
}

@end
