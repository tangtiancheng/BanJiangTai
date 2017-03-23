//
//  XPAPIManager+Login.m
//  XPApp
//
//  Created by huangxinping on 15/9/23.
//  Copyright © 2015年 iiseeuu.com. All rights reserved.
//

#import "NSString+XPAPIPath_Login.h"
#import "XPAPIManager+Analysis.h"
#import "XPAPIManager+Login.h"
#import "XPLoginModel.h"

#import "NSDictionary+XPDeviceToken.h"
#import <XPKit/XPKit.h>
#import "NSDictionary+XPUserInfo.h"

@implementation XPAPIManager (Login)

- (RACSignal *)loginWithPhone:(NSString *)phone captcha:(NSString *)captcha
{
    NSParameterAssert(phone);
    NSParameterAssert(captcha);
    return [[[[[self rac_GET:[NSString api_login_path]
                parameters  :[@{
                                @"userPhone":phone,
                                @"smsCode":captcha
                                }
                              fillDeviceToken]] map:^id (id value) {
                    return [self analysisRequest:value];
                }] flattenMap:^RACStream *(id value) {
                    if([value isKindOfClass:[NSError class]]) {
                        return [RACSignal error:value];
                    }
                    
                    return [self rac_MergeMappingForClass:[XPLoginModel class] dictionary:value];
                }] logError] replayLazily];
}

- (RACSignal *)captchaWithPhone:(NSString *)phone
{
    NSParameterAssert(phone);
    return [[[[[self rac_GET:[NSString api_captcha_path]
                parameters  :[@{
                                @"userPhone":phone
                                }
                              fillDeviceToken]] map:^id (id value) {
                    return [self analysisRequest:value];
                }] flattenMap:^RACStream *(id value) {
                    if([value isKindOfClass:[NSError class]]) {
                        return [RACSignal error:value];
                    }
                    
                    return [RACSignal return :value];
                }] logError] replayLazily];
}

- (RACSignal *)updatePhoneNumber:(NSString *)changeUserPhone smsCode:(NSString *)smsCode{
    
    NSParameterAssert(changeUserPhone);
    NSParameterAssert(smsCode);
    return [[[[[self rac_GET:[NSString api_changePhoneNumber_path]
                parameters  :[@{
                                @"changeUserPhone":changeUserPhone,
                                @"smsCode":smsCode
                                }
                              fillUserInfo]] map:^id (id value) {
                    NSLog(@"bjhj");
                    return [self analysisRequest:value];
                }] flattenMap:^RACStream *(id value) {
                    if([value isKindOfClass:[NSError class]]) {
                        return [RACSignal error:value];
                    }
                    
                    return [RACSignal return :value];
                }] logError] replayLazily];

}
@end
