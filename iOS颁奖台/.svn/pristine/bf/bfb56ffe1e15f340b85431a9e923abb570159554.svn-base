//
//  XPAPIManager+Main.m
//  XPApp
//
//  Created by huangxinping on 15/10/16.
//  Copyright © 2015年 iiseeuu.com. All rights reserved.
//

#import "XPAPIManager+Main.h"

#import "NSDictionary+XPDeviceToken.h"
#import "NSDictionary+XPUserInfo.h"
#import "NSString+XPAPIPath_Main.h"
#import "XPAPIManager+Analysis.h"
#import "XPLoginModel.h"
#import "XPMainGroupModel.h"
#import "XPMainGroupShakeModel.h"
#import "XPMainModel.h"
#import "XPMainPlainModel.h"
#import "XPMainPlainShakeModel.h"
#import "RaffleModel.h"
#import "XPMainPlainScrapeModel.h"

@implementation XPAPIManager (Main)


//天成修改  此处是签到的
-(RACSignal *)userSignIn{
    return [[[[[self rac_POST:[NSString api_user_signIn_path] parameters:[@{} fillUserInfo]]map:^id(id value) {
        
        return [self analysisRequest:value];
    }]flattenMap:^RACStream *(id value) {
        if([value isKindOfClass:[NSError class]]) {
            return [RACSignal error:value];
        }
               return [self rac_MergeMappingForClass:[XPMainSignInModel class] dictionary:value];
    }]logError]replayLazily];
}

- (RACSignal *)userInfo
{
    return [[[[[self rac_GET:[NSString api_user_info_path] parameters:[[@{}
                                                                        fillUserInfo] fillDeviceToken]] map:^id (id value) {
        return [self analysisRequest:value];
    }] flattenMap:^RACStream *(id value) {
        if([value isKindOfClass:[NSError class]]) {
            return [RACSignal error:value];
        }
        
        return [self rac_MergeMappingForClass:[XPLoginModel class] dictionary:value];
    }] logError] replayLazily];
}

- (RACSignal *)podiumBanner
{
    return [[[[[self rac_GET:[NSString api_podium_bannber_path] parameters:[@{}
                                                                            fillUserInfo]] map:^id (id value) {
        return [self analysisRequest:value];
    }] flattenMap:^RACStream *(id value) {
        if([value isKindOfClass:[NSError class]]) {
            return [RACSignal error:value];
        }
        
        return [self rac_MappingForClass:[XPMainBannerModel class] array:value[@"activeList"]];
    }] logError] replayLazily];
}

- (RACSignal *)podiumListWithLastCount:(NSInteger)lastCount pageSize:(NSInteger)pageSize longitude:(CGFloat)longitude latitude:(CGFloat)latitude
{
    return [[[[[self rac_GET:[NSString api_podium_list_path] parameters:[@{
                                                                           @"lastCount":@(lastCount),
                                                                           @"page_size":@(pageSize),
                                                                           @"lat":@(latitude),
                                                                           @"lng":@(longitude)
                                                                           }
                                                                         fillUserInfo]] map:^id (id value) {
       
        return [self analysisRequest:value];
    }] flattenMap:^RACStream *(id value) {
       

        if([value isKindOfClass:[NSError class]]) {
            return [RACSignal error:value];
        }
        
        return [self rac_MappingForClass:[XPMainDataModel class] dictionary:value];

    }] logError] replayLazily];
}

- (RACSignal *)podiumGroupListWithId:(NSString *)groupId lastCount:(NSInteger)lastCount pageSize:(NSInteger)pageSize
{
    NSParameterAssert(groupId);
    return [[[[[self rac_GET:[NSString api_podium_group_list_path] parameters:[@{
                                                                                 @"groupId":groupId,
                                                                                 @"lastCount":@(lastCount),
                                                                                 @"page_size":@(pageSize)
                                                                                 }
                                                                               fillUserInfo]] map:^id (id value) {
        return [self analysisRequest:value];
    }] flattenMap:^RACStream *(id value) {
        if([value isKindOfClass:[NSError class]]) {
            return [RACSignal error:value];
        }
        
        return [self rac_MappingForClass:[XPMainGroupModel class] dictionary:value];
    }] logError] replayLazily];
}

