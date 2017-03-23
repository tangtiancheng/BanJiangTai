//
//  XPAPIManager+Gift.h
//  XPApp
//
//  Created by xinpinghuang on 1/21/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPAPIManager.h"

@interface XPAPIManager (Gift)

- (RACSignal *)giftWithLastCount:(NSInteger)lastCount pageSize:(NSInteger)pageSize;

- (RACSignal *)giftCreateWithActivityName:(NSString *)activityName giftName:(NSString *)giftName number:(NSInteger)number createUserPhone:(NSString *)createUserPhone createUserNick:(NSString *)createUserNick groupId:(NSString *)groupId groupName:(NSString *)groupName groupActivity:(BOOL)groupActivity;

- (RACSignal *)giftGroupWithLastCount:(NSInteger)lastCount pageSize:(NSInteger)pageSize;

- (RACSignal *)giftGroupCreateWithName:(NSString *)groupName;

@end
