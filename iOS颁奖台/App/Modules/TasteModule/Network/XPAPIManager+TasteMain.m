//
//  XPAPIManager+TasteMain.m
//  XPApp
//
//  Created by Pua on 16/5/17.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "XPAPIManager+TasteMain.h"
#import "NSString+TasteMain_Path.h"
#import "XPAPIManager+Analysis.h"
#import "TasteMainModel.h"
#import "NSDictionary+XPUserInfo.h"
#import "XPTastStoreModel.h"

@implementation XPAPIManager (TasteMain)

-(RACSignal *)tasteBanner
{
    return [[[[[self rac_GET:[NSString api_taste_banner_path] parameters:@{}] map:^id(id value) {
        return [self analysisRequest:value];
    }] flattenMap:^RACStream *(id value) {
        if ([value isKindOfClass:[NSError class]]) {
            return [RACSignal error:value];
        }
        return [self rac_MappingForClass:[TasteBannerModel class] array:value[@"storeList"]];
    }] logError]replayLazily];
    
}
-(RACSignal *)tasteListWithLastCount:(NSInteger)lastCount pageSize:(NSInteger)pageSize longitude:(CGFloat)longitude latitude:(CGFloat)latitude storeName:(NSString *)storeName dishName:(NSString *)dishName avgPrice:(NSString *)avgPrice storeTag:(NSString *)storeTag storeType:(NSString *)storeType storeArea:(NSString *)storeArea
{
    return [[[[[self rac_GET:[NSString api_taste_storeList_path] parameters:@{
                                                                           @"lastCount":@(lastCount),
                                                                           @"pageSize":@(pageSize),
                                                                           @"lat":
                                                               @(latitude),
                                                                           @"lng":
                                                                @(longitude),
                                                                           @"storeName":
                                                                storeName,
                                                                           @"dishName":
                                                                dishName,
                                                                           @"avgPrice":avgPrice,
                                                                           @"storeTag":storeTag,
                                                                           @"storeType":storeType,
                                                                           @"storeArea":storeArea}] map:^id (id value) {
        
        return [self analysisRequest:value];
    }] flattenMap:^RACStream *(id value) {
        
        
        if([value isKindOfClass:[NSError class]]) {
            return [RACSignal error:value];
        }
        
        return [self rac_MappingForClass:[TasteMainModel class] array:value[@"storeList"]];
    }] logError] replayLazily];
}
-(RACSignal *)tastefilterWithText:(NSString *)text
{
    return [[[[[self rac_POST:[NSString api_taste_filter_path] parameters:@{@"filterName":text}] map:^id(id value) {
        return [self analysisRequest:value];
    }] flattenMap:^RACStream *(id value) {
        if ([value isKindOfClass:[NSError class]]) {
            return [RACSignal error:value];
        }
        return [self rac_MappingForClass:[TasteFilterModel class] array:value[@"filterList"]];
    }] logError]replayLazily];
    
}

-(RACSignal *)tastQryStoreAllInfoWithBusinessId:(NSString *)businessId business_store_id:(NSString *)businessStoreId{
    NSParameterAssert(businessId);
    NSParameterAssert(businessStoreId);
    NSLog(@"%@  %@",businessId,businessStoreId);
    return [[[[[self rac_GET:[NSString api_taste_qryStoreAllInfo_path] parameters:[@{@"businessId":businessId,@"business_store_id":businessStoreId}
                                                                                   fillUserInfo]] map:^id (id value) {
        return [self analysisRequest:value];
    }] flattenMap:^RACStream *(id value) {
        if([value isKindOfClass:[NSError class]]) {
            return [RACSignal error:value];
        }
        
        return [self rac_MappingForClass:[XPTastStoreModel class] dictionary:value];
    }] logError] replayLazily];

}
@end
