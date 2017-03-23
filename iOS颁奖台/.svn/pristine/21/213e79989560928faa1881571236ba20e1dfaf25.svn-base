//
//  AppDelegate.m
//  XPApp
//
//  Created by huangxinping on 15/10/31.
//  Copyright © 2015年 ShareMerge. All rights reserved.
//

#import "AppDelegate+extension.h"
#import "AppDelegate.h"
#import <SDImageCache.h>
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    @IgnoreTestCase
    self.window.backgroundColor = [UIColor whiteColor];
    [self configSettingBundle];
    [self configTheme];
    [self configDebug];
    [self configRemoteDebug];
    [self configReachability];
    [self configUMeng];
    [self configZhugeIOWithLaunchOptions:launchOptions];
    [self configShareSDK];
    [self configAPNSWithLaunchOptions:launchOptions];
    [self configMotion];
    [self configBaiduMap];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [[SDImageCache sharedImageCache]clearDisk];
}
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 90000
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL succeeded))completionHandler
{
}

#endif

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 90000
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *__nullable restorableObjects))restorationHandler
{
    NSString *friendID = userActivity.userInfo[@"kCSSearchableItemActivityIdentifier"];
    NSLog(@"%@", friendID);
    return YES;
}

#endif

@end
