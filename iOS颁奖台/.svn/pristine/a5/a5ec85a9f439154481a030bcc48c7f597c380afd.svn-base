//
//  AppDelegate+AppDelegate_extension.h
//  XPApp
//
//  Created by huangxinping on 15/7/2.
//  Copyright (c) 2015年 iiseeuu.com. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (TestCase)

- (BOOL)minimumTestCase;

#ifndef IgnoreTestCase
#define IgnoreTestCase autoreleasepool {} \
if([self minimumTestCase]) { return YES; }
#endif

@end

@interface AppDelegate (SystemSetting)


/**
 *  配置系统设置（方便查看Verison及Git）
 */
- (void)configSettingBundle;

@end

@interface AppDelegate (Theme)

/**
 *  配置主题
 */
- (void)configTheme;

@end

@interface AppDelegate (Debug)

/**
 *  配置Debug
 */
- (void)configDebug;

/**
 *  配置远程Debug
 */
- (void)configRemoteDebug;

@end

@interface AppDelegate (Reachability)

/**
 *  配置Reachability
 */
- (void)configReachability;

@end

@interface AppDelegate (UMeng)

- (void)configUMeng;

@end

@interface AppDelegate (ZhugeIO)

- (void)configZhugeIOWithLaunchOptions:(NSDictionary *)launchOptions;

@end

@interface AppDelegate (ShareSDK)

- (void)configShareSDK;

@end

@interface AppDelegate (Push)

- (void)configAPNSWithLaunchOptions:(NSDictionary *)launchOptions;

@end

@interface AppDelegate (Motion)

- (void)configMotion;

@end

/**
 *  配置百度地图
 */
@interface AppDelegate (BMap)

- (void)configBaiduMap;

@end

