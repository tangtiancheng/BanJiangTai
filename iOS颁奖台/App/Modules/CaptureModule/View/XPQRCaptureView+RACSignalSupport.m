//
//  XPQRCaptureView+RACSignalSupport.m
//  XPApp
//
//  Created by huangxinping on 15/5/15.
//  Copyright (c) 2015年 iiseeuu.com. All rights reserved.
//

#import "XPQRCaptureView+RACSignalSupport.h"
#import <objc/runtime.h>

@implementation XPQRCaptureView (RACSignalSupport)

static void *kXPQRSubscriberKey = &kXPQRSubscriberKey;
- (RACSignal *)rac_startCapture
{
    [self startCaptureWithDelegate:self];
    return [[RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
        objc_setAssociatedObject(self, &kXPQRSubscriberKey, subscriber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return nil;
    }] setNameWithFormat:@"%@ - rac_startCapture", self];
}

#pragma mark - XPQRCaptureDelegate
- (void)qrView:(XPQRCaptureView *)qrView captureOutput:(NSString *)obtainedString
{
    id <RACSubscriber> subscriber = objc_getAssociatedObject(self, &kXPQRSubscriberKey);
    [subscriber sendNext:obtainedString];
}

@end
