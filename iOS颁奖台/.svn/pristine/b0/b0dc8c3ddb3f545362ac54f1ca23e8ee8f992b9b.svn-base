//
//  XPPointsViewModel.m
//  XPApp
//
//  Created by xinpinghuang on 1/11/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPAPIManager+Points.h"
#import "XPPointsModel.h"
#import "XPPointsViewModel.h"

@interface XPPointsViewModel ()

@property (nonatomic, strong, readwrite) NSArray *list;
@property (nonatomic, strong, readwrite) RACCommand *reloadCommand;
@property (nonatomic, strong, readwrite) RACCommand *moreCommand;
@property (nonatomic, assign, readwrite) BOOL loadFinished;
@property (nonatomic, strong, readwrite) NSString *ruleURL;
@property (nonatomic, assign, readwrite) NSInteger myPoints;

@end

@implementation XPPointsViewModel

#pragma mark - Life Circle
- (instancetype)init
{
    if(self = [super init]) {
        _loadFinished = NO;
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
            return [self.apiManager pointWithLastCount:0 pageSize:20];
        }];
        [[[_reloadCommand executionSignals] concat] subscribeNext:^(XPPointsModel *x) {
            @strongify(self);
            self.list = x.pointslist;
            self.ruleURL = x.pointsRule;
            self.myPoints = x.myPoints;
            if(x.pointslist.count < 20) {
                self.loadFinished = YES;
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
            return [self.apiManager pointWithLastCount:self.list.count pageSize:20];
        }];
        [[[_moreCommand executionSignals] concat] subscribeNext:^(XPPointsModel *x) {
            @strongify(self);
            self.list = [self.list arrayByAddingObjectsFromArray:x.pointslist];
            if(!x.pointslist.count) {
                self.loadFinished = YES;
            }
        }];
        XPViewModelShortHand(_moreCommand);
    }
    
    return _moreCommand;
}

@end
