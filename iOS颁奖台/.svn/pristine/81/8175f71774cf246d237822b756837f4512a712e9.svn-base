//
//  XPAPIManager+Me.m
//  XPApp
//
//  Created by xinpinghuang on 2/16/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "NSDictionary+XPUserInfo.h"
#import "NSString+XPAPIPath_Me.h"
#import "XPAPIManager+Analysis.h"
#import "XPAPIManager+Me.h"
#import "XPAPIManager+Main.h"
#import "XPLoginModel.h"
#import "XPMainModel.h"

@implementation XPAPIManager (Me)

- (RACSignal *)updateProfileWithNick:(NSString *)nick sex:(NSInteger)sex avatar:(NSString *)avatar birthday:(NSString *)birthday
{
    NSMutableDictionary *parameters = [@{
                                         @"userSex":@(sex)
                                         }
                                       mutableCopy];
    if(nick) {
        [parameters setObject:[nick urlEncode] forKey:@"userName"];
    } else if([XPLoginModel singleton].userName) {
        if([XPLoginModel singleton].userName) {
            [parameters setObject:[[XPLoginModel singleton].userName urlEncode] forKey:@"userName"];
        } else {
            [parameters setObject:@"" forKey:@"userName"];
        }
    }
    if(avatar) {
        [parameters setObject:avatar forKey:@"userImage"];
    } else if([XPLoginModel singleton].userImage) {
        if([XPLoginModel singleton].userImage) {
            [parameters setObject:[XPLoginModel singleton].userImage forKey:@"userImage"];
        } else {
            [parameters setObject:@"" forKey:@"userImage"];
        }
    }
    if(birthday) {
        [parameters setObject:birthday forKey:@"birthday"];
    } else if([XPLoginModel singleton].birthday) {
        if([XPLoginModel singleton].birthday) {
            [parameters setObject:[XPLoginModel singleton].birthday forKey:@"birthday"];
        } else {
            [parameters setObject:@"" forKey:@"birthday"];
        }
    }
    
    [parameters setObject:[XPLoginModel singleton].isAddress forKey:@"isAddress"];
    return [[[[[self rac_POST:[NSString api_update_profile_path]
                  parameters :[parameters fillUserInfo]] map:^id (id value) {
        return [self analysisRequest:value];
    }] flattenMap:^RACStream *(id value) {
        if([value isKindOfClass:[NSError class]]) {
            return [RACSignal error:value];
        }
        
        return [self rac_MergeMappingForClass:[XPLoginModel class] dictionary:value];
    }] logError] replayLazily];
}

@end
