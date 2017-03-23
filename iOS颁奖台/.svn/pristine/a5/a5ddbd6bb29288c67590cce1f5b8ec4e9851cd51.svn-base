//
//  XPAPIManager+Help.m
//  XPApp
//
//  Created by xinpinghuang on 1/19/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "NSDictionary+XPUserInfo.h"
#import "NSString+XPAPIPath_Help.h"
#import "XPAPIManager+Analysis.h"
#import "XPAPIManager+Help.h"

@implementation XPAPIManager (Help)

- (RACSignal *)feedbackWithContent:(NSString *)content
{
    NSParameterAssert(content);
    return [[[[[self rac_POST:[NSString api_feedback_path]
                  parameters :[@{
                                 @"content":[content urlEncode]
                                 }
                               fillUserInfo]] map:^id (id value) {
                      return [self analysisRequest:value];
                  }] flattenMap:^RACStream *(id value) {
                      if([value isKindOfClass:[NSError class]]) {
                          return [RACSignal error:value];
                      }
                      
                      return [RACSignal return :value];
                  }] logError] replayLazily];
}

- (RACSignal *)help
{
    return [[[[[self rac_GET:[NSString api_help_path]
                parameters  :@{}] map:^id (id value) {
        return [self analysisRequest:value];
    }] flattenMap:^RACStream *(id value) {
        if([value isKindOfClass:[NSError class]]) {
            return [RACSignal error:value];
        }
        
        return [RACSignal return :value[@"helpUrl"]];
    }] logError] replayLazily];
}

@end
