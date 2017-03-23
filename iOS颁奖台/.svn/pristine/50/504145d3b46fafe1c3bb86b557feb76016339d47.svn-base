//
//  NSString+XPValid.m
//  XPApp
//
//  Created by huangxinping on 15/9/25.
//  Copyright © 2015年 iiseeuu.com. All rights reserved.
//

#import "NSString+XPValid.h"
#import <XPKit/XPKit.h>
#import <XPKit/XPPassword.h>
#import <XPKit/XPSystemSound.h>

@implementation NSString (XPValid)

#pragma mark - Private API
+ (BOOL)isNumber:(char)ch
{
    if(!(ch >= '0' && ch <= '9')) {
        return NO;
    }
    
    return YES;
}

+ (BOOL)isValidNumber:(NSString *)value
{
    const char *cvalue = [value UTF8String];
    unsigned long len = strlen(cvalue);
    for(unsigned long i = 0; i < len; i++) {
        if(![NSString isNumber:cvalue[i]]) {
            return NO;
        }
    }
    return TRUE;
}

#pragma mark - Public API
- (BOOL)isQQ
{
    return self.length >= 5 && [NSString isValidNumber:self];
}

- (BOOL)isBirthday
{
    BOOL result = FALSE;
    if(self && 8 == [self length]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMdd"];
        NSDate *date = [formatter dateFromString:self];
        if(date) {
            result = TRUE;
        }
    }
    
    return result;
}

- (BOOL)isPhone
{
    return [self hasPrefix:@"1"] && self.length == 11;
    
    /*
     *  因为以下逻辑不包含170...号段，所以无用了
     *
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     
     NSString *CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
     NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
     if([regextestcu evaluateWithObject:self]) {
     return YES;
     } else {
     return NO;
     }
     
     */
}

@end
