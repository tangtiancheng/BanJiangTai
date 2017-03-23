//
// Copyright (c) 2014 Zhuge. All rights reserved.

#import <Foundation/Foundation.h>
#import "ZGAbstractABTestDesignerMessage.h"

@interface ZGABTestDesignerChangeResponseMessage : ZGAbstractABTestDesignerMessage

+ (instancetype)message;

@property (nonatomic, copy) NSString *status;

@end
