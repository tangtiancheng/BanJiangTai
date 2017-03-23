//
//  TasteViewModel.m
//  XPApp
//
//  Created by Pua on 16/5/17.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "TasteViewModel.h"
#import "XPAPIManager+TasteMain.h"
#import "TasteMainModel.h"
@interface TasteViewModel()

@property (nonatomic, assign, readwrite) BOOL finished;
@property (nonatomic, strong, readwrite) NSArray *list;
@property (nonatomic, strong, readwrite) NSArray *banners;
@property (nonatomic, strong, readwrite) RACCommand *reloadCommand;
@property (nonatomic, strong, readwrite) RACCommand *moreCommand;
@end

@implementation TasteViewModel

#pragma mark - LifeCircle
- (instancetype)init
{
    if((self = [super init])) {
    }
    
    return self;
}
#pragma mark - Getter && Setter
-(RACCommand *)reloadCommand
{
    if (_reloadCommand == nil) {
        @weakify(self);
        _reloadCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [[[self.apiManager tasteBanner]doNext:^(id x) {
                @strongify(self);
                self.banners = x;
            }]then:^RACSignal *{
                @strongify(self);
                return [self.apiManager tasteListWithLastCount:0 pageSize:20 longitude:0 latitude:0 storeName:self.storeName dishName:self.dishName avgPrice:self.avgPrice storeTag:self.storeTag storeType:self.storeType storeArea:self.storeArea];
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
         return [self.apiManager tasteListWithLastCount:self.list.count pageSize:20 longitude:0 latitude:0 storeName:self.storeName dishName:self.dishName avgPrice:self.avgPrice storeTag:self.storeTag storeType:self.storeType storeArea:self.storeArea];
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






