//
//  XPAPIManager+Address.h
//  XPApp
//
//  Created by xinpinghuang on 1/21/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPAPIManager.h"

@interface XPAPIManager (Address)

- (RACSignal *)addressWithLastCount:(NSInteger)lastCount pageSize:(NSInteger)pageSize;

- (RACSignal *)addressCreateWithRecipient:(NSString *)recipient phone:(NSString *)phone proinceId:(NSInteger)proinceId cityId:(NSInteger)cityId areaId:(NSInteger)areaId addressInfo:(NSString *)addressInfo isDefault:(BOOL)isDefault;

- (RACSignal *)addressUpdateWithAddressId:(NSString *)addressId recipient:(NSString *)recipient phone:(NSString *)phone proinceId:(NSInteger)proinceId cityId:(NSInteger)cityId areaId:(NSInteger)areaId addressInfo:(NSString *)addressInfo isDefault:(BOOL)isDefault;

- (RACSignal *)addressDeleteWithAddressId:(NSString *)addressId;

@end
