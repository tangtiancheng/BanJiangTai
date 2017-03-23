//
//  XPAPIManager+Notice.m
//  XPApp
//
//  Created by xinpinghuang on 12/21/15.
//  Copyright 2015 ShareMerge. All rights reserved.
//

#import "NSDictionary+XPUserInfo.h"
#import "NSString+XPAPIPath_Notice.h"
#import "XPAPIManager+Analysis.h"
#import "XPAPIManager+Notice.h"
#import "XPNoticeDetailModel.h"
#import "XPNoticeModel.h"

@implementation XPAPIManager (Notice)

- (RACSignal *)noticeWithLastCount:(NSInteger)lastCount pageSize:(NSInteger)pageSize
{
    return [[[[[self rac_GET:[NSString api_notice_path]
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
                    
                    return [self rac_MappingForClass:[XPNoticeModel class] array:value[@"noticelist"]];
                }] logError] replayLazily];
}

- (RACSignal *)noticeBanner
{
    return [[[[[self rac_GET:[NSString api_notice_banner_path]
                parameters  :[@{}
                              fillUserInfo]] map:^id (id value) {
                    return [self analysisRequest:value];
                }] flattenMap:^RACStream *(id value) {
                    if([value isKindOfClass:[NSError class]]) {
                        return [RACSignal error:value];
                    }
                    
                    return [RACSignal return :value[@"activeList"]];
                }] logError] replayLazily];
}

- (RACSignal *)noticeWithId:(NSString *)noticeId lastCount:(NSInteger)lastCount pageSize:(NSInteger)pageSize
{
    return [[[[[self rac_GET:[NSString api_notice_detail_path]
                parameters  :[@{
                                @"id":noticeId,
                                @"lastCount":@(lastCount),
                                @"page_size":@(pageSize)
                                }
                              fillUserInfo]] map:^id (id value) {
                    return [self analysisRequest:value];
                }] flattenMap:^RACStream *(id value) {
                    if([value isKindOfClass:[NSError class]]) {
                        return [RACSignal error:value];
                    }
                    
                    return [self rac_MappingForClass:[XPNoticeDetailModel class] dictionary:value];
                }] logError] replayLazily];
}

@end
