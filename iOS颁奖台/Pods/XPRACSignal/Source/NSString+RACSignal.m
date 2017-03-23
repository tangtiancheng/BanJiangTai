//
//  NSString+RACSignal.h
//  XPApp
//
//  Created by huangxinping on 15/11/13.
//  Copyright © 2015年 ShareMerge. All rights reserved.
//

#import "NSString+RACSignal.h"

@implementation NSString (RACSignal)

- (RACSignal *)rac_lineSignal
{
    return [[RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
        [self enumerateLinesUsingBlock:^(NSString *line, BOOL *stop) {
            [subscriber sendNext:line];
        }];
        [subscriber sendCompleted];
        return nil;
    }] setNameWithFormat:@"[%@] -rac_line", self];
}

- (RACSignal *)rac_remoteImage
{
    return [[[[[RACSignal return :@(0)] map:^id (id value) {
        return self;
    }] ignore:nil] flattenMap:^RACStream *(id value) {
        return [[[NSData rac_readContentsOfURL:[NSURL URLWithString:value] options:NSDataReadingMappedIfSafe scheduler:[RACScheduler scheduler]] catch:^RACSignal *(NSError *error) {
            return [RACSignal return :nil];
        }] map:^id (id value) {
            return [UIImage imageWithData:value];
        }];
    }] deliverOn:[RACScheduler mainThreadScheduler]];
}

@end
