//
//  XPAPIManager+Profile.h
//  XPApp
//
//  Created by xinpinghuang on 1/20/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPAPIManager.h"

@interface XPAPIManager (Profile)

- (RACSignal *)logout;

- (RACSignal *)updateProfileWithNick:(NSString *)nick sex:(NSInteger)sex avatar:(NSString *)avatar birthday:(NSString *)birthday;
//- (RACSignal *)updatePhoneNumber:(NSString *)changeUserPhone smsCode:(NSString *)smsCode;
//- (RACSignal *)captchaWithPhone:(NSString *)phone;

@end
