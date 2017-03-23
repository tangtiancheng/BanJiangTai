//
//  XPAPIManager+Award.h
//  XPApp
//
//  Created by xinpinghuang on 1/20/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPAPIManager.h"

@interface XPAPIManager (Award)

/**
 *  @param type 0全部、1待领取、2待收货、3待使用
 *
 *  @return 信号
 */
- (RACSignal *)awardWiteType:(NSInteger)type lastCount:(NSInteger)lastCount pageSize:(NSInteger)pageSize;

- (RACSignal *)awardDeliveryWithId:(NSString *)awardId addressId:(NSString *)addressId date:(NSString *)date time:(NSString *)time;

@end