- (RACSignal *)podiumGroupShakeListWithId:(NSString *)groupId activityId:(NSString *)activityId lastCount:(NSInteger)lastCount pageSize:(NSInteger)pageSize
{
    NSParameterAssert(groupId);
    NSParameterAssert(activityId);
    return [[[[[self rac_GET:[NSString api_podium_group_shake_list_path] parameters:[@{
                                                                                       @"groupId":groupId, @"groupActivityId":activityId,
                                                                                       @"lastCount":@(lastCount),
                                                                                       @"page_size":@(pageSize)
                                                                                       }
                                                                                     fillUserInfo]] map:^id (id value) {
        return [self analysisRequest:value];
    }] flattenMap:^RACStream *(id value) {
        if([value isKindOfClass:[NSError class]]) {
            return [RACSignal error:value];
        }
        
        return [self rac_MappingForClass:[XPMainGroupShakeModel class] dictionary:value];
    }] logError] replayLazily];
}

- (RACSignal *)podiumGroupShakeWithId:(NSString *)groupId activityId:(NSString *)activityId lastCount:(NSInteger)lastCount pageSize:(NSInteger)pageSize
{
    NSParameterAssert(groupId);
    NSParameterAssert(activityId);
    return [[[[[self rac_GET:[NSString api_podium_group_shake_path] parameters:[@{
                                                                                  @"groupId":groupId, @"groupActivityId":activityId,
                                                                                  @"lastCount":@(lastCount),
                                                                                  @"page_size":@(pageSize)
                                                                                  }
                                                                                fillUserInfo]] map:^id (id value) {
        return [self analysisRequest:value];
    }] flattenMap:^RACStream *(id value) {
        if([value isKindOfClass:[NSError class]]) {
            return [RACSignal error:value];
        }
        
        return [self rac_MappingForClass:[XPMainGroupShakeModel class] dictionary:value];
    }] logError] replayLazily];
}

- (RACSignal *)podiumPlainDetailWithId:(NSString *)podiumId
{
    NSParameterAssert(podiumId);
    return [[[[[self rac_GET:[NSString api_podium_plain_detail_path] parameters:[@{
                                                                                   @"id":podiumId
                                                                                   }
                                                                                 fillUserInfo]] map:^id (id value) {
        return [self analysisRequest:value];
    }] flattenMap:^RACStream *(id value) {
        if([value isKindOfClass:[NSError class]]) {
            return [RACSignal error:value];
        }
        
        return [self rac_MappingForClass:[XPMainPlainModel class] dictionary:value];
    }] logError] replayLazily];
}

