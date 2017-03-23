//
//  XPMainGroupShakeModel.h
//  XPApp
//
//  Created by xinpinghuang on 1/24/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPBaseModel.h"

@protocol XPMainGroupShakePeopleModel <NSObject>
@end
@interface XPMainGroupShakePeopleModel : XPBaseModel

@property NSString *imageUrl;
@property NSString *prizesName;
@property NSString *userId;
@property NSString *userName;

@end

@interface XPMainGroupShakeModel : XPBaseModel

@property NSInteger isWin;
@property NSString *endDate;
@property NSString *endTime;
@property NSString *groupActivityId;
@property NSString *groupActivityName;
@property NSString *groupId;
@property NSInteger isJoin;
@property NSString *prizesNumber;
@property NSInteger requestServerTimeStamp;
@property NSString *sendPersonalName;
@property NSString *startDate;
@property NSString *startTime;
@property NSArray<XPMainGroupShakePeopleModel> *winList;
@property NSInteger winNumber;

@end
