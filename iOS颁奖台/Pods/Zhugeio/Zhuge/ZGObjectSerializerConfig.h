//
// Copyright (c) 2014 Zhuge. All rights reserved.

#import <Foundation/Foundation.h>

@class ZGEnumDescription;
@class ZGClassDescription;
@class ZGTypeDescription;


@interface ZGObjectSerializerConfig : NSObject

@property (nonatomic, readonly) NSArray *classDescriptions;
@property (nonatomic, readonly) NSArray *enumDescriptions;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (ZGTypeDescription *)typeWithName:(NSString *)name;
- (ZGEnumDescription *)enumWithName:(NSString *)name;
- (ZGClassDescription *)classWithName:(NSString *)name;

@end
