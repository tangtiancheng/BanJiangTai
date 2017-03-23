//
//  XPInviteViewModel.m
//  XPApp
//
//  Created by xinpinghuang on 1/19/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPAPIManager+Invite.h"
#import "XPInviteViewModel.h"

@interface XPInviteViewModel ()

@property (nonatomic, strong, readwrite) RACCommand *inviteCommand;
@property (nonatomic, strong, readwrite) XPInviteModel *model;

@end

@implementation XPInviteViewModel

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
- (RACCommand *)inviteCommand
{
    if(_inviteCommand == nil) {
        @weakify(self);
        _inviteCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager invite];
        }];
        [[[_inviteCommand executionSignals] concat] subscribeNext:^(id x) {
            @strongify(self);
            self.model = x;
        }];
        XPViewModelShortHand(_inviteCommand);
    }
    
    return _inviteCommand;
}

@end
