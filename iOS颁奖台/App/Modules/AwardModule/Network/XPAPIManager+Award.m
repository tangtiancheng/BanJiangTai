//
//  XPAPIManager+Award.m
//  XPApp
//
//  Created by xinpinghuang on 1/20/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "NSDictionary+XPUserInfo.h"
#import "NSString+XPAPIPath_Award.h"
#import "XPAPIManager+Analysis.h"
#import "XPAPIManager+Award.h"
#import "XPAwardModel.h"

@implementation XPAPIManager (Award)

- (RACSignal *)awardWiteType:(NSInteger)type lastCount:(NSInteger)lastCount pageSize:(NSInteger)pageSize
{
    NSString *sort = @"0";
    switch(type) {
        case 0: {
            sort = @"0";
        }
            break;
            
        case 1: {
            sort = @"N";
        }
            
            break;
            
        case 2: {
            sort = @"1";
        }
            break;
            
        case 3: {
            sort = @"S";
        }
            
            break;
            
        default: {
        }
            break;
    }
    return [[[[[self rac_GET:[NSString api_award_path] parameters  :[@{
                                @"sort":sort,
                                @"lastCount":@(lastCount),
                                @"page_size":@(pageSize)
                                }
                              fillUserInfo]] map:^id (id value) {
                    return [self analysisRequest:value];
                }] flattenMap:^RACStream *(id value) {
                    if([value isKindOfClass:[NSError class]]) {
                        return [RACSignal error:value];
                    }
                    
                    return [self rac_MappingForClass:[XPAwardModel class] dictionary:value];
                }] logError] replayLazily];
}

- (RACSignal *)awardDeliveryWithId:(NSString *)awardId addressId:(NSString *)addressId date:(NSString *)date time:(NSString *)time
{
    NSParameterAssert(awardId);
    NSParameterAssert(addressId);
    NSParameterAssert(date);
    NSParameterAssert(time);
    return [[[[[self rac_POST:[NSString api_award_delivery_path]
                  parameters :[@{
                                 @"myPrizeId":awardId,
                                 @"addressId":addressId,
                                 @"deliveryDate":[date urlEncode],
                                 @"deliveryTime":[time urlEncode]
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

@end
