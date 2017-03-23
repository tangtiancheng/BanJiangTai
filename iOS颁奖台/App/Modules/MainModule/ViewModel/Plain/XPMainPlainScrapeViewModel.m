//
//  XPMainPlainScrapeViewModel.m
//  XPApp
//
//  Created by 唐天成 on 16/4/3.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//


#import "XPMainPlainScrapeViewModel.h"
#import "XPAPIManager+Main.h"
#import "XPMainPlainShakeModel.h"

@interface XPMainPlainScrapeViewModel()
@property (nonatomic, strong, readwrite) XPMainPlainScrapeNumberModel *scrapeNumerModel;
@property (nonatomic, strong, readwrite) RACCommand *scrapeNumberCommand;
@property (nonatomic, strong, readwrite) RACCommand *scrapeCommand;
@property (nonatomic, strong, readwrite) XPMainPlainScrapeModel *scrapeModel;


//@property (nonatomic, strong, readwrite) NSString *prizeRule;
//@property (nonatomic, assign, readwrite) BOOL isWinning;
//
//@property (nonatomic, strong, readwrite) NSString *adImageURL;/**< 广告图片URL */
//@property (nonatomic, strong, readwrite) NSString *prizeImageURL;/**< 奖品图片URL */
//@property (nonatomic, strong, readwrite) NSString *prizeTitle;/**< 奖品名称 */
//@property (nonatomic, strong, readwrite) NSString *prizeGetTime;/**< 奖品领取时间 */
//
//@property (nonatomic, strong, readwrite) NSArray *resultList;
//@property (nonatomic, strong, readwrite) RACCommand *scrapeResultReloadCommand;
//@property (nonatomic, assign, readwrite) BOOL finished;

@end

@implementation XPMainPlainScrapeViewModel

- (RACCommand *)scrapeNumberCommand
{
    if(_scrapeNumberCommand == nil) {
        @weakify(self);
        _scrapeNumberCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager podiumPlainShakeNumberWithId:self.podiumId];
        }];
        [[[_scrapeNumberCommand executionSignals] concat] subscribeNext:^(XPMainPlainScrapeNumberModel *x) {
            @strongify(self);
            //                                    x.remainJoinNumber = 5;
            //            x.remainPoint = 50000;
            //            x.activeNumber = 0;
            //            x.remainJoinNumber = 1;
            
            self.scrapeNumerModel = x;
        }];
        XPViewModelShortHand(_scrapeNumberCommand);
    }
    
    return _scrapeNumberCommand;
}
- (RACCommand *)scrapeCommand
{
    if(_scrapeCommand == nil) {
        @weakify(self);
        _scrapeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager podiumPlainScrapeWithId:self.podiumId];
        }];
        [[[_scrapeCommand executionSignals] concat] subscribeNext:^(XPMainPlainScrapeModel* x) {
            @strongify(self);
            self.scrapeModel = x;
//            self.scrapeModel.isWinning=arc4random()%2;
//            self.scrapeModel.prizeGradeName=@"一等奖";
//            self.scrapeModel.prizeTitle=@"BOSE无线音箱无线音箱无";//奖品名称
//            self.scrapeModel.prizeCount=10;//奖品数量
        }];
        XPViewModelShortHand(_scrapeCommand);
    }
    
    return _scrapeCommand;
}
//- (RACCommand *)scrapeCommand
//{
//    if(_scrapeCommand == nil) {
//        @weakify(self);
//        _scrapeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//            @strongify(self);
//            return [[[self.apiManager podiumPlainShakeWithId:self.podiumId] doNext:^(id x) {
//                @strongify(self);
//                self.scrapeModel = x;
//            }] then:^RACSignal *{
//                return [self.apiManager podiumPlainShakeResultWithId:self.podiumId prizeId:self.scrapeModel.prizeId userActivityId:self.scrapeModel.userActivityId lastCount:0 pageSize:20];
//            }];
//        }];
//        
//        [[[_scrapeCommand executionSignals] concat] subscribeNext:^(XPMainPlainShakeResultModel* x) {
//            @strongify(self);
//            self.isWinning = YES;//[@(x.isWin)boolValue];
//            self.prizeRule = x.prizeRule;
//            self.resultList = x.winList;
//            self.adImageURL = x.downImageUrl;
//            self.prizeImageURL = x.upImageUrl;
//            self.prizeTitle = x.info;
//            self.prizeGetTime = x.receiveTime;
//            self.sponsor=x.sponsor;
//            if([x.winList count] < 20) {
//                self.finished = YES;
//            }
//        }];
//        XPViewModelShortHand(_scrapeResultReloadCommand);
//    }
//    
//    return _scrapeCommand;
//}
//- (RACCommand *)scrapeResultReloadCommand
//{
//    if(_scrapeResultReloadCommand == nil) {
//        @weakify(self);
//        _scrapeResultReloadCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//            @strongify(self);
//            return [self.apiManager podiumPlainShakeResultWithId:self.podiumId prizeId:self.scrapeModel.prizeId userActivityId:self.scrapeModel.userActivityId lastCount:0 pageSize:20];
//        }];
//        [[[_scrapeResultReloadCommand executionSignals] concat] subscribeNext:^(XPMainPlainShakeResultModel *x) {
//            @strongify(self);
//            self.isWinning = [@(x.isWin)boolValue];
//            self.prizeRule = x.prizeRule;
//            self.resultList = x.winList;
//            self.adImageURL = x.downImageUrl;
//            self.prizeImageURL = x.upImageUrl;
//            self.prizeTitle = x.info;
//            self.prizeGetTime = x.receiveTime;
//            if([x.winList count] < 20) {
//                self.finished = YES;
//            }
//        }];
//        XPViewModelShortHand(_scrapeResultReloadCommand);
//    }
//    
//    return _scrapeResultReloadCommand;
//}
@end
