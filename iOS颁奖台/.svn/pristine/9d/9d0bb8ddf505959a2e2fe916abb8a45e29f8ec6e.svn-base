/**
 *  XPFMDBEncryptHelper.h
 *  ShareMerge
 *
 *  Created by huangxp on 2015-09-02.
 *
 *  FMDB+SQLCipher加密核心
 *
 *  Copyright (c) www.sharemerge.com All rights reserved.
 */

/** @file */    // Doxygen marker

#import <Foundation/Foundation.h>

@interface XPFMDBEncryptHelper : NSObject

/**
*  @brief  对数据库加密（文件不变）
*
*  @param path 数据库文件全路径
*
*  @return 是否加密成功   
*/
+ (BOOL)encryptDatabase:(NSString *)path;

/**
 *  @brief  对数据库解密（文件不变）
 *
 *  @param path 数据库文件（全路径）
 *
 *  @return 是否解密成功
 */
+ (BOOL)unEncryptDatabase:(NSString *)path;

/**
 *  @brief  对数据库加密（文件改变）
 *
 *  @param sourcePath 数据库源文件（全路径）
 *  @param targetPath 数据库目标文件（全路径）
 *
 *  @return 是否加密成功
 */
+ (BOOL)encryptDatabase:(NSString *)sourcePath targetPath:(NSString *)targetPath;

/**
 *  @brief  对数据库解密（文件改变）
 *
 *  @param sourcePath 数据库源文件（全路径）
 *  @param targetPath 数据库目标文件（全路径）
 *
 *  @return 是否解密成功
 */
+ (BOOL)unEncryptDatabase:(NSString *)sourcePath targetPath:(NSString *)targetPath;

/**
 *  @brief  修改数据库秘钥
 *
 *  @param dbPath    数据库文件（全路径）
 *  @param originKey 原加密key
 *  @param newKey    新加密key
 *
 *  @return 是否修改成功
 */
+ (BOOL)changeKey:(NSString *)dbPath originKey:(NSString *)originKey newKey:(NSString *)newKey;

@end
