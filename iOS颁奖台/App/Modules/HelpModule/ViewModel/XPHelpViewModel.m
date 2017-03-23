//
//  XPHelpViewModel.m
//  XPApp
//
//  Created by xinpinghuang on 1/19/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPAPIManager+Help.h"
#import "XPHelpViewModel.h"

@interface XPHelpViewModel ()

@property (nonatomic, assign, readwrite) BOOL finished;
@property (nonatomic, strong, readwrite) RACCommand *submitCommand;
@property (nonatomic, strong, readwrite) RACSignal *submitValidSignal;
@property (nonatomic, strong, readwrite) RACCommand *helpCommand;
@property (nonatomic, strong, readwrite) NSString *helpURL;

@end

@implementation XPHelpViewModel

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
- (RACSignal *)submitValidSignal
{
    return [RACSignal combineLatest:@[RACObserve(self, content)] reduce:^id (NSString *content){
        return @(content.length > 0);
    }];
}

- (RACCommand *)submitCommand
{
    if(_submitCommand == nil) {
        @weakify(self);
        _submitCommand = [[RACCommand alloc] initWithEnabled:self.submitValidSignal signalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager feedbackWithContent:self.content];
        }];
        [[[_submitCommand executionSignals] concat] subscribeNext:^(id x) {
            @strongify(self);
            self.finished = YES;
        }];
        XPViewModelShortHand(_submitCommand);
    }
    
    return _submitCommand;
}

- (RACCommand *)helpCommand
{
    if(_helpCommand == nil) {
        @weakify(self);
        _helpCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager help];
        }];
        [[[_helpCommand executionSignals] concat] subscribeNext:^(id x) {
            @strongify(self);
            self.helpURL = x;
        }];
        XPViewModelShortHand(_helpCommand);
    }
    
    return _helpCommand;
}

@end
