//
//  RACSignal+Extends.h
//  XPApp
//
//  Created by huangxinping on 15/11/13.
//  Copyright © 2015年 ShareMerge. All rights reserved.
//

#import "RACSignal+Extends.h"

@implementation RACSignal (Extends)

- (RACSignal *)rac_addBackgroundTaskSignal
{
    return [[RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
        UIBackgroundTaskIdentifier identifier = [UIApplication.sharedApplication beginBackgroundTaskWithName:self.name expirationHandler:^{
            [subscriber sendError:[NSError errorWithDomain:RACSignalErrorDomain code:RACSignalErrorTimedOut userInfo:@{
                                                                                                                       NSLocalizedDescriptionKey: NSLocalizedString(@"Timed out", nil),
                                                                                                                       NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"The background task expired before it could complete.", nil),
                                                                                                                       }]];
        }];
        [self subscribe:subscriber];
        return [RACDisposable disposableWithBlock:^{
            if(identifier != UIBackgroundTaskInvalid) {
                [UIApplication.sharedApplication endBackgroundTask:identifier];
            }
        }];
    }] setNameWithFormat:@"[%@] -rac_addBackgroundTask", self.name];
}

- (RACSignal *)rac_collectSetSignal
{
    return [[self
             aggregateWithStart:[NSSet set] reduce:^(NSSet *accumulated, id value) {
                 return [accumulated setByAddingObject:value ? : NSNull.null];
             }]
            setNameWithFormat:@"[%@] -rac_collectSet", self.name];
}

@end
