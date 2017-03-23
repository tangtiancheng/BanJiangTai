//
//  NSString+XPAPIPath_Profile.m
//  XPApp
//
//  Created by xinpinghuang on 1/20/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "NSString+XPAPIPath.h"
#import "NSString+XPAPIPath_Profile.h"

@implementation NSString (XPAPIPath_Profile)

+ (NSString *)api_logout_path
{
    return [@"/ernie/user/logout.check" fillBaseAPIPath];
}

+ (NSString *)api_update_profile_path
{
    return [@"/ernie/user/changeUserInfo.check" fillBaseAPIPath];
}
//+(NSString *)api_changePhoneNumber_path
//{
//    return [@"/ernie/user/updateUserPhone.check " fillBaseAPIPath];
//}
//+ (NSString *)api_captcha_path
//{
//    return [@"/ernie/user/smsCode.ernie" fillBaseAPIPath];
//}

@end
