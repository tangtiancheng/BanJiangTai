//
// Copyright (c) 2014 Zhuge. All rights reserved.

#import <Foundation/Foundation.h>
#import "ZGABTestDesignerMessage.h"
@interface ZGAbstractABTestDesignerMessage : NSObject <ZGABTestDesignerMessage>

@property (nonatomic, copy, readonly) NSString *type;

+ (instancetype)messageWithType:(NSString *)type payload:(NSDictionary *)payload;

- (instancetype)initWithType:(NSString *)type;
- (instancetype)initWithType:(NSString *)type payload:(NSDictionary *)payload;

- (void)setPayloadObject:(id)object forKey:(NSString *)key;
- (id)payloadObjectForKey:(NSString *)key;
- (NSDictionary *)payload;

- (NSData *)JSONData;

@end
