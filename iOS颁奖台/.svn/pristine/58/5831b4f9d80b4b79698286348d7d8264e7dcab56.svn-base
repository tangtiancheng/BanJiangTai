//
//  RaffleViewModel.m
//  XPApp
//
//  Created by Pua on 16/3/28.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "RaffleViewModel.h"
#import "RaffleModel.h"
#import "XPAPIManager+Main.h"
@interface RaffleViewModel()
@property (nonatomic , strong, readwrite)RaffleModel * raffleNumModel;
@property (nonatomic , strong, readwrite)RACCommand * raffleNumCommand;

@property (nonatomic , strong, readwrite) RaffleUserModel * raffleModel;
@property (nonatomic , strong, readwrite) RACCommand * raffleCommand;

@end

@implementation RaffleViewModel

-(instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}

-(RACCommand *)raffleNumCommand
{
    if (_raffleNumCommand == nil) {
        @weakify(self);
        _raffleNumCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager podiumPlainRaffleNumberWith:self.podiumId];
        }];
        [[[_raffleNumCommand executionSignals]concat]subscribeNext:^(RaffleModel *x) {
            @strongify(self);
            self.raffleNumModel = x;
            NSLog(@"%p",self);
        }];
        XPViewModelShortHand(_raffleNumCommand);;
    }
    return _raffleNumCommand;
}
-(RACCommand *)raffleCommand
{
    if (_raffleCommand == nil) {
        @weakify(self);
        _raffleCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return  [self.apiManager podiumPlainRaffleWithId:self.podiumId];
        }];
        [[[_raffleCommand executionSignals]concat]subscribeNext:^(id x) {
            @strongify(self);
            self.raffleModel = x;
        }];
        XPViewModelShortHand(_raffleCommand);
    }
    return _raffleCommand;
}

@end






