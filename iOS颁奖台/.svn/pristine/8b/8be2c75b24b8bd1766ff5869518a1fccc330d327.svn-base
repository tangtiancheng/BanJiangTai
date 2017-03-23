//
//  XPLoginModel.m
//  XPApp
//
//  Created by huangxinping on 15/9/25.
//  Copyright © 2015年 iiseeuu.com. All rights reserved.
//

#import "XPLoginModel.h"
#import "XPLoginStorage.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation XPLoginModel

- (instancetype)init
{
    if((self = [super init])) {
        RAC(self, signIn) = [RACObserve(self, userId) map:^id (id value) {
            return value ? @YES : @NO;
        }];
    }
    
    return self;
}

- (void)logout
{
    self.userId = nil;
    self.accessToken = nil;
    self.birthday = nil;
    self.isAddress = nil;
    self.userImage = nil;
    self.userName = nil;
    self.userPhone = nil;
    self.userSex = 0;
    [XPLoginStorage clearCached];
}

@end
