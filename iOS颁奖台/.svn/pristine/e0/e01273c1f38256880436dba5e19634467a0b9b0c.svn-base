//
//  XPMainPlainViewModel.m
//  XPApp
//
//  Created by xinpinghuang on 1/24/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPAPIManager+Main.h"
#import "XPMainPlainViewModel.h"

@interface XPMainPlainViewModel ()

@property (nonatomic, strong, readwrite) RACCommand *detailCommand;
@property (nonatomic, strong, readwrite) XPMainPlainModel *model;

@property (nonatomic, strong, readwrite) RACCommand *shareReportCommand;

@end

@implementation XPMainPlainViewModel

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
- (RACCommand *)detailCommand
{
    if(_detailCommand == nil) {
        @weakify(self);
        _detailCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager podiumPlainDetailWithId:self.podiumId];
        }];
        [[[_detailCommand executionSignals] concat] subscribeNext:^(id x) {
            @strongify(self);
            self.model = x;

        }];
        XPViewModelShortHand(_detailCommand);
    }
    
    return _detailCommand;
}

- (RACCommand *)shareReportCommand
{
    if(_shareReportCommand == nil) {
        @weakify(self);
        _shareReportCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager podiumShareReportWithId:self.podiumId activityTitle:self.activityTitle activeSharePoint:self.activeSharePoint];
        }];
        XPViewModelShortHand(_shareReportCommand);
    }
    
    return _shareReportCommand;
}

@end
