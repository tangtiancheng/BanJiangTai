//
//  XPAPIManager+Invite.m
//  XPApp
//
//  Created by xinpinghuang on 1/19/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "NSDictionary+XPUserInfo.h"
#import "NSString+XPAPIPath_Invite.h"
#import "XPAPIManager+Analysis.h"
#import "XPAPIManager+Invite.h"
#import "XPInviteModel.h"

@implementation XPAPIManager (Invite)

- (RACSignal *)invite
{
    return [[[[[self rac_GET:[NSString api_invite_path]
                parameters  :[@{
                                }
                              fillUserInfo]] map:^id (id value) {
                    return [self analysisRequest:value];
                }] flattenMap:^RACStream *(id value) {
                    if([value isKindOfClass:[NSError class]]) {
                        return [RACSignal error:value];
                    }
                    
                    return [self rac_MappingForClass:[XPInviteModel class] dictionary:value];
                }] logError] replayLazily];
}

@end
