//
//  XPMainModel.h
//  XPApp
//
//  Created by xinpinghuang on 1/23/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPBaseModel.h"
@protocol XPMainModel<NSObject>

@end

@interface XPMainBannerModel : XPBaseModel

@property NSString *activeId;
@property NSString *endDate;
@property NSString *endTime;
@property NSString *imageUrl;
@property NSString *sponsor;
@property NSString *startDate;
@property NSString *startTime;

@end

@interface XPMainModel : XPBaseModel

@property NSString *title;
@property NSString *endDate;
@property NSString *endTime;
@property NSString *groupId;
@property NSString *imageUrl;
@property NSInteger noticeTag;
@property NSString *podiumId;
@property NSString *sponsor;
@property NSString *startDate;
@property NSString *startTime;
@property NSString *lotteryType;


@end

@interface XPMainDataModel : XPBaseModel
//tc修改
@property NSInteger isSignIn;
@property NSInteger signCoinNum;
@property NSString* continuousDays;
@property NSString* continuousTotalDays;
@property NSArray<XPMainModel> *podiumList;
@end


@interface XPMainSignInModel : XPBaseModel
@property NSString *signDays;//签到日期
@property NSString *isContinuous;//是否达到要求的连续签到日期
@property NSString *dayGolds;//每日签到获得的金币数
@property NSString *continuousTotalDays;//要求要达到的连续签到天数
@property NSString *continuousDays;//已经连续签到的天数
@property NSString *continuousGolds;//达到连续签到的天数的额外给的金币数
@end

