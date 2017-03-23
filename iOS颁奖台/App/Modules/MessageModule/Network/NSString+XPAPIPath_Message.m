//
//  NSString+XPAPIPath_Message.m
//  XPApp
//
//  Created by xinpinghuang on 1/23/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "NSString+XPAPIPath.h"
#import "NSString+XPAPIPath_Message.h"

@implementation NSString (XPAPIPath_Message)

+ (NSString *)api_message_path
{
    return [@"/ernie/user/userMessage.check" fillBaseAPIPath];
}

+ (NSString *)api_message_readed_path
{
    return [@"/ernie/user/userMessageRead.check" fillBaseAPIPath];
}

@end
