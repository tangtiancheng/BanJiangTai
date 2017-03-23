//
//  XPAwardViewModel.m
//  XPApp
//
//  Created by xinpinghuang on 1/20/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPAPIManager+Award.h"
#import "XPAwardModel.h"
#import "XPAwardViewModel.h"

@interface XPAwardViewModel ()

@property (nonatomic, assign, readwrite) BOOL finished;
@property (nonatomic, strong, readwrite) NSArray *list;
@property (nonatomic, strong, readwrite) RACCommand *reloadCommand;
@property (nonatomic, strong, readwrite) RACCommand *moreCommand;

@property (nonatomic, strong, readwrite) RACSignal *deliveryValidSignal;
@property (nonatomic, strong, readwrite) RACCommand *deliveryCommand;

@end

@implementation XPAwardViewModel

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
            return [self.apiManager awardWiteType:self.type lastCount:0 pageSize:20];
        }];
        [[[_reloadCommand executionSignals] concat] subscribeNext:^(XPAwardModel *x) {
            @strongify(self);
            self.kuaidi100 = x.expressUrl;
            self.list = x.myprizelist;
            if([x.myprizelist count] < 20) {
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
            return [self.apiManager awardWiteType:self.type lastCount:self.list.count pageSize:20];
        }];
        [[[_moreCommand executionSignals] concat] subscribeNext:^(XPAwardModel *x) {
            @strongify(self);
            self.kuaidi100 = x.expressUrl;
            self.list = [self.list arrayByAddingObjectsFromArray:x.myprizelist];
            if([x.myprizelist count] < 20) {
                self.finished = YES;
            }
        }];
        XPViewModelShortHand(_moreCommand);
    }
    
    return _moreCommand;
}

- (RACCommand *)deliveryCommand
{
    if(_deliveryCommand == nil) {
        @weakify(self);
        _deliveryCommand = [[RACCommand alloc] initWithEnabled:self.deliveryValidSignal signalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager awardDeliveryWithId:self.awardId addressId:self.addressId date:self.deliveryDate time:self.deliveryTime];
        }];
        [[[_deliveryCommand executionSignals] concat] subscribeNext:^(id x) {
            @strongify(self);
            self.finished = YES;
        }];
        XPViewModelShortHand(_deliveryCommand);
    }
    
    return _deliveryCommand;
}

- (RACSignal *)deliveryValidSignal
{
    return [RACSignal combineLatest:@[RACObserve(self, awardId), RACObserve(self, addressId), RACObserve(self, deliveryDate), RACObserve(self, deliveryTime)] reduce:^id (NSString *awardId, NSString *addressId, NSString *deliveryDate, NSString *deliveryTime){
        return @(awardId && addressId && deliveryDate && deliveryTime);
    }];
}

@end
