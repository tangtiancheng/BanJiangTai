//
//  ZGDesignerTrackMessage.m
//  HelloZhuge
//
//  Created by Amanda Canyon on 9/3/14.
//  Copyright (c) 2014 Zhuge. All rights reserved.
//

#import "ZGDesignerEventBindingMessage.h"
#import "ZGLog.h"
@implementation ZGDesignerTrackMessage

{
    NSDictionary *_payload;
}

+ (instancetype)message
{
    return [[self alloc] initWithType:@"track_message"];
}

+ (instancetype)messageWithPayload:(NSDictionary *)payload
{
    return[[self alloc] initWithType:@"track_message" andPayload:payload];
}

- (instancetype)initWithType:(NSString *)type
{
    return [self initWithType:type andPayload:@{}];
}

- (instancetype)initWithType:(NSString *)type andPayload:(NSDictionary *)payload
{
    if (self = [super initWithType:type]) {
        _payload = payload;
    }
    return self;
}

- (NSData *)JSONData
{
    NSDictionary *jsonObject = @{ @"type" : self.type, @"payload" : [_payload copy] };

    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:0 error:&error];
    if (error) {
        ZhugeDebug(@"Failed to serialize test designer message: %@", error);
    }

    return jsonData;
}

@end
