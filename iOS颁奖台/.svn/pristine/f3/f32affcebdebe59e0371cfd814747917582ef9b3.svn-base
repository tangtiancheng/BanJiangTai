//
//  XPMainPlainShakeViewModel.m
//  XPApp
//
//  Created by xinpinghuang on 1/25/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPAPIManager+Main.h"
#import "XPMainPlainShakeModel.h"
#import "XPMainPlainShakeViewModel.h"

@interface XPMainPlainShakeViewModel ()

@property (nonatomic, strong, readwrite) XPMainPlainShakeNumberModel *shakeNumerModel;
@property (nonatomic, strong, readwrite) RACCommand *shakeNumberCommand;
@property (nonatomic, strong, readwrite) RACCommand *scoreExchangeCommand;

@property (nonatomic, strong, readwrite) RACCommand *shakeCommand;
@property (nonatomic, strong, readwrite) XPMainPlainShakeModel *shakeModel;

@property (nonatomic, strong, readwrite) NSString *prizeRule;
@property (nonatomic, assign, readwrite) BOOL isWinning;

@property (nonatomic, strong, readwrite) NSString *adImageURL;/**< 广告图片URL */
@property (nonatomic, strong, readwrite) NSString *prizeImageURL;/**< 奖品图片URL */
@property (nonatomic, strong, readwrite) NSString *prizeTitle;/**< 奖品名称 */
@property (nonatomic, strong, readwrite) NSString *prizeGetTime;/**< 奖品领取时间 */

@property (nonatomic, strong, readwrite) NSArray *resultList;
@property (nonatomic, strong, readwrite) RACCommand *shakeResultReloadCommand;
@property (nonatomic, strong, readwrite) RACCommand *shakeResultMoreCommand;

@property (nonatomic, assign, readwrite) BOOL finished;
@end

@implementation XPMainPlainShakeViewModel

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
- (RACCommand *)shakeNumberCommand
{
    if(_shakeNumberCommand == nil) {
        @weakify(self);
        _shakeNumberCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager podiumPlainShakeNumberWithId:self.podiumId];
        }];
        [[[_shakeNumberCommand executionSignals] concat] subscribeNext:^(XPMainPlainShakeNumberModel *x) {
            @strongify(self);
            //                                    x.remainJoinNumber = 5;
            //            x.remainPoint = 50000;
            //            x.activeNumber = 0;
            //            x.remainJoinNumber = 1;
            self.shakeNumerModel = x;
        }];
        XPViewModelShortHand(_shakeNumberCommand);
    }
    
    return _shakeNumberCommand;
}

- (RACCommand *)scoreExchangeCommand
{
    if(_scoreExchangeCommand == nil) {
        @weakify(self);
        _scoreExchangeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager podiumPlainScoreExchangeWithId:self.podiumId exchangePoint:self.shakeNumerModel.exchangePoint activityTitle:self.activeTitle];
        }];
        [[[_scoreExchangeCommand executionSignals] concat] subscribeNext:^(XPMainPlainShakeNumberModel *x) {
            @strongify(self);
            self.shakeNumerModel = x;
            [self.shakeCommand execute:nil];
        }];
        XPViewModelShortHand(_scoreExchangeCommand);
    }
    
    return _scoreExchangeCommand;
}

- (RACCommand *)shakeCommand
{
    if(_shakeCommand == nil) {
        @weakify(self);
        _shakeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager podiumPlainShakeWithId:self.podiumId];
        }];
        [[[_shakeCommand executionSignals] concat] subscribeNext:^(id x) {
            @strongify(self);
            // 本地将活动参与次数、本活动能参与次数-1
//            self.shakeNumerModel.remainJoinNumber -= 1;
//            self.shakeNumerModel.activeNumber -= 1;
            self.shakeModel = x;
        }];
        XPViewModelShortHand(_shakeCommand);
    }
    
    return _shakeCommand;
}

- (RACCommand *)shakeResultReloadCommand
{
    if(_shakeResultReloadCommand == nil) {
        @weakify(self);
        _shakeResultReloadCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager podiumPlainShakeResultWithId:self.podiumId prizeId:self.shakeModel.prizeId userActivityId:self.shakeModel.userActivityId lastCount:0 pageSize:20];
        }];
        [[[_shakeResultReloadCommand executionSignals] concat] subscribeNext:^(XPMainPlainShakeResultModel *x) {
            @strongify(self);
            
            self.prizeRule = x.prizeRule;
            self.resultList = x.winList;
            self.adImageURL = x.downImageUrl;
            self.prizeImageURL = x.upImageUrl;
            self.prizeTitle = x.info;
            self.prizeGetTime = x.receiveTime;
            self.isWinning = [@(x.isWin)boolValue];
            
//            self.prizeRule = x.prizeRule;
//            self.resultList = x.winList;
//            self.adImageURL = x.downImageUrl;
//            self.prizeImageURL = x.upImageUrl;
//            self.prizeTitle = @"nihao";
//            self.isWinning = @YES;
//            self.prizeGetTime = x.receiveTime;
            if([x.winList count] < 20) {
                self.finished = YES;
            }
        }];
        XPViewModelShortHand(_shakeResultReloadCommand);
    }
    
    return _shakeResultReloadCommand;
}

- (RACCommand *)shakeResultMoreCommand
{
    if(_shakeResultMoreCommand == nil) {
        @weakify(self);
        _shakeResultMoreCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager podiumPlainShakeResultWithId:self.podiumId prizeId:self.shakeModel.prizeId userActivityId:self.shakeModel.userActivityId lastCount:self.resultList.count pageSize:20];
        }];
        [[[_shakeResultReloadCommand executionSignals] concat] subscribeNext:^(XPMainPlainShakeResultModel *x) {
            @strongify(self);
            self.resultList = [self.resultList arrayByAddingObjectsFromArray:x.winList];
            if([x.winList count] < 20) {
                self.finished = YES;
            }
        }];
        XPViewModelShortHand(_shakeResultMoreCommand);
    }
    
    return _shakeResultMoreCommand;
}

@end
