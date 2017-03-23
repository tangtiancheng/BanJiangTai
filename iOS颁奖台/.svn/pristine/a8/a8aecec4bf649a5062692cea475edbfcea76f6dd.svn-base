/**
 *  XPStorage.h
 *  ShareMerge
 *
 *  Created by huangxp on 2015-09-01.
 *
 *  持久化层
 *
 *  Copyright (c) www.sharemerge.com All rights reserved.
 */

/** @file */    // Doxygen marker

#import <Foundation/Foundation.h>
#import "XPFMEncryptDatabase.h"
#import "XPStorageItem.h"

@interface XPStorage : NSObject

/**
 *  @brief  数据库
 */
@property (nonatomic, strong, readonly) XPFMEncryptDatabase *database;

/**
 *  @brief  单例
 *
 *  @return 对象
 */
+ (instancetype)sharedStorage;

/**
 *  @brief  通过ID获取结构
 *
 *  @param objectId ID
 *
 *  @return 结构
 */
- (XPStorageItem*)getXPStorageItemById:(NSString*)objectId;

/**
 *  @brief  获取搜索的结构
 *
 *  @return 结构数组
 */
- (NSArray *)getAllItems;

/**
 *  @brief  删除所有数据
 */
- (void)deleteAllObjects;

/**
 *  @brief  通过ID删除数据
 *
 *  @param objectId ID
 */
- (void)deleteObjectById:(NSString *)objectId;

/**
 *  @brief  通过ID数组删除数据
 *
 *  @param objectIdArray ID数组
 */
- (void)deleteObjectsByIdArray:(NSArray *)objectIdArray;

/**
 *  @brief  通过ID前缀删除数据
 *
 *  @param objectIdPrefix ID前缀
 */
- (void)deleteObjectsByIdPrefix:(NSString *)objectIdPrefix;

@end
