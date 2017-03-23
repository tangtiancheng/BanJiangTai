//
// Copyright (c) 2014 Zhuge. All rights reserved.

#import <Foundation/Foundation.h>

@interface ZGTypeDescription : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, readonly) NSString *name;

@end
