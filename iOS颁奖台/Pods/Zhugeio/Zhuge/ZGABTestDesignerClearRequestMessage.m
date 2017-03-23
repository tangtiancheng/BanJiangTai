//
//  ZGABTestDesignerClearRequestMessage.m
//  HelloZhuge
//
//  Created by Alex Hofsteede on 3/7/14.
//  Copyright (c) 2014 Zhuge. All rights reserved.
//

#import "ZGABTestDesignerClearRequestMessage.h"
#import "ZGABTestDesignerClearResponseMessage.h"
#import "ZGABTestDesignerConnection.h"

NSString *const ZGABTestDesignerClearRequestMessageType = @"clear_request";

@implementation ZGABTestDesignerClearRequestMessage

+ (instancetype)message
{
    return [[self alloc] initWithType:ZGABTestDesignerClearRequestMessageType];
}

- (NSOperation *)responseCommandWithConnection:(ZGABTestDesignerConnection *)connection
{
    __weak ZGABTestDesignerConnection *weak_connection = connection;
    NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        ZGABTestDesignerConnection *conn = weak_connection;


        ZGABTestDesignerClearResponseMessage *clearResponseMessage = [ZGABTestDesignerClearResponseMessage message];
        clearResponseMessage.status = @"OK";
        [conn sendMessage:clearResponseMessage];
    }];
    return operation;
}

@end
