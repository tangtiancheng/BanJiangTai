//
//  XPNoticeViewModel.m
//  XPApp
//
//  Created by xinpinghuang on 12/21/15.
//  Copyright 2015 ShareMerge. All rights reserved.
//

#import "XPAPIManager+Main.h"
#import "XPAPIManager+Notice.h"
#import "XPNoticeDetailModel.h"
#import "XPNoticeViewModel.h"

@interface XPNoticeViewModel ()

@property (nonatomic, assign, readwrite) BOOL finished;
@property (nonatomic, strong, readwrite) NSArray *list;
@property (nonatomic, strong, readwrite) NSArray *banners;
@property (nonatomic, strong, readwrite) RACCommand *reloadCommand;
@property (nonatomic, strong, readwrite) RACCommand *moreCommand;

@property (nonatomic, strong, readwrite) RACCommand *detailReloadCommand;
@property (nonatomic, strong, readwrite) RACCommand *detailMoreCommand;
@property (nonatomic, strong, readwrite) NSString *detailImageURL;
@property (nonatomic, strong, readwrite) NSString *prizeRuleURL;
@property (nonatomic, strong, readwrite) NSArray *detailList;

@property (nonatomic, assign, readwrite) BOOL groupJoinFinished;
@property (nonatomic, strong, readwrite) RACCommand *groupJoinCommand;

@end

@implementation XPNoticeViewModel

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
- (RACCommand *)reloadCommand
{
    if(_reloadCommand == nil) {
        @weakify(self);
        _reloadCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [[[self.apiManager noticeBanner] doNext:^(id x) {
                @strongify(self);
                self.banners = x;
            }] then:^RACSignal *{
                @strongify(self);
                return [self.apiManager noticeWithLastCount:0 pageSize:20];
            }];
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
            return [self.apiManager noticeWithLastCount:self.list.count pageSize:20];
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

- (RACCommand *)detailReloadCommand
{
    if(_detailReloadCommand == nil) {
        @weakify(self);
        _detailReloadCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager noticeWithId:self.noticeId lastCount:0 pageSize:20];
        }];
        [[[_detailReloadCommand executionSignals] concat] subscribeNext:^(XPNoticeDetailModel *x) {
            @strongify(self);
            self.detailList = x.list;
            self.detailImageURL = x.imageUrl;
            self.prizeRuleURL = x.prizeRule;
            if([x.list count] < 20) {
                self.finished = YES;
            }
        }];
        XPViewModelShortHand(_detailReloadCommand);
    }
    
    return _detailReloadCommand;
}

- (RACCommand *)detailMoreCommand
{
    if(_detailMoreCommand == nil) {
        @weakify(self);
        _detailMoreCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager noticeWithId:self.noticeId lastCount:self.detailList.count pageSize:20];
        }];
        [[[_detailMoreCommand executionSignals] concat] subscribeNext:^(XPNoticeDetailModel *x) {
            @strongify(self);
            self.detailList = [self.detailList arrayByAddingObjectsFromArray:x.list];
            if([x.list count] < 20) {
                self.finished = YES;
            } else {
            }
        }];
        XPViewModelShortHand(_detailMoreCommand);
    }
    
    return _detailMoreCommand;
}

- (RACCommand *)groupJoinCommand
{
    if(!_groupJoinCommand) {
        @weakify(self);
        _groupJoinCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager podiumGroupAddWithId:self.groupId fromUserId:self.fromUserId];
        }];
        [[[_groupJoinCommand executionSignals] concat] subscribeNext:^(id x) {
            @strongify(self);
            self.groupJoinFinished = @(YES);
        }];
        XPViewModelShortHand(_groupJoinCommand);
    }
    
    return _groupJoinCommand;
}

@end
