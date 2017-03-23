//
//  AppDelegate+extension.m
//  XPApp
//
//  Created by huangxinping on 15/7/2.
//  Copyright (c) 2015年 iiseeuu.com. All rights reserved.
//

#import "AppDelegate+extension.h"

#import <CoreImage/CoreImage.h>//可以用滤镜来处理图片的第三方

// 全局配置
#import <XPAutoNIBColor/XPAutoNIBColor.h>
#import <XPAutoNIBi18n/XPAutoNIBi18n.h>

// Debug
//#import <AFNetworkActivityLogger/AFNetworkActivityLogger.h>
#import <AFNetworking/AFNetworkReachabilityManager.h>
//#import <AFNetworkingMeter/AFNetworkingMeter.h>
//#import <Bugtags/Bugtags.h>
//#import <NSLogger/NSLogger.h>

// 项目
#import "XPBaseViewController.h"
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <UISS/UISS.h>
#import <XPKit/XPKit.h>
#import <XPToast/XPToast.h>

// 分享&登录
#import "WXApi.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

// 推送
#import <JPush/JPUSHService.h>
#import <MMPReactiveNotification/MMPReactiveNotification.h>

// 统计分析
#import "XPLoginModel.h"
#import "XPMotionManager.h"
#import <UMengAnalytics-NO-IDFA/MobClick.h>
#import <Zhugeio/Zhuge.h>

//百度地图
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

@implementation AppDelegate (TestCase)

- (BOOL)minimumTestCase
{
    NSDictionary *environment = [[NSProcessInfo processInfo] environment];
    NSString *injectBundle = environment[@"XCInjectBundle"];
    BOOL isRunningTests = [[injectBundle pathExtension] isEqualToString:@"octest"];
    return isRunningTests;
}

@end

@implementation AppDelegate (SystemSetting)

- (void)configSettingBundle
{
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];//获取发布版本号相关信息
    
    [[NSUserDefaults standardUserDefaults] setObject:version
                                              forKey:@"version_preference"];//发布版本信息  存储
    
    NSString *build = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]; //开发版本信息
    [[NSUserDefaults standardUserDefaults] setObject:build
                                              forKey:@"build_preference"];//存储
    
    NSString *githash = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"GITHash"];
    [[NSUserDefaults standardUserDefaults] setObject:githash
                                              forKey:@"githash_preference"];
}

@end

@implementation AppDelegate (Theme)

- (void)configTheme
{
    [NSBundle setLanguage:@"zh-Hans"];
    UIColor *primaryColor = [UIColor colorWithRed:0.784 green:0.259 blue:0.251 alpha:1.000];
    UIColor *secondaryColor = [UIColor whiteColor];
    UIColor *tertiaryColor = [UIColor colorWithWhite:0.486 alpha:1.000];
    [XPAutoNIBColor setAutoNIBColorWithPrimaryColor:primaryColor secondaryColor:secondaryColor tertiaryColor:tertiaryColor, [UIColor colorWithWhite:0.565 alpha:1.000], nil];
    UISS * sharedUISS = [UISS configureWithDefaultJSONFile];
    sharedUISS.statusWindowEnabled = NO;
    sharedUISS.autoReloadEnabled = YES;
    sharedUISS.autoReloadTimeInterval = 1;
}

@end

@implementation AppDelegate (Debug)

- (void)configDebug
{
#if DEBUG
    //    [[AFNetworkActivityLogger sharedLogger] setLevel:AFLoggerLevelDebug];
    //    [[AFNetworkActivityLogger sharedLogger] startLogging];
    
    //    [[AFNetworkingMeter sharedMeter] startMeter];
    
    //    [Bugtags startWithAppKey:@"a5374c505e9ce48e036a107d7737a019" invocationEvent:BTGInvocationEventBubble];
#endif
}

- (void)configRemoteDebug
{
    //    LoggerSetViewerHost(NULL, (__bridge CFStringRef)@"192.168.0.195", (UInt32)50000);
    //    // configure the default logger
    //    LoggerSetOptions(NULL, kLoggerOption_BufferLogsUntilConnection |
    //                     kLoggerOption_UseSSL |
    //                     kLoggerOption_CaptureSystemConsole |
    //                     kLoggerOption_BrowseBonjour |
    //                     kLoggerOption_BrowseOnlyLocalDomain);
}

@end

@implementation AppDelegate (Reachability)

