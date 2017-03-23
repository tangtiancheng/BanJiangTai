/**
 *  XPStorage+NSNumber.h
 *  ShareMerge
 *
 *  Created by huangxp on 2015-09-01.
 *
 *  插入数值
 *
 *  Copyright (c) www.sharemerge.com All rights reserved.
 */

/** @file */    // Doxygen marker

#import "XPStorage.h"

@interface XPStorage (NSNumber)

/**
 *  @brief  插入数值
 *
 *  @param number 数值
 *  @param id     ID
 */
- (void)putNumber:(NSNumber *)number withId:(NSString *)id;

/**
 *  @brief  获取数值
 *
 *  @param id ID
 *
 *  @return 数值
 */
- (NSNumber *)getNumberById:(NSString *)id;

@end
