//
// Copyright (c) 2014 Zhuge. All rights reserved.

#import <Foundation/Foundation.h>

@class ZGClassDescription;
@class ZGObjectSerializerContext;
@class ZGObjectSerializerConfig;
@class ZGObjectIdentityProvider;

@interface ZGObjectSerializer : NSObject

/*!
 @param     An array of ZGClassDescription instances.
 */
- (instancetype)initWithConfiguration:(ZGObjectSerializerConfig *)configuration objectIdentityProvider:(ZGObjectIdentityProvider *)objectIdentityProvider;

- (NSDictionary *)serializedObjectsWithRootObject:(id)rootObject;

@end
