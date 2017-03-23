//
//  XPMessageViewModel.m
//  XPApp
//
//  Created by xinpinghuang on 1/23/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPAPIManager+Message.h"
#import "XPMessageViewModel.h"

@interface XPMessageViewModel ()

@property (nonatomic, assign, readwrite) BOOL finished;
@property (nonatomic, strong, readwrite) NSArray *list;
@property (nonatomic, strong, readwrite) RACCommand *reloadCommand;
@property (nonatomic, strong, readwrite) RACCommand *moreCommand;

@property (nonatomic, assign, readwrite) BOOL readedFinished;
@property (nonatomic, strong, readwrite) RACCommand *readedCommand;

@end

@implementation XPMessageViewModel

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
            return [self.apiManager messageWithLastCount:0 pageSize:20];
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
            return [self.apiManager messageWithLastCount:self.list.count pageSize:20];
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

- (RACCommand *)readedCommand
{
    if(_readedCommand == nil) {
        @weakify(self);
        _readedCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager messageReadedWithId:self.messageId];
        }];
        [[[_readedCommand executionSignals] concat] subscribeNext:^(id x) {
            @strongify(self);
            self.readedFinished = YES;
        }];
        XPViewModelShortHand(_readedCommand);
    }
    
    return _readedCommand;
}

@end