- (void)configReachability
{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:2 * 1024 * 1024
                                                            diskCapacity:100 * 01024 * 1024
                                                                diskPath:nil];
    [NSURLCache setSharedURLCache:sharedCache];//网络缓存机制
    
    static BOOL tipShow = NO;
    static AFNetworkReachabilityStatus lastNetworkStatus = AFNetworkReachabilityStatusUnknown;
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(lastNetworkStatus != status && tipShow) {
            switch(status) {
                case AFNetworkReachabilityStatusUnknown:
                case AFNetworkReachabilityStatusNotReachable: {
                    [SVProgressHUD showErrorWithStatus:@"网络连接丢失"];
                    break;
                }
                    
                case AFNetworkReachabilityStatusReachableViaWWAN: {
                    [SVProgressHUD showInfoWithStatus:@"切换至蜂窝"];
                    break;
                }
                    
                case AFNetworkReachabilityStatusReachableViaWiFi: {
                    [SVProgressHUD showInfoWithStatus:@"切换至Wi-Fi"];
                    break;
                }
                    
                default: {
                    break;
                }
            }
        }
        
        lastNetworkStatus = status;
        tipShow = YES;
    }];
}

@end


@implementation AppDelegate (UMeng)

- (void)configUMeng
{
    [MobClick startWithAppkey:@"5695e034e0f55aff490009dd"];
}

@end

@implementation AppDelegate (ZhugeIO)

- (void)configZhugeIOWithLaunchOptions:(NSDictionary *)launchOptions
{
    [[Zhuge sharedInstance] startWithAppKey:@"717dff9ee9c646f583bd084ffba89e9f"
                              launchOptions:launchOptions];
}

@end

@implementation AppDelegate (ShareSDK)

- (void)configShareSDK
{
    [ShareSDK registerApp:@"f08a622dc7a4"
          activePlatforms:@[
                        @(SSDKPlatformTypeWechat)
                            ]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch(platformType) {
             case SSDKPlatformTypeWechat: {
                 [ShareSDKConnector connectWeChat:[WXApi class]];
             }
                 break;
                 
             default: {
             }
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         switch(platformType) {
             case SSDKPlatformTypeWechat: {
                 [appInfo SSDKSetupWeChatByAppId:@"wxff535b32d728b592"
                                       appSecret:@"7d8f9587d6de7f88f1ca91fae1259872"];
             }
                 break;
                 
             default: {
             }
                 break;
         }
     }];
}

@end

@implementation AppDelegate (Push)

- (void)configAPNSWithLaunchOptions:(NSDictionary *)launchOptions
{
    // 获取并存储token  把tokendata传送给极光
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [[[MMPReactiveNotification service]
      remoteRegistration]
     subscribeNext:^(NSData *tokenData) {
         NSString *deviceTokenString = [[[[tokenData description]
                                          stringByReplacingOccurrencesOfString:@"<" withString:@""]
                                         stringByReplacingOccurrencesOfString:@">" withString:@""]
                                        stringByReplacingOccurrencesOfString:@" " withString:@""];
         XPLog(@"Receiving push token: %@", deviceTokenString);
         //         @"8572cddea83671e70965181a663c0ad9b36b276e56bc6f070bde98a1f6735588";
         [[NSUserDefaults standardUserDefaults] setObject:deviceTokenString forKey:@"deviceToken"];
         [JPUSHService registerDeviceToken:tokenData];
     }
     error:^(NSError *error) {
         XPLog(@"Push registration error: %@", error);
     }];
    //  极光获取pushdata
    [[[MMPReactiveNotification service]
      remoteNotifications]
     subscribeNext:^(NSDictionary *pushData) {
         XPLog(@"Receiving push: %@", pushData);
         [JPUSHService handleRemoteNotification:pushData];
         
         if([pushData[@"broadcastAction"] isEqualToString:@"byLogin"]) {
             if([XPLoginModel singleton].signIn) {
                 [(XPBaseViewController *)[[(UITabBarController *)self.window.rootViewController selectedViewController] visibleViewController] presentLogin];
                 //
                 
                 [UIAlertView alertViewWithTitle:nil message:[NSString stringWithFormat:@"你的颁奖台账号在于%@在另一个设备登录，如果这不是你的操作，你的账号可能存在被盗取的风险。", pushData[@"time"]] block:^(NSInteger buttonIndex) {
                 }
                                     buttonTitle:@"确定"];
             }
         } else if([pushData[@"broadcastAction"] isEqualToString:@"message"]) {
             
             
         }
     }];
    //    if(!launchOptions) {
    //        return;
    //    }
    
    [JPUSHService setupWithOption:launchOptions appKey:@"899284cfa5e9d1c9876cfa5f" channel:@"AppStore" apsForProduction:NO];
}

@end

@implementation AppDelegate (Motion)

- (void)configMotion
{
    [[XPMotionManager sharedInstance] startDetection];
}

@end

@implementation AppDelegate(BMap)

- (void)configBaiduMap
{
    BMKMapManager* _mapManager=[[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"ejLWrTHZhbrXG37yIXj2ubETNax4uflx"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }

}

@end
