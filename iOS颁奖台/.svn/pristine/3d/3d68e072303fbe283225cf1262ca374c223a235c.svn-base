//
//  XPProfileViewModel.m
//  XPApp
//
//  Created by xinpinghuang on 1/11/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "JPUSHService.h"
#import "UIImage+XPCompress.h"
#import "XPAPIManager+Profile.h"
#import "XPAPIManager+XPPostImage.h"
#import "XPLoginModel.h"
#import "XPProfileViewModel.h"

@interface XPProfileViewModel ()

@property (nonatomic, strong, readwrite) RACCommand *logoutCommand;
@property (nonatomic, strong, readwrite) RACCommand *submitCommand;
@property (nonatomic, strong) NSString *avatarURL;

@end

@implementation XPProfileViewModel

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
- (RACCommand *)submitCommand
{
    if(_submitCommand == nil) {
        @weakify(self);
        _submitCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [[[self.apiManager rac_postRemoteImage:[self.avatarImage xp_compress]] doNext:^(id x) {
                @strongify(self);
                self.avatarURL = x;
                [XPLoginModel singleton].userImage = x;
            }] then:^RACSignal *{
                return [self.apiManager updateProfileWithNick:self.nick sex:self.sex avatar:self.avatarURL birthday:self.birthday];
            }];
        }];
        [[[_submitCommand executionSignals] concat] subscribeNext:^(id x) {
            [XPLoginModel singleton].signIn = YES;
        }];
        XPViewModelShortHand(_submitCommand);
    }
    
    return _submitCommand;
}

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

@end
