//
//  XPAPIManager+Main.h
//  XPApp
//
//  Created by huangxinping on 15/10/16.
//  Copyright © 2015年 iiseeuu.com. All rights reserved.
//

#import "XPAPIManager.h"

@interface XPAPIManager (Main)

- (RACSignal *)podiumBanner;

// 活动列表
- (RACSignal *)podiumListWithLastCount:(NSInteger)lastCount pageSize:(NSInteger)pageSize longitude:(CGFloat)longitude latitude:(CGFloat)latitude;

// 加入群组
- (RACSignal *)podiumGroupAddWithId:(NSString *)groupId fromUserId:(NSString *)fromUserId;

// 群组列表
- (RACSignal *)podiumGroupListWithId:(NSString *)groupId lastCount:(NSInteger)lastCount pageSize:(NSInteger)pageSize;

// 群组获奖列表
- (RACSignal *)podiumGroupShakeListWithId:(NSString *)groupId activityId:(NSString *)activityId lastCount:(NSInteger)lastCount pageSize:(NSInteger)pageSize;

// 群组摇奖
- (RACSignal *)podiumGroupShakeWithId:(NSString *)groupId activityId:(NSString *)activityId lastCount:(NSInteger)lastCount pageSize:(NSInteger)pageSize;

// 非群组详情
- (RACSignal *)podiumPlainDetailWithId:(NSString *)podiumId;

// 非群组微信分享成功后上报
- (RACSignal *)podiumShareReportWithId:(NSString *)podiumId activityTitle:(NSString *)activityTitle activeSharePoint:(NSInteger)activeSharePoint;

// 非群组摇奖次数查询
- (RACSignal *)podiumPlainShakeNumberWithId:(NSString *)podiumId;

// 非群组积分兑换
- (RACSignal *)podiumPlainScoreExchangeWithId:(NSString *)podiumId exchangePoint:(NSInteger)exchangePoint activityTitle:(NSString *)activityTitle;

// 非群组摇奖
- (RACSignal *)podiumPlainShakeWithId:(NSString *)podiumId;

// 非群组摇奖结果
- (RACSignal *)podiumPlainShakeResultWithId:(NSString *)podiumId prizeId:(NSString *)prizeId userActivityId:(NSString *)userActivityId lastCount:(NSInteger)lastCount pageSize:(NSInteger)pageSize;
// 用户信息
- (RACSignal *)userInfo;

//天成修改 用户签到
- (RACSignal *)userSignIn;
/**
 *  用户活动参与（抽奖）
 */
- (RACSignal *)userActivityDraw;
/**
 *  获得用户奖金币 一类
 */
- (RACSignal *)podiumPlainRaffleNumberWith:(NSString *)podiumId;
/**
 *  抽奖活动
 */
- (RACSignal *)podiumPlainRaffleWithId:(NSString *)podiumId;
/**
 *  刮奖活动
 */
- (RACSignal *)podiumPlainScrapeWithId:(NSString *)podiumId;
@end
