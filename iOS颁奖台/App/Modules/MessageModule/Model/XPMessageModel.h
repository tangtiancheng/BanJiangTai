//
//  XPMessageModel.h
//  XPApp
//
//  Created by xinpinghuang on 1/23/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPBaseModel.h"

@interface XPMessageModel : XPBaseModel

@property NSString *messageContent;
@property NSString *messageId;
@property NSInteger messageRead;
@property NSString *messageTitle;
@property NSString *time;

@end
