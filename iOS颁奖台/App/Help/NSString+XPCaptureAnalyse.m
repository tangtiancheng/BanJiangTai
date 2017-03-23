//
//  NSString+XPCaptureAnalyse.m
//  XPApp
//
//  Created by xinpinghuang on 1/25/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import "NSString+XPCaptureAnalyse.h"
#import <XPKit/XPKit.h>

@implementation NSString (XPCaptureAnalyse)

- (NSArray *)xp_captureAnalyse
{
    NSMutableArray *buffer = [NSMutableArray arrayWithCapacity:2];
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(fromUserid=\\w*&|groupid=\\w*&)" options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *result = [regex matchesInString:self options:0 range:NSMakeRange(0, [self length])];
    if(2 != result.count) {
        [UIAlertView alertViewWithTitle:nil message:@"二维码无效" block:^(NSInteger buttonIndex) {
        }
                            buttonTitle:@"好的"];
        return nil;
    } else {
        NSTextCheckingResult *userIdResult = result[0];
        NSTextCheckingResult *groupIdResult = result[1];
        NSString *userId = [[[self substringWithRange:userIdResult.range] stringByReplacingOccurrencesOfString:@"fromUserid=" withString:@""] stringByReplacingOccurrencesOfString:@"&" withString:@""];
        NSString *groupId = [[[self substringWithRange:groupIdResult.range] stringByReplacingOccurrencesOfString:@"groupid=" withString:@""] stringByReplacingOccurrencesOfString:@"&" withString:@""];
        [buffer addObject:userId];
        [buffer addObject:groupId];
    }
    
    return buffer;
}

@end