- (RACSignal *)podiumShareReportWithId:(NSString *)podiumId activityTitle:(NSString *)activityTitle activeSharePoint:(NSInteger)activeSharePoint
{
    NSParameterAssert(podiumId);
    NSParameterAssert(activityTitle);
    return [[[[[self rac_GET:[NSString api_podium_plain_share_report_path] parameters:[@{
                                                                                         @"podiumId":podiumId,
                                                                                         @"activityTitle":[activityTitle urlEncode],
                                                                                         @"activeSharePoint":@(activeSharePoint)
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

- (RACSignal *)podiumPlainShakeNumberWithId:(NSString *)podiumId
{
    NSParameterAssert(podiumId);
    return [[[[[self rac_GET:[NSString api_podium_plain_shake_number_path] parameters:[@{
                                                                                         @"podiumId":podiumId
                                                                                         }
                                                                                       fillUserInfo]] map:^id (id value) {
        return [self analysisRequest:value];
    }] flattenMap:^RACStream *(id value) {
        if([value isKindOfClass:[NSError class]]) {
            return [RACSignal error:value];
        }
        
        return [self rac_MappingForClass:[XPMainPlainShakeNumberModel class] dictionary:value];
    }] logError] replayLazily];
}

- (RACSignal *)podiumPlainScoreExchangeWithId:(NSString *)podiumId exchangePoint:(NSInteger)exchangePoint activityTitle:(NSString *)activityTitle
{
    NSParameterAssert(podiumId);
    NSParameterAssert(activityTitle);
    return [[[[[self rac_GET:[NSString api_podium_plain_score_exchange_path] parameters:[@{
                                                                                           @"podiumId":podiumId,
                                                                                           @"exchangePoint":@(exchangePoint),
                                                                                           @"activityTitle":[activityTitle urlEncode]
                                                                                           }
                                                                                         fillUserInfo]] map:^id (id value) {
        return [self analysisRequest:value];
    }] flattenMap:^RACStream *(id value) {
        if([value isKindOfClass:[NSError class]]) {
            return [RACSignal error:value];
        }
        
        return [self rac_MappingForClass:[XPMainPlainShakeNumberModel class] dictionary:value];
    }] logError] replayLazily];
}

- (RACSignal *)podiumPlainShakeWithId:(NSString *)podiumId
{
    NSParameterAssert(podiumId);
    return [[[[[self rac_POST:[NSString api_podium_plain_shake_path] parameters:[@{
                                                                                  @"podiumId":podiumId
                                                                                  }
                                                                                fillUserInfo]] map:^id (id value) {
        return [self analysisRequest:value];
    }] flattenMap:^RACStream *(id value) {
        if([value isKindOfClass:[NSError class]]) {
            return [RACSignal error:value];
        }
        
        return [self rac_MappingForClass:[XPMainPlainShakeModel class] dictionary:value];
    }] logError] replayLazily];
}

- (RACSignal *)podiumPlainShakeResultWithId:(NSString *)podiumId prizeId:(NSString *)prizeId userActivityId:(NSString *)userActivityId lastCount:(NSInteger)lastCount pageSize:(NSInteger)pageSize
{
    NSParameterAssert(podiumId);
    NSParameterAssert(prizeId);
    NSParameterAssert(userActivityId);
    return [[[[[self rac_GET:[NSString api_podium_plain_shake_result_path] parameters:[@{
                                                                                         @"podiumId":podiumId, @"prizeId":prizeId, @"userActivityId":userActivityId,
                                                                                         @"lastCount":@(lastCount),
                                                                                         @"page_size":@(pageSize)
                                                                                         }
                                                                                       fillUserInfo]] map:^id (id value) {
        return [self analysisRequest:value];
    }] flattenMap:^RACStream *(id value) {
        if([value isKindOfClass:[NSError class]]) {
            return [RACSignal error:value];
        }
        
        return [self rac_MappingForClass:[XPMainPlainShakeResultModel class] dictionary:value];
    }] logError] replayLazily];
}

- (RACSignal *)podiumGroupAddWithId:(NSString *)groupId fromUserId:(NSString *)fromUserId
{
    NSParameterAssert(groupId);
    NSParameterAssert(fromUserId);
    return [[[[[self rac_GET:[NSString api_podium_group_add_path] parameters:[@{
                                                                                @"groupId":groupId, @"fromUserId":fromUserId
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

-(RACSignal *)podiumPlainRaffleNumberWith:(NSString *)podiumId
{
        NSParameterAssert(podiumId);
        return [[[[[self rac_GET:[NSString api_podium_plain_shake_number_path] parameters:[@{
                                                                                             @"podiumId":podiumId
                                                                                             }
                                                                                           fillUserInfo]] map:^id (id value) {
            return [self analysisRequest:value];
        }] flattenMap:^RACStream *(id value) {
            if([value isKindOfClass:[NSError class]]) {
                return [RACSignal error:value];
            }
            
            return [self rac_MappingForClass:[RaffleModel class] dictionary:value];
        }] logError] replayLazily];
}
/**
 *  抽奖活动
 */
-(RACSignal *)podiumPlainRaffleWithId:(NSString *)podiumId
{
    return [[[[[self rac_POST:[NSString api_podium_plain_raffle_path] parameters:[@{@"podiumId":podiumId}fillUserInfo]]map:^id(id value) {
        
        return [self analysisRequest:value];
        
    }]flattenMap:^RACStream *(id value) {
        if ([value isKindOfClass:[NSError class]]) {
            return [RACSignal error:value];
        }
        return [self rac_MappingForClass:[RaffleUserModel class] dictionary:value];
        
    }]logError] replayLazily];
}
/**
 *  刮奖活动
 *
 */
- (RACSignal *)podiumPlainScrapeWithId:(NSString *)podiumId
{
    NSParameterAssert(podiumId);
    return [[[[[self rac_POST:[NSString api_podium_plain_shake_path] parameters:[@{
                                                                                   @"podiumId":podiumId
                                                                                   }
                                                                                 fillUserInfo]] map:^id (id value) {
        return [self analysisRequest:value];
    }] flattenMap:^RACStream *(id value) {
        if([value isKindOfClass:[NSError class]]) {
            return [RACSignal error:value];
        }
        
        return [self rac_MappingForClass:[XPMainPlainScrapeModel class] dictionary:value];
    }] logError] replayLazily];
}

@end
