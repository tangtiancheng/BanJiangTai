//
// Copyright (c) 2014 Zhuge. All rights reserved.

#import <Foundation/Foundation.h>

@interface ZGObjectSerializerContext : NSObject

- (instancetype)initWithRootObject:(id)object;

- (BOOL)hasUnvisitedObjects;

- (void)enqueueUnvisitedObject:(NSObject *)object;
- (NSObject *)dequeueUnvisitedObject;

- (void)addVisitedObject:(NSObject *)object;
- (BOOL)isVisitedObject:(NSObject *)object;

- (void)addSerializedObject:(NSDictionary *)serializedObject;
- (NSArray *)allSerializedObjects;

@end
