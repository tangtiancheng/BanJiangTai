//
//  ZGDesignerEventBindingResponseMesssage.m
//  HelloZhuge
//
//  Created by Amanda Canyon on 7/15/14.
//  Copyright (c) 2014 Zhuge. All rights reserved.
//

#import "ZGDesignerEventBindingMessage.h"

@implementation ZGDesignerEventBindingResponseMesssage

+ (instancetype)message
{
    return [[self alloc] initWithType:@"event_binding_response"];
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
