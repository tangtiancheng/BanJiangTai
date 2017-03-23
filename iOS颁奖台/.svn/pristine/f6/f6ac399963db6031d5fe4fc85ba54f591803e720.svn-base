//
//  UIApplication+RACSignal.m
//  XPApp
//
//  Created by huangxinping on 15/11/14.
//  Copyright © 2015年 ShareMerge. All rights reserved.
//

#import "UIApplication+RACSignal.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation UIApplication (RACSignal)

- (RACSignal *)rac_active
{
    return [[[RACSignal
              merge:@[
                      [[NSNotificationCenter.defaultCenter rac_addObserverForName:UIApplicationDidBecomeActiveNotification object:nil] mapReplace:@YES],
                      [[NSNotificationCenter.defaultCenter rac_addObserverForName:UIApplicationWillResignActiveNotification object:nil] mapReplace:@NO]
                      ]]
             startWith:@YES]
            setNameWithFormat:@"[%@] rac_Active", self];
}

@end
