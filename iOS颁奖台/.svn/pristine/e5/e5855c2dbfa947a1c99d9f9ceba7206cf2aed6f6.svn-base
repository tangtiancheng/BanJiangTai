//
//  XPAPIManager+Address.m
//  XPApp
//
//  Created by xinpinghuang on 1/21/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "NSDictionary+XPUserInfo.h"
#import "NSString+XPAPIPath_Address.h"
#import "XPAPIManager+Address.h"
#import "XPAPIManager+Analysis.h"
#import "XPAddressBackModel.h"
#import "XPAddressModel.h"

@implementation XPAPIManager (Address)

- (RACSignal *)addressWithLastCount:(NSInteger)lastCount pageSize:(NSInteger)pageSize
{
    return [[[[[self rac_GET:[NSString api_address_path]
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
                    
                    return [self rac_MappingForClass:[XPAddressModel class] array:value[@"addresslist"]];
                }] logError] replayLazily];
}

- (RACSignal *)addressCreateWithRecipient:(NSString *)recipient phone:(NSString *)phone proinceId:(NSInteger)proinceId cityId:(NSInteger)cityId areaId:(NSInteger)areaId addressInfo:(NSString *)addressInfo isDefault:(BOOL)isDefault
{
    NSParameterAssert(recipient);
    NSParameterAssert(phone);
    NSParameterAssert(addressInfo);
    return [[[[[self rac_POST:[NSString api_address_create_path]
                  parameters :[@{
                                 @"name":[recipient urlEncode],
                                 @"phone":phone,
                                 @"province":@(proinceId),
                                 @"city":@(cityId),
                                 @"area":@(areaId),
                                 @"addressInfo":[addressInfo urlEncode],
                                 @"isDefault":@(isDefault)
                                 }
                               fillUserInfo]] map:^id (id value) {
                      return [self analysisRequest:value];
                  }] flattenMap:^RACStream *(id value) {
                      if([value isKindOfClass:[NSError class]]) {
                          return [RACSignal error:value];
                      }
                      
                      return [self rac_MappingForClass:[XPAddressBackModel class] dictionary:value];
                  }] logError] replayLazily];
}

- (RACSignal *)addressUpdateWithAddressId:(NSString *)addressId recipient:(NSString *)recipient phone:(NSString *)phone proinceId:(NSInteger)proinceId cityId:(NSInteger)cityId areaId:(NSInteger)areaId addressInfo:(NSString *)addressInfo isDefault:(BOOL)isDefault
{
    NSParameterAssert(addressId);
    NSParameterAssert(recipient);
    NSParameterAssert(phone);
    NSParameterAssert(addressInfo);
    return [[[[[self rac_POST:[NSString api_address_update_path]
                  parameters :[@{
                                 @"addressId":addressId,
                                 @"name":[recipient urlEncode],
                                 @"phone":phone,
                                 @"province":@(proinceId),
                                 @"city":@(cityId),
                                 @"area":@(areaId),
                                 @"addressInfo":[addressInfo urlEncode],
                                 @"isDefault":@(isDefault)
                                 }
                               fillUserInfo]] map:^id (id value) {
                      return [self analysisRequest:value];
                  }] flattenMap:^RACStream *(id value) {
                      if([value isKindOfClass:[NSError class]]) {
                          return [RACSignal error:value];
                      }
                      
                      return [self rac_MappingForClass:[XPAddressBackModel class] dictionary:value];
                  }] logError] replayLazily];
}

- (RACSignal *)addressDeleteWithAddressId:(NSString *)addressId
{
    NSParameterAssert(addressId);
    return [[[[[self rac_POST:[NSString api_address_delete_path]
                  parameters :[@{
                                 @"addressId":addressId
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
