//
// Copyright (c) 2014 Zhuge. All rights reserved.

#import <Foundation/Foundation.h>

@class ZGObjectSerializerContext;

@interface ZGPropertySelectorParameterDescription : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *type;

@end

@interface ZGPropertySelectorDescription : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@property (nonatomic, readonly) NSString *selectorName;
@property (nonatomic, readonly) NSString *returnType;
@property (nonatomic, readonly) NSArray *parameters; // array of ZGPropertySelectorParameterDescription

@end

@interface ZGPropertyDescription : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, readonly) NSString *type;
@property (nonatomic, readonly) BOOL readonly;
@property (nonatomic, readonly) BOOL nofollow;
@property (nonatomic, readonly) BOOL useKeyValueCoding;
@property (nonatomic, readonly) BOOL useInstanceVariableAccess;
@property (nonatomic, readonly) NSString *name;

@property (nonatomic, readonly) ZGPropertySelectorDescription *getSelectorDescription;
@property (nonatomic, readonly) ZGPropertySelectorDescription *setSelectorDescription;

- (BOOL)shouldReadPropertyValueForObject:(NSObject *)object;

- (NSValueTransformer *)valueTransformer;

@end
