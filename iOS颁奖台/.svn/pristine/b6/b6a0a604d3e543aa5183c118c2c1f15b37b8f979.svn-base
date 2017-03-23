//
//  XPAPIManager+Setting.m
//  XPApp
//
//  Created by xinpinghuang on 1/19/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "NSDictionary+XPUserInfo.h"
#import "NSString+XPAPIPath_Setting.h"
#import "XPAPIManager+Analysis.h"
#import "XPAPIManager+Setting.h"

@implementation XPAPIManager (Setting)

- (RACSignal *)logout
{
    return [[[[[self rac_POST:[NSString api_logout_path]
                  parameters :[@{}
                               fillUserInfo]] map:^id (id value) {
                      return [self analysisRequest:value];
                  }] flattenMap:^RACStream *(id value) {
                      if([value isKindOfClass:[NSError class]]) {
                          return [RACSignal error:value];
                      }
                      
                      return [RACSignal return :value];
                  }] logError] replayLazily];
}

- (RACSignal *)agreenment
{
    return [[[[[self rac_GET:[NSString api_agreement_path]
                parameters  :@{}] map:^id (id value) {
        return [self analysisRequest:value];
    }] flattenMap:^RACStream *(id value) {
        if([value isKindOfClass:[NSError class]]) {
            return [RACSignal error:value];
        }
        
        return [RACSignal return :value[@"agreementUrl"]];
    }] logError] replayLazily];
}

@end
