//
// Copyright (c) 2014 Zhuge. All rights reserved.

#import <Foundation/Foundation.h>
#import "ZGAbstractABTestDesignerMessage.h"

@interface ZGABTestDesignerDeviceInfoResponseMessage : ZGAbstractABTestDesignerMessage

+ (instancetype)message;

@property (nonatomic, copy) NSString *systemName;
@property (nonatomic, copy) NSString *systemVersion;
@property (nonatomic, copy) NSString *appVersion;
@property (nonatomic, copy) NSString *appRelease;
@property (nonatomic, copy) NSString *deviceName;
@property (nonatomic, copy) NSString *deviceModel;
@property (nonatomic, copy) NSString *libVersion;
@property (nonatomic, copy) NSArray *availableFontFamilies;
@property (nonatomic, copy) NSString *mainBundleIdentifier;
@property (nonatomic, copy) NSArray *tweaks;

@end
