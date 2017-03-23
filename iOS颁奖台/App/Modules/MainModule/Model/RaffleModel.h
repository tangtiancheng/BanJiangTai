//
//  RaffleModel.h
//  XPApp
//
//  Created by Pua on 16/3/28.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "XPBaseModel.h"

@interface RaffleModel : XPBaseModel

/**
 *  用户总共参与活动次数
 */
@property NSInteger totalActiveNum;
/**
 *  用户剩余积分
 */
@property NSInteger remainPoint;
/**
 *  参与活动所需要的金币数
 */
@property NSInteger exchangePoint;
/**
 *  活动规则url
 */
@property NSString *activeRuleUrl;
/**
 *  活动可以参与的次数，-1表示 不限制
 */
@property NSInteger activeJoinNum;
/**
 *  金币规则
 */
@property NSString* pointsRule;

/**
 *  今天参与该活动的次数
 */
@property NSInteger todayActiveNum;
@end

@interface RaffleUserModel : XPBaseModel

@property NSString *podiumId;
@property NSString *prizeId;
@property NSString *sponsor;
@property NSString *userActivityId;
/**
 *  活动开奖时间
 */
@property NSString *publishTime;

@end



