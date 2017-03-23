//
//  NSDictionary+XPUserInfo.m
//  XPApp
//
//  Created by huangxinping on 15/10/21.
//  Copyright © 2015年 iiseeuu.com. All rights reserved.
//

#import "NSDictionary+XPUserInfo.h"

#import "XPLoginModel.h"

@implementation NSDictionary (XPUserInfo)

- (NSDictionary *)fillUserInfo
{
    //    printf("-------开始组装参数-------\n");
        XPLog(@"%@", self);
    NSMutableDictionary *buffer = [NSMutableDictionary dictionaryWithDictionary:self];
    if([XPLoginModel singleton].userId) {
        [buffer setObject:[XPLoginModel singleton].userId forKey:@"userId"];
    }
    if([XPLoginModel singleton].accessToken) {
        [buffer setObject:[XPLoginModel singleton].accessToken forKey:@"access_token"];
    }
    if([XPLoginModel singleton].userPhone) {
        [buffer setObject:[XPLoginModel singleton].userPhone forKey:@"userPhone"];
    }
    
        XPLog(@"%@", buffer);
    //    printf("-------结束组装参数-------\n");
    return buffer;
}

@end
