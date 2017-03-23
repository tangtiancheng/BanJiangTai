//
//  XPLoginViewModel.m
//  XPApp
//
//  Created by huangxinping on 15/9/23.
//  Copyright © 2015年 iiseeuu.com. All rights reserved.
//

#import <XPKit/XPKit.h>

#import "JPUSHService.h"
#import "NSString+XPValid.h"
#import "XPAPIManager+Login.h"
#import "XPLoginModel.h"
#import "XPLoginStorage.h"
#import "XPLoginViewModel.h"

@interface XPLoginViewModel ()

@property (nonatomic, strong, readwrite) XPLoginModel *model;
@property (nonatomic, strong, readwrite) RACSignal *phoneValidSignal;
@property (nonatomic, strong, readwrite) RACSignal *validSignal;
@property (nonatomic, strong, readwrite) RACSignal *validSignalChangePhone;
@property (nonatomic, strong, readwrite) RACCommand *signInCommand;
@property (nonatomic, strong, readwrite) RACCommand *captchaCommand;


@property(nonatomic,strong,readwrite) RACCommand* changePhoneNumCommand;
@end

@implementation XPLoginViewModel

#pragma mark - LifeCircle
- (instancetype)init
{
    if((self = [super init])) {
    }
    
    return self;
}

#pragma mark - Getter & Setter
- (RACSignal *)phoneValidSignal
{
    if(!_phoneValidSignal) {
        _phoneValidSignal = [RACSignal combineLatest:@[RACObserve(self, phone)] reduce:^id (NSString *phone){
            return @([phone isPhone]);
        }];
    }
    
    return _phoneValidSignal;
}

- (RACSignal *)validSignal
{
    if(!_validSignal) {
        _validSignal = [RACSignal combineLatest:@[RACObserve(self, phone), RACObserve(self, captcha), RACObserve(self, agreement)] reduce:^id (NSString *phone, NSString *captcha, NSNumber *agreement){
            return @([phone isPhone] && captcha.length >= 6 && [agreement boolValue]);
        }];
    }
    
    return _validSignal;
}

- (RACSignal *)validSignalChangePhone
{
    if(!_validSignal) {
        _validSignal = [RACSignal combineLatest:@[RACObserve(self, phone), RACObserve(self, captcha)] reduce:^id (NSString *phone, NSString *captcha){
            return @([phone isPhone] && captcha.length >= 6 );
        }];
    }
    
    return _validSignal;
}

- (RACCommand *)signInCommand
{
    if(!_signInCommand) {
        @weakify(self);
        _signInCommand = [[RACCommand alloc] initWithEnabled:self.validSignal signalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [[self.apiManager loginWithPhone:self.phone captcha:self.captcha] flattenMap:^RACStream *(id value) {
                @strongify(self);
                return [[[self saveUserWithModel:value] ignoreValues] concat:[RACSignal return :value]];
            }];
        }];
        [[[_signInCommand executionSignals] concat] subscribeNext:^(XPLoginModel *x) {
            @strongify(self);
            self.model = x;
            [XPLoginModel singleton].signIn = YES;
            NSSet *tags = nil;
            if(self.model.groupIds && ![self.model.groupIds isEqualToString:@""]) {
                NSArray *groupIds = [self.model.groupIds componentsSeparatedByString:@","];
                tags = [NSSet setWithArray:groupIds];
            }
            
            [JPUSHService setTags:tags alias:self.model.accessToken fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                XPLog(@"%@", iAlias);
            }];
        }];
        XPViewModelShortHand(_signInCommand)
    }
    
    return _signInCommand;
}

- (RACSignal *)saveUserWithModel:(XPLoginModel *)model
{
    return [RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
        [XPLoginStorage storageWithUser:[[[XPUser alloc] init] tap:^(XPUser *x) {
            x.phone = model.userPhone;
            x.accessToken = model.accessToken;
            x.userId = model.userId;
        }]];
        [subscriber sendNext:@YES];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
}

- (RACCommand *)captchaCommand
{
    if(!_captchaCommand) {
        @weakify(self);
        _captchaCommand = [[RACCommand alloc] initWithEnabled:self.phoneValidSignal signalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager captchaWithPhone:self.phone];
        }];
        XPViewModelShortHand(_captchaCommand);
    }
    
    return _captchaCommand;
}


-(RACCommand*)changePhoneNumCommand{
    
    if(!_changePhoneNumCommand) {
        @weakify(self);
        _changePhoneNumCommand = [[RACCommand alloc] initWithEnabled:self.validSignalChangePhone signalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager updatePhoneNumber:self.phone smsCode:self.captcha];
        }];
        [[[_changePhoneNumCommand executionSignals] concat] subscribeNext:^(id x) {
            @strongify(self);
            self.changePhoneSuccess=YES;
        }];
        XPViewModelShortHand(_changePhoneNumCommand);
    }
    
    return _changePhoneNumCommand;

}
@end
