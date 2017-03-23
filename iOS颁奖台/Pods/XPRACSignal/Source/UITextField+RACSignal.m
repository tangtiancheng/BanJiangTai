//
//  UITextField+RAC.m
//  XPApp
//
//  Created by xinpinghuang on 12/7/15.
//  Copyright © 2015 iiseeuu.com. All rights reserved.
//

#import "UITextField+RACSignal.h"
#import <objc/runtime.h>

@interface UITextField ()<UITextFieldDelegate>

@end

@implementation UITextField (RACSignal)

- (RACSignal *)rac_sendSignal
{
    self.delegate = self;
    RACSignal *signal = objc_getAssociatedObject(self, _cmd);
    if(signal != nil) {
        return signal;
    }
    
    signal = [[self rac_signalForSelector:@selector(textFieldShouldReturn:) fromProtocol:@protocol(UITextFieldDelegate)] map:^id (id value) {
        return value;
    }];
    objc_setAssociatedObject(self, _cmd, signal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return signal;
}

@end
