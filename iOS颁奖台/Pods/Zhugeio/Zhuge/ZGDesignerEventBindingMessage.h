//
//  ZGDesignerEventBindingMessage.h
//  HelloZhuge
//
//  Created by Amanda Canyon on 11/18/14.
//  Copyright (c) 2014 Zhuge. All rights reserved.
//

#import "ZGAbstractABTestDesignerMessage.h"

extern NSString *const ZGDesignerEventBindingRequestMessageType;

@interface ZGDesignerEventBindingRequestMesssage : ZGAbstractABTestDesignerMessage

@end


@interface ZGDesignerEventBindingResponseMesssage : ZGAbstractABTestDesignerMessage

+ (instancetype)message;

@property (nonatomic, copy) NSString *status;

@end


@interface ZGDesignerTrackMessage : ZGAbstractABTestDesignerMessage

+ (instancetype)message;
+ (instancetype)messageWithPayload:(NSDictionary *)payload;

@end


