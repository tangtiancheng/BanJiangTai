//
//  NSString+XPAPIPath_Invite.m
//  XPApp
//
//  Created by xinpinghuang on 1/19/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "NSString+XPAPIPath.h"
#import "NSString+XPAPIPath_Invite.h"

@implementation NSString (XPAPIPath_Invite)

+ (NSString *)api_invite_path
{
    return [@"/ernie/user/invite.check" fillBaseAPIPath];
}

@end
