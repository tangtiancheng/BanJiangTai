//
//

#import "ZGABTestDesignerConnection.h"
#import "ZGABTestDesignerDisconnectMessage.h"

NSString *const ZGABTestDesignerDisconnectMessageType = @"disconnect";

@implementation ZGABTestDesignerDisconnectMessage

+ (instancetype)message
{
    return [[self alloc] initWithType:ZGABTestDesignerDisconnectMessageType];
}

- (NSOperation *)responseCommandWithConnection:(ZGABTestDesignerConnection *)connection
{
    __weak ZGABTestDesignerConnection *weak_connection = connection;
    NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        ZGABTestDesignerConnection *conn = weak_connection;

        conn.sessionEnded = YES;
        [conn close];
    }];
    return operation;
}

@end
