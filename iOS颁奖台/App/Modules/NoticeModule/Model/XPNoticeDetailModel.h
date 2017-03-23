//
//  XPNoticeDetailModel.h
//  XPApp
//
//  Created by xinpinghuang on 1/22/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPBaseModel.h"

@protocol XPNoticeDetailItemModel <NSObject>
@end
@interface XPNoticeDetailItemModel : XPBaseModel

@property NSString *winId;
@property NSString *winners;
@property NSString *winningDate;

@end

@interface XPNoticeDetailModel : XPBaseModel

@property NSString *imageUrl;
@property NSArray<XPNoticeDetailItemModel> *list;
@property NSString *prizeRule;

@end
