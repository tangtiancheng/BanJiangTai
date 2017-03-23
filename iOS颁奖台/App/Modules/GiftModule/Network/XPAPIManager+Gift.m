//
//  XPAPIManager+Gift.m
//  XPApp
//
//  Created by xinpinghuang on 1/21/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "NSDictionary+XPUserInfo.h"
#import "NSString+XPAPIPath_Gift.h"
#import "XPAPIManager+Analysis.h"
#import "XPAPIManager+Gift.h"
#import "XPGiftGroupModel.h"
#import "XPGiftModel.h"

@implementation XPAPIManager (Gift)

- (RACSignal *)giftWithLastCount:(NSInteger)lastCount pageSize:(NSInteger)pageSize
{
    return [[[[[self rac_GET:[NSString api_gift_path]
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
                    
                    return [self rac_MappingForClass:[XPGiftModel class] array:value[@"prizeslist"]];
                }] logError] replayLazily];
}

- (RACSignal *)giftCreateWithActivityName:(NSString *)activityName giftName:(NSString *)giftName number:(NSInteger)number createUserPhone:(NSString *)createUserPhone createUserNick:(NSString *)createUserNick groupId:(NSString *)groupId groupName:(NSString *)groupName groupActivity:(BOOL)groupActivity
{
    NSParameterAssert(activityName);
    NSParameterAssert(giftName);
    NSParameterAssert(createUserPhone);
    NSParameterAssert(createUserNick);
    NSParameterAssert(groupId);
    NSParameterAssert(groupName);
    return [[[[[self rac_POST:[NSString api_gift_create_path]
                  parameters :[@{
                                 @"activeScope":groupActivity ? @"1" : @"0",
                                 @"activeTitle":[activityName urlEncode],
                                 @"prizesName":[giftName urlEncode],
                                 @"prizesNumber":@(number),
                                 @"groupName":[groupName urlEncode],
                                 @"groupId":groupId,
                                 @"sendPersonalPhone":createUserPhone,
                                 @"sendPersonalName":[createUserNick urlEncode]
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

- (RACSignal *)giftGroupWithLastCount:(NSInteger)lastCount pageSize:(NSInteger)pageSize
{
    return [[[[[self rac_GET:[NSString api_gift_group_list_path]
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
                    
                    return [self rac_MappingForClass:[XPGiftGroupModel class] array:value[@"groupList"]];
                }] logError] replayLazily];
}

- (RACSignal *)giftGroupCreateWithName:(NSString *)groupName
{
    NSParameterAssert(groupName);
    return [[[[[self rac_POST:[NSString api_gift_group_create_path]
                  parameters :[@{
                                 @"groupName":[groupName urlEncode]
                                 }
                               fillUserInfo]] map:^id (id value) {
                      return [self analysisRequest:value];
                  }] flattenMap:^RACStream *(id value) {
                      if([value isKindOfClass:[NSError class]]) {
                          return [RACSignal error:value];
                      }
                      
                      return [RACSignal return :value[@"groupId"]];
                  }] logError] replayLazily];
}

@end
