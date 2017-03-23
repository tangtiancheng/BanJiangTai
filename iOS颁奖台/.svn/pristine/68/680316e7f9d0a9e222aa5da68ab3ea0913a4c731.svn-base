//
//  ZGDesignerEventBindingRequestMesssage.m
//  HelloZhuge
//
//  Created by Amanda Canyon on 7/15/14.
//  Copyright (c) 2014 Zhuge. All rights reserved.
//

#import "ZGABTestDesignerConnection.h"
#import "ZGDesignerEventBindingMessage.h"
#import "ZGDesignerSessionCollection.h"
#import "ZGEventBinding.h"
#import "ZGObjectSelector.h"
#import "ZGSwizzler.h"
#import "ZGLog.h"

NSString *const ZGDesignerEventBindingRequestMessageType = @"event_binding_request";

@interface ZGEventBindingCollection : NSObject<ZGDesignerSessionCollection>

@property (nonatomic) NSMutableArray *bindings;

@end

@implementation ZGEventBindingCollection

- (void)updateBindings:(NSArray *)bindingPayload
{
    NSMutableArray *newBindings = [NSMutableArray array];
    for (NSDictionary *bindingInfo in bindingPayload) {
        ZGEventBinding *binding = [ZGEventBinding bindingWithJSONObject:bindingInfo];
        [newBindings addObject:binding];
    }

    if (self.bindings) {
        for (ZGEventBinding *oldBinding in self.bindings) {
            [oldBinding stop];
        }
    }
    self.bindings = newBindings;
    for (ZGEventBinding *newBinding in self.bindings) {
        [newBinding execute];
    }
}

- (void)cleanup
{
    if (self.bindings) {
        for (ZGEventBinding *oldBinding in self.bindings) {
            [oldBinding stop];
        }
    }
    self.bindings = nil;
}

@end

@implementation ZGDesignerEventBindingRequestMesssage

+ (instancetype)message
{
    return [[self alloc] initWithType:@"event_binding_request"];
}

- (NSOperation *)responseCommandWithConnection:(ZGABTestDesignerConnection *)connection
{
    __weak ZGABTestDesignerConnection *weak_connection = connection;
    NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        ZGABTestDesignerConnection *conn = weak_connection;

        dispatch_sync(dispatch_get_main_queue(), ^{
            ZhugeDebug(@"Loading event bindings:\n%@",[self payload][@"events"]);
            NSArray *payload = [self payload][@"events"];
            ZGEventBindingCollection *bindingCollection = [conn sessionObjectForKey:@"event_bindings"];
            if (!bindingCollection) {
                bindingCollection = [[ZGEventBindingCollection alloc] init];
                [conn setSessionObject:bindingCollection forKey:@"event_bindings"];
            }
            [bindingCollection updateBindings:payload];
        });

        ZGDesignerEventBindingResponseMesssage *changeResponseMessage = [ZGDesignerEventBindingResponseMesssage message];
        changeResponseMessage.status = @"OK";
        [conn sendMessage:changeResponseMessage];
    }];

    return operation;
}

@end
