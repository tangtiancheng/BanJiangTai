//
//  XPAPIManager+Activity.m
//  XPApp
//
//  Created by xinpinghuang on 1/20/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "NSDictionary+XPUserInfo.h"
#import "NSString+XPAPIPath_Activity.h"
#import "XPAPIManager+Activity.h"
#import "XPAPIManager+Analysis.h"
#import "XPActivityModel.h"

@implementation XPAPIManager (Activity)

- (RACSignal *)activityWithLastCount:(NSInteger)lastCount pageSize:(NSInteger)pageSize
{
    return [[[[[self rac_GET:[NSString api_activity_path]
                parameters  :[@{
                                @"lastCount":@(lastCount),
                                @"page_size":@(pageSize)
                                }
                              fillUserInfo]] map:^id (id value) {
                    return [self analysisRequest:value];
                }] flattenMap:^RACStream *(id value) {
                    if([value isKindOfClass:[NSError class]]) {
                        return [RACSignal error:value];
                    }
                    
                    return [self rac_MappingForClass:[XPActivityModel class] array:value[@"accesslist"]];
                }] logError] replayLazily];
}

@end
