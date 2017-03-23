//
//  XPSettingViewModel.m
//  XPApp
//
//  Created by xinpinghuang on 1/19/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "JPUSHService.h"
#import "XPAPIManager+Setting.h"
#import "XPLoginModel.h"
#import "XPSettingViewModel.h"

@interface XPSettingViewModel ()

@property (nonatomic, strong, readwrite) RACCommand *logoutCommand;
@property (nonatomic, strong, readwrite) RACCommand *agreementCommand;
@property (nonatomic, strong, readwrite) NSString *agreenmentURL;

@end

@implementation XPSettingViewModel

#pragma mark - Life Circle
- (instancetype)init
{
    if(self = [super init]) {
    }
    
    return self;
}

#pragma mark - Public Interface

#pragma mark - Private Methods

#pragma mark - Getter & Setter
- (RACCommand *)logoutCommand
{
    if(_logoutCommand == nil) {
        @weakify(self);
        _logoutCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager logout];
        }];
        [[[_logoutCommand executionSignals] concat] subscribeNext:^(id x) {
            @strongify(self);
            [[XPLoginModel singleton] logout];
            [JPUSHService setTags:nil alias:@"18888888888" fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
            }];
            self.finished = YES;
        }];
        XPViewModelShortHand(_logoutCommand);
    }
    
    return _logoutCommand;
}

- (RACCommand *)agreementCommand
{
    if(_agreementCommand == nil) {
        @weakify(self);
        _agreementCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager agreenment];
        }];
        [[[_agreementCommand executionSignals] concat] subscribeNext:^(id x) {
            @strongify(self);
            self.agreenmentURL = x;
        }];
        XPViewModelShortHand(_agreementCommand);
    }
    
    return _agreementCommand;
}

@end
