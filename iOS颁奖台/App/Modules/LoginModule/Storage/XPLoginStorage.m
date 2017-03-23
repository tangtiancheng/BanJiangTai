//
//  XPLoginStorage.m
//  XPApp
//
//  Created by huangxinping on 15/9/23.
//  Copyright © 2015年 iiseeuu.com. All rights reserved.
//

#import "XPLoginStorage.h"

@implementation XPLoginStorage

+ (BOOL)cached
{
    return [self userWithRowLogin] ? YES : NO;
}

+ (void)clearCached
{
    XPLoginStorage *temp = [[XPLoginStorage alloc] init];
    [temp deleteObjectForKey:@"XPUser"];
}

+ (XPUser *)userWithRowLogin
{
    XPLoginStorage *temp = [[XPLoginStorage alloc] init];
    id jsonString = [temp getValueForKey:@"XPUser"];
    return [[XPUser alloc] initWithString:jsonString error:nil];
}

+ (BOOL)storageWithUser:(XPUser *)user
{
    NSParameterAssert(nil != user);
    XPLoginStorage *temp = [[XPLoginStorage alloc] init];
    [temp putValue:[user toJSONString] forKey:@"XPUser"];
    return YES;
}

@end
