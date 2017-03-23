//
//  NSDictionary+XPDeviceToken.m
//  XPApp
//
//  Created by xinpinghuang on 1/21/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import "NSDictionary+XPDeviceToken.h"

@implementation NSDictionary (XPDeviceToken)

- (NSDictionary *)fillDeviceToken
{
    NSMutableDictionary *buffer = [NSMutableDictionary dictionaryWithDictionary:self];
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"]) {
        [buffer setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"] forKey:@"jpushToken"];
    }
    
    return buffer;
}

@end
