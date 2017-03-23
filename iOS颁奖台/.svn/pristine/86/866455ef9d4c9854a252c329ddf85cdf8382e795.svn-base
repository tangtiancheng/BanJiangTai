//
//  MapManager.m
//  XPApp
//
//  Created by Pua on 16/7/12.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "MapManager.h"


@implementation MapManager
+ (MapManager *)sharedInstance
{
    static MapManager *_instance = nil;
    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }
    return _instance;
}
-(id)init
{
    if (self == [super init])
    {
        [self initBMKUserLocation];
    }
    return self;
}
#pragma 初始化百度地图用户位置管理类
/**
 * 初始化百度地图用户位置管理类
 */
- (void)initBMKUserLocation
{
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [self startLocation];
}
#pragma 打开定位服务
/**
 * 打开定位服务
 */
-(void)startLocation
{
    [_locService startUserLocationService];
}
#pragma 关闭定位服务
/**
 * 关闭定位服务
 */
-(void)stopLocation
{
    [_locService stopUserLocationService];
}
#pragma BMKLocationServiceDelegate
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    cllocation = userLocation.location;
    _clloction = cllocation;
    _userLatitude = cllocation.coordinate.latitude;
    _userLongitude = cllocation.coordinate.longitude;
    [self stopLocation];//(如果需要实时定位不用停止定位服务)
}
/**
 *在停止定位后，会调用此函数
 */
- (void)didStopLocatingUser
{
    
}
/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    [self stopLocation];
}
@end