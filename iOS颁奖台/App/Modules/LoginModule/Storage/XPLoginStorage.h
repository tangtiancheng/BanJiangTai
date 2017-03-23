//
//  XPLoginStorage.h
//  XPApp
//
//  Created by huangxinping on 15/9/23.
//  Copyright © 2015年 iiseeuu.com. All rights reserved.
//

#import "XPBaseStorage.h"
#import "XPUser.h"

@interface XPLoginStorage : XPBaseStorage

/**
 *  是否有缓存数据
 *
 *  @return 如果有缓存，则返回YES
 */
+ (BOOL)cached;

/**
 *  清理缓存用户数据
 */
+ (void)clearCached;

/**
 *  获取用户信息从缓存中
 *
 *  @return 用户信息
 */
+ (XPUser *)userWithRowLogin;

/**
 *  保存用户信息到本地
 *
 *  @param user 用户信息
 *
 *  @return 是否保存成功
 */
+ (BOOL)storageWithUser:(XPUser *)user;

@end
