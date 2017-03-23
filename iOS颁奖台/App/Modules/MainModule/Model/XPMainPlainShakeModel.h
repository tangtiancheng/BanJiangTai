//
//  XPMainPlainShakeModel.h
//  XPApp
//
//  Created by xinpinghuang on 1/25/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPBaseModel.h"

@interface XPMainPlainShakeNumberModel : XPBaseModel

//@property NSInteger activeNumber;
//@property NSInteger exchangePoint;
//@property NSInteger remainJoinNumber;
//@property NSInteger remainPoint;

@property NSString  *activeRuleUrl;//活动规则url
@property NSInteger activeJoinNum;//活动可以参与的次数，-1表示 不限制
@property NSInteger exchangePoint;//参与活动所需要的金币数
@property NSInteger totalActiveNum;//用户当天总共参与该活动数
@property NSInteger remainPoint;//剩余金币数
@property NSString *pointsRule;//如何获得奖金币url
@property NSInteger todayActiveNum;//今天参与该活动的次数

@end

@interface XPMainPlainShakeModel : XPBaseModel

@property NSString *podiumId;
@property NSString *prizeId;
@property NSString *sponsor;
@property NSString *userActivityId;

@end

@protocol XPMainPlainShakeResultPeopleModel <NSObject>
@end
@interface XPMainPlainShakeResultPeopleModel : XPBaseModel

@property NSString *winId;
@property NSString *winners;
@property NSString *winningDate;

@end

@interface XPMainPlainShakeResultModel : XPBaseModel

@property NSString *downImageUrl;
@property NSString *info;
@property NSInteger isWin;
@property NSString *podiumId;
@property NSString *prizeRule;
@property NSString *receiveTime;
@property NSString *sponsor;
@property NSString *title;
@property NSString *upImageUrl;
@property NSArray<XPMainPlainShakeResultPeopleModel> *winList;

@end
