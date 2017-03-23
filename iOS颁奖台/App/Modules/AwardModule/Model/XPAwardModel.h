//
//  XPAwardModel.h
//  XPApp
//
//  Created by xinpinghuang on 1/20/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPBaseModel.h"

@protocol XPAwardItemModel <NSObject>
@end

@interface XPAwardItemModel : XPBaseModel

@property NSString *expressCode;//快递公司编码  无则空  有则给值
@property NSString *expressNumbers;//快递单号  无则空  有则给值
@property NSInteger isGroup;//是否为群组(0:非群组，1群组)
@property NSString *obtainTime;//中奖时间
@property NSString *prizeId;//奖品ID
@property NSString *prizeName;//获奖的奖品名称
@property NSString *ownerUserId;//券的所属用户标识，无则空  有则给值
@property NSString *prizeStatus;//奖品状态：0无(表示是群组)、N带领取、W未配送、P配送中、S待使用
@property NSString *sponsor;//主办方
@property NSString *businessUrl;//商家图片

@property NSString *lotteryId;//如果是代金券，为券码，无则空  有则给值
@property NSString *title;//标题
@property NSString *effectiveDateBegin;//券的有效开始日期，无则空  有则给值
@property NSString *effectiveDateEnd;//券的有效结束日期，无则空  有则给值

@property NSString *imageUrl;//图片地址

@end

@interface XPAwardModel : XPBaseModel

@property NSString *expressUrl;
@property NSArray<XPAwardItemModel> *myprizelist;

@end
