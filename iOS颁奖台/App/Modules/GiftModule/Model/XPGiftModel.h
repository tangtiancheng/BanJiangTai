//
//  XPGiftModel.h
//  XPApp
//
//  Created by xinpinghuang on 1/21/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPBaseModel.h"

@interface XPGiftModel : XPBaseModel

@property(nonatomic,copy) NSString *activeTitle;
@property(nonatomic,copy) NSString *groupId;
@property(nonatomic,copy) NSString *groupName;
@property(nonatomic,assign) NSInteger isEnd;
@property(nonatomic,copy) NSString *prizesImage;
@property(nonatomic,copy) NSString *prizesName;
@property(nonatomic,assign) NSInteger prizesNumber;
@property(nonatomic,copy) NSString *sendPersonalName;
@property(nonatomic,copy) NSString *sendPersonalPhone;
@property(nonatomic,copy) NSString *sendPrizesId;
@property(nonatomic,copy) NSString *sendPrizesTime;
@property(nonatomic,copy) NSString *shareContent;
@property(nonatomic,copy) NSString *shareUrl;

@end
