//
//  MapManager.h
//  XPApp
//
//  Created by Pua on 16/7/12.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MapManager : NSObject <BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    CLLocation *cllocation;
    BMKReverseGeoCodeOption *reverseGeoCodeOption;//逆地理编码
}
@property (strong,nonatomic) BMKLocationService *locService;
//城市名
@property (strong,nonatomic) NSString *cityName;
//用户纬度
@property (nonatomic,assign) double userLatitude;
//用户经度
@property (nonatomic,assign) double userLongitude;
//用户位置
@property (strong,nonatomic) CLLocation *clloction;
//初始化单例
+ (MapManager *)sharedInstance;
//初始化百度地图用户位置管理类
- (void)initBMKUserLocation;
//开始定位
-(void)startLocation;
//停止定位
-(void)stopLocation;
@end