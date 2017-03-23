//
// Copyright (c) 2014 Zhuge. All rights reserved.

#import <Foundation/Foundation.h>

@class ZGABTestDesignerConnection;

@protocol ZGABTestDesignerMessage <NSObject>

@property (nonatomic, copy, readonly) NSString *type;

- (void)setPayloadObject:(id)object forKey:(NSString *)key;
- (id)payloadObjectForKey:(NSString *)key;

- (NSData *)JSONData;

- (NSOperation *)responseCommandWithConnection:(ZGABTestDesignerConnection *)connection;

@end
