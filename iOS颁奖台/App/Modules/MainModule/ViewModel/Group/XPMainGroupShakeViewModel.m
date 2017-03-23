//
//  XPMainGroupShakeViewModel.m
//  XPApp
//
//  Created by xinpinghuang on 1/24/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPAPIManager+Main.h"
#import "XPMainGroupShakeModel.h"
#import "XPMainGroupShakeViewModel.h"

@interface XPMainGroupShakeViewModel ()

@property (nonatomic, assign, readwrite) BOOL finished;
@property (nonatomic, strong, readwrite) NSArray *list;
@property (nonatomic, strong, readwrite) RACCommand *reloadCommand;
@property (nonatomic, strong, readwrite) RACCommand *moreCommand;

@property (nonatomic, strong, readwrite) NSString *groupActivityOwnerName;
@property (nonatomic, strong, readwrite) NSString *groupActivityName;
@property (nonatomic, assign, readwrite) NSInteger shakedCount;
@property (nonatomic, assign, readwrite) NSInteger joinableCount;
@property (nonatomic, assign, readwrite) BOOL joinable;

@property (nonatomic, strong, readwrite) RACCommand *shakeCommand;
@property (nonatomic, assign, readwrite) BOOL win;

@end

@implementation XPMainGroupShakeViewModel

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
            return [self.apiManager podiumGroupShakeListWithId:self.groupId activityId:self.groupActivityId lastCount:0 pageSize:20];
        }];
        [[[_reloadCommand executionSignals] concat] subscribeNext:^(XPMainGroupShakeModel *x) {
            @strongify(self);
            self.list = x.winList;
            self.groupActivityName = x.groupActivityName;
            self.groupActivityOwnerName = x.sendPersonalName;
            self.shakedCount = x.winNumber;
            self.joinableCount = [x.prizesNumber integerValue];
            self.joinable = ![@(x.isJoin)boolValue];
            if([x.winList count] < 20) {
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
            return [self.apiManager podiumGroupShakeListWithId:self.groupId activityId:self.groupActivityId lastCount:self.list.count pageSize:20];
        }];
        [[[_moreCommand executionSignals] concat] subscribeNext:^(XPMainGroupShakeModel *x) {
            @strongify(self);
            self.list = [self.list arrayByAddingObjectsFromArray:x.winList];
            if([x.winList count] < 20) {
                self.finished = YES;
            }
        }];
        XPViewModelShortHand(_moreCommand);
    }
    
    return _moreCommand;
}

- (RACCommand *)shakeCommand
{
    if(_shakeCommand == nil) {
        @weakify(self);
        _shakeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            _win = NO;
            return [self.apiManager podiumGroupShakeWithId:self.groupId activityId:self.groupActivityId lastCount:self.list.count pageSize:20];
        }];
        [[[_shakeCommand executionSignals] concat] subscribeNext:^(XPMainGroupShakeModel *x) {
            @strongify(self);
            self.win = x.isWin;
        }];
        XPViewModelShortHand(_shakeCommand);
    }
    
    return _shakeCommand;
}

@end
