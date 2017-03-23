//
//  XPGiftViewModel.m
//  XPApp
//
//  Created by xinpinghuang on 1/21/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "NSString+XPPrivacyPhone.h"
#import "XPAPIManager+Gift.h"
#import "XPAPIManager+Invite.h"
#import "XPGiftViewModel.h"
#import "XPLoginModel.h"

NSString *const XPGiftCreateFinishedNotification = @"XPGiftCreateFinishedNotification";

@interface XPGiftViewModel ()

@property (nonatomic, assign, readwrite) BOOL finished;
@property (nonatomic, strong, readwrite) NSArray *list;
@property (nonatomic, strong, readwrite) RACCommand *reloadCommand;
@property (nonatomic, strong, readwrite) RACCommand *moreCommand;

@property (nonatomic, assign, readwrite) BOOL createFinished;
@property (nonatomic, strong, readwrite) RACSignal *createValidSignal;
@property (nonatomic, strong, readwrite) RACCommand *createCommand;

@property (nonatomic, strong, readwrite) NSArray *groupList;
@property (nonatomic, strong, readwrite) RACCommand *groupReloadCommand;
@property (nonatomic, strong, readwrite) RACCommand *groupMoreCommand;
@property (nonatomic, assign, readwrite) BOOL groupListFinished;
@property (nonatomic, strong, readwrite) RACCommand *groupCreateCommand;

//@property (nonatomic, strong, readwrite) XPInviteModel *inviteModel;
@property (nonatomic, strong, readwrite) RACCommand *inviteCommand;

@end

@implementation XPGiftViewModel

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
            self.inviteModel = x;
        }];
        XPViewModelShortHand(_inviteCommand);
    }
    
    return _inviteCommand;
}


- (RACCommand *)reloadCommand
{
    if(_reloadCommand == nil) {
        @weakify(self);
        _reloadCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager giftWithLastCount:0 pageSize:20];
        }];
        [[[_reloadCommand executionSignals] concat] subscribeNext:^(NSArray *x) {
            @strongify(self);
            self.list = x;
            if([x count] < 20) {
                self.finished = YES;
            }
        }];
        XPViewModelShortHand(_reloadCommand);
    }
    
    return _reloadCommand;
}

- (RACCommand *)moreCommand
{
    if(_moreCommand == nil) {
        @weakify(self);
        _moreCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager giftWithLastCount:self.list.count pageSize:20];
        }];
        [[[_moreCommand executionSignals] concat] subscribeNext:^(NSArray *x) {
            @strongify(self);
            self.list = [self.list arrayByAddingObjectsFromArray:x];
            if([x count] < 20) {
                self.finished = YES;
            }
        }];
        XPViewModelShortHand(_moreCommand);
    }
    
    return _moreCommand;
}

- (RACCommand *)createCommand
{
    if(_createCommand == nil) {
        @weakify(self);
        _createCommand = [[RACCommand alloc] initWithEnabled:self.createValidSignal signalBlock:^RACSignal *(id input) {
            @strongify(self);
            if(!self.activityName || [self.activityName isEqualToString:@""]) {
                self.activityName = [NSString stringWithFormat:@"[%@]发奖啦，快来颁奖台领奖~", [XPLoginModel singleton].userName ? : [[XPLoginModel singleton].userPhone privacyPhone]];
            }
            
            return [self.apiManager giftCreateWithActivityName:self.activityName giftName:self.giftName number:self.number createUserPhone:self.createUserPhone createUserNick:self.createUserNick groupId:self.groupId groupName:self.groupName groupActivity:YES];
        }];
        [[[_createCommand executionSignals] concat] subscribeNext:^(id x) {
            @strongify(self);
            self.createFinished = YES;
        }];
        XPViewModelShortHand(_createCommand);
    }
    
    return _createCommand;
}



- (RACSignal *)createValidSignal
{
    return [RACSignal combineLatest:@[RACObserve(self, giftName), RACObserve(self, number), RACObserve(self, createUserPhone), RACObserve(self, createUserNick), RACObserve(self, groupId), RACObserve(self, groupName)] reduce:^id (NSString *giftName, NSNumber *number, NSString *createUserPhone, NSString *createUserNick, NSString *groupId, NSString *groupName){
        return @(
        giftName.length > 0 &&
        [number integerValue] > 0 &&
        createUserPhone.length &&
        createUserNick.length > 0 &&
        groupId.length > 0 &&
        groupName.length > 0);
    }];
}

- (RACSignal *)createNextValidSignal
{
    return [RACSignal combineLatest:@[RACObserve(self, giftName), RACObserve(self, number), RACObserve(self, createUserPhone), RACObserve(self, createUserNick), RACObserve(self, groupId), RACObserve(self, groupName)] reduce:^id (NSString *giftName, NSNumber *number, NSString *createUserPhone, NSString *createUserNick, NSString *groupId, NSString *groupName){
        return @(
        giftName.length > 0 &&
        [number integerValue] > 0 &&
        createUserPhone.length &&
        createUserNick.length > 0);
    }];
}

- (RACCommand *)groupReloadCommand
{
    if(_groupReloadCommand == nil) {
        @weakify(self);
        _groupReloadCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager giftGroupWithLastCount:0 pageSize:20];
        }];
        [[[_groupReloadCommand executionSignals] concat] subscribeNext:^(NSArray *x) {
            @strongify(self);
            self.groupList = x;
            if([x count] < 20) {
                self.groupListFinished = YES;
            }
        }];
        XPViewModelShortHand(_groupReloadCommand);
    }
    
    return _groupReloadCommand;
}

- (RACCommand *)groupMoreCommand
{
    if(_groupMoreCommand == nil) {
        @weakify(self);
        _groupMoreCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager giftGroupWithLastCount:self.groupList.count pageSize:20];
        }];
        [[[_groupMoreCommand executionSignals] concat] subscribeNext:^(NSArray *x) {
            @strongify(self);
            self.groupList = [self.groupList arrayByAddingObjectsFromArray:x];
            if([x count] < 20) {
                self.groupListFinished = YES;
            }
        }];
        XPViewModelShortHand(_groupMoreCommand);
    }
    
    return _groupMoreCommand;
}

- (RACCommand *)groupCreateCommand
{
    if(_groupCreateCommand == nil) {
        @weakify(self);
        _groupCreateCommand = [[RACCommand alloc] initWithEnabled:[RACObserve(self, groupName) map:^id (NSString *value) {
            return @(value.length > 0 && value.length <= 10);
        }] signalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager giftGroupCreateWithName:self.groupName];
        }];
        [[[_groupCreateCommand executionSignals] concat] subscribeNext:^(id x) {
            @strongify(self);
            self.groupId = x;
            self.groupCreateFinished = YES;
        }];
        XPViewModelShortHand(_groupCreateCommand);
    }
    
    return _groupCreateCommand;
}

@end
