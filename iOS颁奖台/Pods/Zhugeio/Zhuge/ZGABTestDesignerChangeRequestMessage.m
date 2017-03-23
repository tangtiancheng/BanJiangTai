//
// Copyright (c) 2014 Zhuge. All rights reserved.

#import "ZGABTestDesignerChangeRequestMessage.h"
#import "ZGABTestDesignerChangeResponseMessage.h"
#import "ZGABTestDesignerConnection.h"
#import "ZGABTestDesignerSnapshotResponseMessage.h"

NSString *const ZGABTestDesignerChangeRequestMessageType = @"change_request";

@implementation ZGABTestDesignerChangeRequestMessage

+ (instancetype)message
{
    return [[self alloc] initWithType:ZGABTestDesignerChangeRequestMessageType];
}

- (NSOperation *)responseCommandWithConnection:(ZGABTestDesignerConnection *)connection
{
    __weak ZGABTestDesignerConnection *weak_connection = connection;
    NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        ZGABTestDesignerConnection *conn = weak_connection;

        ZGABTestDesignerChangeResponseMessage *changeResponseMessage = [ZGABTestDesignerChangeResponseMessage message];
        changeResponseMessage.status = @"OK";
        [conn sendMessage:changeResponseMessage];
    }];

    return operation;
}

@end
