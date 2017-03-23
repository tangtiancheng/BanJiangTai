//
//  XPAddressViewModel.m
//  XPApp
//
//  Created by xinpinghuang on 1/8/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "NSString+XPValid.h"
#import "XPAPIManager+Address.h"
#import "XPAddressViewModel.h"
#import "XPLoginModel.h"
#import "XPRegionEntity.h"

@interface XPAddressViewModel ()

@property (nonatomic, assign, readwrite) BOOL finished;

#pragma mark - 新增地址
@property (nonatomic, strong, readwrite) RACCommand *createCommand;
@property (nonatomic, strong, readwrite) RACSignal *createValidSignal;

#pragma mark - 更新地址
@property (nonatomic, strong, readwrite) RACCommand *updateCommand;

@property (nonatomic, strong, readwrite) RACCommand *deleteCommand;

#pragma mark - 地址列表
@property (nonatomic, strong, readwrite) NSArray *list;
@property (nonatomic, strong, readwrite) RACCommand *reloadCommand;
@property (nonatomic, strong, readwrite) RACCommand *moreCommand;

@end

@implementation XPAddressViewModel

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
            return [self.apiManager addressWithLastCount:0 pageSize:20];
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
            return [self.apiManager addressWithLastCount:self.list.count pageSize:20];
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

- (RACSignal *)createValidSignal
{
    return [RACSignal combineLatest:@[RACObserve(self, recipient), RACObserve(self, phone), RACObserve(self, region_0), RACObserve(self, region_1), RACObserve(self, region_2), RACObserve(self, addressDetail)] reduce:^id (NSString *recipient, NSString *phone, XPRegionEntity *region_0, XPRegionEntity *region_1, XPRegionEntity *region_2, NSString *addressDetail){
        return @(
        recipient.length > 0 &&
        [phone isPhone] &&
        region_0 &&
        region_1 &&
        region_2 &&
        addressDetail.length > 0);
    }];
}

- (RACCommand *)createCommand
{
    if(_createCommand == nil) {
        @weakify(self);
        _createCommand = [[RACCommand alloc] initWithEnabled:self.createValidSignal signalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager addressCreateWithRecipient:self.recipient phone:self.phone proinceId:self.region_0.id cityId:self.region_1.id areaId:self.region_2.id addressInfo:self.addressDetail isDefault:self.defaultAddress];
        }];
        [[[_createCommand executionSignals] concat] subscribeNext:^(XPAddressBackModel *x) {
            @strongify(self);
            [XPLoginModel singleton].isAddress = x.isHaveDefault;
            self.finished = YES;
        }];
        XPViewModelShortHand(_createCommand);
    }
    
    return _createCommand;
}

- (RACCommand *)updateCommand
{
    if(_updateCommand == nil) {
        @weakify(self);
        _updateCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager addressUpdateWithAddressId:self.addressId recipient:self.recipient phone:self.phone proinceId:self.region_0.id cityId:self.region_1.id areaId:self.region_2.id addressInfo:self.addressDetail isDefault:self.defaultAddress];
        }];
        [[[_updateCommand executionSignals] concat] subscribeNext:^(XPAddressBackModel *x) {
            @strongify(self);
            [XPLoginModel singleton].isAddress = x.isHaveDefault;
            self.finished = YES;
        }];
        XPViewModelShortHand(_updateCommand);
    }
    
    return _updateCommand;
}

- (RACCommand *)deleteCommand
{
    if(_deleteCommand == nil) {
        @weakify(self);
        _deleteCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager addressDeleteWithAddressId:self.addressId];
        }];
        [[[_deleteCommand executionSignals] concat] subscribeNext:^(id x) {
            @strongify(self);
            self.finished = YES;
        }];
        XPViewModelShortHand(_deleteCommand);
    }
    
    return _deleteCommand;
}

@end
