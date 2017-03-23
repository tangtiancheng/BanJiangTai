//
//  XPMainPlainModel.h
//  XPApp
//
//  Created by xinpinghuang on 1/24/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPBaseModel.h"
//天成添加
@protocol XPMainPlainPrizeModel<NSObject>
@end



@interface  XPMainPlainPrizeModel: XPBaseModel

@property NSString *prizeGradeName;//奖项名称
@property NSString *prizeTitle;//奖品名称
@property NSInteger prizeCount;//奖品数量

@end


@interface XPMainPlainModel : XPBaseModel

@property NSInteger activeSharePoint;//分享获得金币数
@property NSString *activityIntro;//活动简介
@property NSString *endDate;//活动结束日期
@property NSString *endTime;//活动结束时间
@property NSArray *imageList;//活动图片数组
@property NSInteger joinNumber;//当日参与该活动次数
@property NSInteger joinTotal;//活动能参加总次数（未登陆状态返回0
@property NSString *podiumId;//活动ID
@property NSString *prizeCount;//活动奖品数量
@property NSString *prizeRule;//奖品领取规则(规则URL)
@property NSString *prizeTitle;//活动奖品名称
@property NSInteger requestServerTimeStamp;//接口反馈时间戳：服务器当前时间
@property NSString *shareContent;//分享内容
@property NSString *shareImage;//分享图片
@property NSInteger shareNumber;//当前分享了多少次
@property NSInteger shareTotal;//活动能分享总次数
@property NSString *shareUrl;//分享H5url
@property NSString *sponsor;//发起活动商家名称
@property NSString *startDate;//活动开始日期
@property NSString *startTime;//活动开始时间
@property NSInteger startTimeStamp;//活动开始时间，时间戳（Unix时间戳）
@property NSInteger stopTimeStamp;//活动结束时间，时间戳（Unix时间戳）
@property NSString *title;//活动名称
@property NSString *activityType;//活动类型
@property NSString *eligibility;//参与资格
@property NSArray<XPMainPlainPrizeModel> *prizeList;//奖项数组
@property NSString *shareTitle;//微信分享标题
@end




