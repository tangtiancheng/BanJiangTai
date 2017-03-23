//
//  XPPointsModel.h
//  XPApp
//
//  Created by xinpinghuang on 1/19/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPBaseModel.h"

@protocol XPPointItemModel <NSObject>
@end
@interface XPPointItemModel : XPBaseModel

@property NSString *name;
@property NSInteger points;
@property NSString *pointsId;
@property NSInteger pointsStatus;
@property NSString *time;

@end

@interface XPPointsModel : XPBaseModel

@property NSInteger myPoints;
@property NSString *pointsRule;
@property NSArray<XPPointItemModel> *pointslist;

@end
