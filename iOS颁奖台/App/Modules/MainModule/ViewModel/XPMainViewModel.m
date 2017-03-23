//
//  XPMainViewModel.m
//  XPApp
//
//  Created by huangxinping on 15/10/16.
//  Copyright © 2015年 iiseeuu.com. All rights reserved.
//

#import "JPUSHService.h"
#import "XPAPIManager+Main.h"
#import "XPLoginModel.h"
#import "XPMainViewModel.h"
#import "XPMotionManager.h"
#import "XPMainModel.h"
#import "XPSingleton.h"

@interface XPMainViewModel ()

@property (nonatomic, assign, readwrite) BOOL finished;
@property (nonatomic, strong, readwrite) NSArray *list;
@property (nonatomic, strong, readwrite) NSArray *banners;
@property (nonatomic, strong, readwrite) RACCommand *reloadCommand;
@property (nonatomic, strong, readwrite) RACCommand *moreCommand;

@property (nonatomic, strong, readwrite) RACCommand *userInfoCommand;
@property (nonatomic, strong, readwrite) RACCommand *signInCommand;
@property (nonatomic, strong,readwrite)  RACCommand *UserActivityCommandDraw;
@property (nonatomic, strong, readwrite) XPMainSignInModel* signInModel;
@property (nonatomic, assign, readwrite) BOOL groupJoinFinished;
@property (nonatomic, strong, readwrite) RACCommand *groupJoinCommand;

@end

@implementation XPMainViewModel

#pragma mark - LifeCircle
- (instancetype)init
{
    if((self = [super init])) {
    }
    
    return self;
}

#pragma mark - Getter && Setter
- (RACCommand *)reloadCommand
{
    if(_reloadCommand == nil) {
        @weakify(self);
        _reloadCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [[[self.apiManager podiumBanner] doNext:^(id x) {
                @strongify(self);
                self.banners = x;
            }] then:^RACSignal *{
                @strongify(self);
                return [self.apiManager podiumListWithLastCount:0 pageSize:20 longitude:[XPMotionManager sharedInstance].location.coordinate.latitude latitude:[XPMotionManager sharedInstance].location.coordinate.longitude];
            }];
        }];
        [[[_reloadCommand executionSignals] concat] subscribeNext:^(XPMainDataModel *x) {
            @strongify(self);
            NSLog(@"%@   %p",x,x);
            //plain数组
            self.list = x.podiumList;
            //是否签到
            self.isSignIn=x.isSignIn;
            //单例 是否登陆
            [XPSingleton shareSingleton].isSignIn=x.isSignIn;
            //已经连续签到的天数
            self.continuousDays=x.continuousDays;
             //单例 已经连续签到的天数
            [XPSingleton shareSingleton].continuousDays=x.continuousDays;
            //要求要达到的连续签到天数
            self.continuousTotalDays=x.continuousTotalDays;
            //单例 要求要达到的连续签到天数
            [XPSingleton shareSingleton].continuousTotalDays=x.continuousTotalDays;
            //此次签到获得的金币数
            self.signCoinNum=x.signCoinNum;
            //单例 获得金币数
            [XPSingleton shareSingleton].signCoinNum=x.signCoinNum;
           
            if([x.podiumList count] < 20) {
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
            return [self.apiManager podiumListWithLastCount:self.list.count pageSize:20 longitude:[XPMotionManager sharedInstance].location.coordinate.latitude latitude:[XPMotionManager sharedInstance].location.coordinate.longitude];
        }];
        [[[_moreCommand executionSignals] concat] subscribeNext:^(XPMainDataModel *x) {
            @strongify(self);
            self.list = [self.list arrayByAddingObjectsFromArray:x.podiumList];
            //是否签到
            self.isSignIn=x.isSignIn;
            //此次签到获得的金币数
            self.signCoinNum=x.signCoinNum;
            //单例 是否登陆
            [XPSingleton shareSingleton].isSignIn=x.isSignIn;
            //单例 获得金币数
            [XPSingleton shareSingleton].signCoinNum=x.signCoinNum;
            //已经连续签到的天数
            self.continuousDays=x.continuousDays;
            //单例 已经连续签到的天数
            [XPSingleton shareSingleton].continuousDays=x.continuousDays;
            //要求要达到的连续签到天数
            self.continuousTotalDays=x.continuousTotalDays;
            //单例 要求要达到的连续签到天数
            [XPSingleton shareSingleton].continuousTotalDays=x.continuousTotalDays;

            //如果返回的数量少于20条,则证明服务端数据已经没有了,让self.finished=YES;
            if([x.podiumList count] < 20) {
                self.finished = YES;
            }
        }];
        XPViewModelShortHand(_moreCommand);
    }
    
    return _moreCommand;
}

- (RACCommand *)userInfoCommand
{
    if(!_userInfoCommand) {
        @weakify(self);
        _userInfoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager userInfo];
        }];
        [[[_userInfoCommand executionSignals] concat] subscribeNext:^(XPLoginModel *x) {
            //            XPLogError(@"%@", x);
            NSSet *tags = nil;
            if(x.groupIds && ![x.groupIds isEqualToString:@""]) {
                NSArray *groupIds = [x.groupIds componentsSeparatedByString:@","];
                tags = [NSSet setWithArray:groupIds];
            }
            
            [JPUSHService setTags:tags alias:x.accessToken fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                XPLog(@"%@", iAlias);
            }];
        }];
        XPViewModelShortHand(_userInfoCommand);
    }
    
    return _userInfoCommand;
}

//天成修改  签到的commend
- (RACCommand*)signInCommand{
    if(!_signInCommand){
        @weakify(self)
        _signInCommand=[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager userSignIn];
        }];
        
        [[[_signInCommand executionSignals] concat] subscribeNext:^(XPMainSignInModel *x) {
            @strongify(self);
            self.signInModel = x;
            //单例
            [XPSingleton shareSingleton].continuousDays=x.continuousDays;
            [XPSingleton shareSingleton].continuousTotalDays=x.continuousTotalDays;
//            [[NSUserDefaults standardUserDefaults]setObject:x.continuousDays forKey:@"continuousDays"];
//            [[NSUserDefaults standardUserDefaults]setObject:x.continuousTotalDays forKey:@"continuousTotalDays"];
            NSLog(@"%@",x);
        }];
        XPViewModelShortHand(_signInCommand);
    }
    
    
    return _signInCommand;
    
}

- (RACCommand *)UserActivityDraw

{
    return _UserActivityCommandDraw;
}
- (RACCommand *)groupJoinCommand
{
    if(!_groupJoinCommand) {
        @weakify(self);
        _groupJoinCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager podiumGroupAddWithId:self.groupId fromUserId:self.fromUserId];
        }];
        [[[_groupJoinCommand executionSignals] concat] subscribeNext:^(id x) {
            @strongify(self);
            self.groupJoinFinished = @(YES);
        }];
        XPViewModelShortHand(_groupJoinCommand);
    }
    
    return _groupJoinCommand;
}

@end
