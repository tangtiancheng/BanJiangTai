//
//  XPBaseStorage.h
//  XPApp
//
//  Created by huangxinping on 15/9/2.
//  Copyright © 2015年 iiseeuu.com. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <UIKit/UIKit.h>
#import <XPStorage/XPStorage.h>

@interface XPBaseStorage : NSObject

/**
 *  @brief  持久化数据
 *
 *  @param value 数据
 *  @param key   关键字
 *
 *  @return 是否成功
 */
- (BOOL)putValue:(id)value forKey:(NSString *)key;

/**
 *  @brief  获取搜索的结构
 *
 *  @return 结构数组
 */
- (NSArray *)getAllItems;

/**
 *  @brief  通过ID获取结构
 *
 *  @param key 关键字
 *
 *  @return 结构
 */
- (XPStorageItem *)getXPStorageItemForKey:(NSString *)key;

/**
 *  @brief  获取持久化数据
 *
 *  @param key 关键字
 *
 *  @return 值
 */
- (id)getValueForKey:(NSString *)key;

/**
 *  @brief  通过ID删除数据
 *
 *  @param key 关键字
 */
- (void)deleteObjectForKey:(NSString *)key;

/**
 *  @brief  通过ID数组删除数据
 *
 *  @param keyArray 关键字数组
 */
- (void)deleteObjectsForKeyArray:(NSArray *)keyArray;

/**
 *  @brief  通过ID前缀删除数据
 *
 *  @param keyPrefix 关键字前缀
 */
- (void)deleteObjectsByKeyPrefix:(NSString *)keyPrefix;

@end
