//
// Copyright (c) 2014 Zhuge. All rights reserved.

#import <UIKit/UIKit.h>

@class ZGObjectSerializerConfig;
@class ZGObjectIdentityProvider;

@interface ZGApplicationStateSerializer : NSObject

- (instancetype)initWithApplication:(UIApplication *)application configuration:(ZGObjectSerializerConfig *)configuration objectIdentityProvider:(ZGObjectIdentityProvider *)objectIdentityProvider;

- (UIImage *)screenshotImageForWindowAtIndex:(NSUInteger)index;

- (NSDictionary *)objectHierarchyForWindowAtIndex:(NSUInteger)index;

@end
