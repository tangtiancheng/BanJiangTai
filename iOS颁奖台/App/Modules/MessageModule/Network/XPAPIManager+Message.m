//
//  XPAPIManager+Message.m
//  XPApp
//
//  Created by xinpinghuang on 1/23/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "NSDictionary+XPUserInfo.h"
#import "NSString+XPAPIPath_Message.h"
#import "XPAPIManager+Analysis.h"
#import "XPAPIManager+Message.h"
#import "XPMessageModel.h"

@implementation XPAPIManager (Message)

- (RACSignal *)messageWithLastCount:(NSInteger)lastCount pageSize:(NSInteger)pageSize
{
    return [[[[[self rac_GET:[NSString api_message_path]
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
                    
                    return [self rac_MappingForClass:[XPMessageModel class] array:value[@"messagelist"]];
                }] logError] replayLazily];
}

- (RACSignal *)messageReadedWithId:(NSString *)messageId
{
    NSMutableDictionary *buffer = [NSMutableDictionary dictionary];
    if(messageId) {
        [buffer setObject:messageId forKey:@"messageId"];
    }
    
    return [[[[[self rac_POST:[NSString api_message_readed_path]
                  parameters :[buffer fillUserInfo]] map:^id (id value) {
        return [self analysisRequest:value];
    }] flattenMap:^RACStream *(id value) {
        if([value isKindOfClass:[NSError class]]) {
            return [RACSignal error:value];
        }
        
        return [RACSignal return :value];
    }] logError] replayLazily];
}

@end
