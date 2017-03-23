//
// Copyright (c) 2014 Zhuge. All rights reserved.

#import <Foundation/Foundation.h>
#import "ZGWebSocket.h"

@protocol ZGABTestDesignerMessage;

@interface ZGABTestDesignerConnection : NSObject

@property (nonatomic, readonly) BOOL connected;
@property (nonatomic, assign) BOOL sessionEnded;

- (instancetype)initWithURL:(NSURL *)url;
- (instancetype)initWithURL:(NSURL *)url keepTrying:(BOOL)keepTrying connectCallback:(void (^)())connectCallback disconnectCallback:(void (^)())disconnectCallback;

- (void)setSessionObject:(id)object forKey:(NSString *)key;
- (id)sessionObjectForKey:(NSString *)key;
- (void)sendMessage:(id<ZGABTestDesignerMessage>)message;
- (void)close;

@end
