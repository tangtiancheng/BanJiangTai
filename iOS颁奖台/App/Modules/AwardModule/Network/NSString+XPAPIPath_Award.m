//
//  NSString+XPAPIPath_Award.m
//  XPApp
//
//  Created by xinpinghuang on 1/20/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "NSString+XPAPIPath.h"
#import "NSString+XPAPIPath_Award.h"

@implementation NSString (XPAPIPath_Award)

+ (NSString *)api_award_path
{
    return [@"/ernie/prize/myPrize.check" fillBaseAPIPath];
}

+ (NSString *)api_award_delivery_path
{
    return [@"/ernie/prize/myPrizeReceive.check" fillBaseAPIPath];
}

@end
