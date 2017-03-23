//
// Copyright (c) 2014 Zhuge. All rights reserved.

#import <Foundation/Foundation.h>
#import "ZGTypeDescription.h"

@interface ZGClassDescription : ZGTypeDescription

@property (nonatomic, readonly) ZGClassDescription *superclassDescription;
@property (nonatomic, readonly) NSArray *propertyDescriptions;
@property (nonatomic, readonly) NSArray *delegateInfos;

- (instancetype)initWithSuperclassDescription:(ZGClassDescription *)superclassDescription dictionary:(NSDictionary *)dictionary;

- (BOOL)isDescriptionForKindOfClass:(Class)class;

@end

@interface ZGDelegateInfo : NSObject

@property (nonatomic, readonly) NSString *selectorName;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
