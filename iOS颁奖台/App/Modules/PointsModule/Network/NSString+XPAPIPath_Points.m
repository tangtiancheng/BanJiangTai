//
//  NSString+XPAPIPath_Points.m
//  XPApp
//
//  Created by xinpinghuang on 1/19/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "NSString+XPAPIPath.h"
#import "NSString+XPAPIPath_Points.h"

@implementation NSString (XPAPIPath_Points)

+ (NSString *)api_points_path
{
    return [@"/ernie/user/myPoints.check" fillBaseAPIPath];
}

@end
