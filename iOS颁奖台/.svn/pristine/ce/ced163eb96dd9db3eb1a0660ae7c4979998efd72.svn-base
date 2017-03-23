//
//  XPAPIManager+Points.m
//  XPApp
//
//  Created by xinpinghuang on 1/19/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "NSDictionary+XPUserInfo.h"
#import "NSString+XPAPIPath_Points.h"
#import "XPAPIManager+Analysis.h"
#import "XPAPIManager+Points.h"
#import "XPPointsModel.h"

@implementation XPAPIManager (Points)

- (RACSignal *)pointWithLastCount:(NSInteger)lastCount pageSize:(NSInteger)pageSize
{
    return [[[[[self rac_GET:[NSString api_points_path] parameters:[@{
                                                                      @"lastCount":@(lastCount),
                                                                      @"page_size":@(pageSize)
                                                                      }
                                                                    fillUserInfo]] map:^id (id value) {
        return [self analysisRequest:value];
    }] flattenMap:^RACStream *(id value) {
        if([value isKindOfClass:[NSError class]]) {
            return [RACSignal error:value];
        }
        
        return [self rac_MappingForClass:[XPPointsModel class] dictionary:value];
    }] logError] replayLazily];
}

@end
