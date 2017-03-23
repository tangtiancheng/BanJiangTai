//
//  UITextView+XPLimitLength.m
//  XPApp
//
//  Created by xinpinghuang on 1/8/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import "UITextView+XPLimitLength.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation UITextView (XPLimitLength)

- (RACSignal *)rac_textSignalWithLimitLength:(NSInteger)limitLength
{
    RACSignal *filterSignal = [self.rac_textSignal map:^id (NSString *value) {
        if(value.length >= limitLength) {
            return [value substringToIndex:limitLength];
        } else {
            return value;
        }
    }];
    
    RAC(self, text) = filterSignal;
    
    return filterSignal;
}

@end
