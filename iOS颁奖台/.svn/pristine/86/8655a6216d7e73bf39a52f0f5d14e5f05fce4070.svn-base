//
//  XPAPIManager+Login.h
//  XPApp
//
//  Created by huangxinping on 15/9/23.
//  Copyright © 2015年 iiseeuu.com. All rights reserved.
//

#import "XPAPIManager.h"

@interface XPAPIManager (Login)

- (RACSignal *)loginWithPhone:(NSString *)phone captcha:(NSString *)captcha;

- (RACSignal *)captchaWithPhone:(NSString *)phone;

- (RACSignal *)updatePhoneNumber:(NSString *)changeUserPhone smsCode:(NSString *)smsCode;
@end
