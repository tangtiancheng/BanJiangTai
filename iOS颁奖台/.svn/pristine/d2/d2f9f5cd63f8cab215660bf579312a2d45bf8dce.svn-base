//
//  XPMainPlainScrapeModel.h
//  XPApp
//
//  Created by 唐天成 on 16/4/3.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "XPBaseModel.h"

@interface XPMainPlainScrapeModel : XPBaseModel

@property NSString *podiumId;
//奖品ID
@property NSString *prizeId;
//主办方
@property NSString *sponsor;

@property NSString *userActivityId;
/**
 *  活动开奖时间
 */
@property NSString *publishTime;

@property NSInteger isWinning;//是否中奖
@property NSString *prizeGradeName;//奖项名称
@property NSString *prizeTitle;//奖品名称
@property NSInteger prizeCount;//奖品数量

@end


@interface XPMainPlainScrapeNumberModel : XPBaseModel

//@property NSInteger activeNumber;
//@property NSInteger exchangePoint;
//@property NSInteger remainJoinNumber;
//@property NSInteger remainPoint;
@property NSString  *activeRuleUrl;//活动规则url
@property NSInteger activeJoinNum;//活动可以参与的次数，-1表示 不限制
@property NSInteger exchangePoint;//参与活动所需要的金币数
@property NSInteger totalActiveNum;//用户当天总共参与活动数..暂时没用到
@property NSInteger remainPoint;//剩余金币数
@property NSString *pointsRule;//如何获得奖金币url
/**
 *  今天参与该活动的次数
 */
@property NSInteger todayActiveNum;
@end



