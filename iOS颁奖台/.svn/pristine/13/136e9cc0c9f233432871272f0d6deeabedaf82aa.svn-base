//
//  XPActivityViewModel.m
//  XPApp
//
//  Created by xinpinghuang on 1/11/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPAPIManager+Activity.h"
#import "XPActivityViewModel.h"

@interface XPActivityViewModel ()

@property (nonatomic, assign, readwrite) BOOL finished;
@property (nonatomic, strong, readwrite) NSArray *list;
@property (nonatomic, strong, readwrite) RACCommand *reloadCommand;
@property (nonatomic, strong, readwrite) RACCommand *moreCommand;

@end

@implementation XPActivityViewModel

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
            return [self.apiManager activityWithLastCount:0 pageSize:20];
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
            return [self.apiManager activityWithLastCount:self.list.count pageSize:20];
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

@end
