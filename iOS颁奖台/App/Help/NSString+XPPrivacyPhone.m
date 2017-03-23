//
//  NSString+XPPrivacyPhone.m
//  XPApp
//
//  Created by xinpinghuang on 1/23/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import "NSString+XPPrivacyPhone.h"

@implementation NSString (XPPrivacyPhone)

- (NSString *)privacyPhone
{
    if(11 != self.length) {
        return self;
    }
    
    return [self stringByReplacingOccurrencesOfString:[self substringWithRange:NSMakeRange(3, 4)] withString:@"****"];
}

@end
