//
//  ZGABTestDesignerClearResponseMessage.m
//  HelloZhuge
//
//  Created by Alex Hofsteede on 3/7/14.
//  Copyright (c) 2014 Zhuge. All rights reserved.
//

#import "ZGABTestDesignerClearResponseMessage.h"

@implementation ZGABTestDesignerClearResponseMessage

+ (instancetype)message
{
    return [[self alloc] initWithType:@"clear_response"];
}

- (void)setStatus:(NSString *)status
{
    [self setPayloadObject:status forKey:@"status"];
}

- (NSString *)status
{
    return [self payloadObjectForKey:@"status"];
}

@end
