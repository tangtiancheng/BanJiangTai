//
//  NSDictionary+XPAPIParameters.h
//  Huaban
//
//  Created by huangxinping on 4/24/15.
//  Copyright (c) 2015 iiseeuu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (XPDeviceInfo)

/**
 *  填充设备信息
 *
 *  @return 填充过的请求参数
 */
- (NSDictionary *)fillDeviceInfo;

@end
