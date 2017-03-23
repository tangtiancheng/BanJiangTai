//
// Copyright (c) 2014 Zhuge. All rights reserved.

#import "ZGABTestDesignerConnection.h"
#import "ZGABTestDesignerSnapshotRequestMessage.h"
#import "ZGABTestDesignerSnapshotResponseMessage.h"
#import "ZGApplicationStateSerializer.h"
#import "ZGObjectIdentityProvider.h"
#import "ZGObjectSerializerConfig.h"

NSString * const ZGABTestDesignerSnapshotRequestMessageType = @"snapshot_request";

static NSString * const kSnapshotSerializerConfigKey = @"snapshot_class_descriptions";
static NSString * const kObjectIdentityProviderKey = @"object_identity_provider";

@implementation ZGABTestDesignerSnapshotRequestMessage

+ (instancetype)message
{
    return [[self alloc] initWithType:ZGABTestDesignerSnapshotRequestMessageType];
}

- (ZGObjectSerializerConfig *)configuration
{
    NSDictionary *config =
    [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"snapshot_config" withExtension:@"json"]]
                                    options:0 error:nil];

    return config ? [[ZGObjectSerializerConfig alloc] initWithDictionary:config] : nil;
}

- (NSOperation *)responseCommandWithConnection:(ZGABTestDesignerConnection *)connection
{
    __block ZGObjectSerializerConfig *serializerConfig = self.configuration;
    __block NSString *imageHash = [self payloadObjectForKey:@"image_hash"];
    __weak ZGABTestDesignerConnection *weak_connection = connection;
    NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        __strong ZGABTestDesignerConnection *conn = weak_connection;

        // Update the class descriptions in the connection session if provided as part of the message.
        if (serializerConfig) {
            [connection setSessionObject:serializerConfig forKey:kSnapshotSerializerConfigKey];
        } else if ([connection sessionObjectForKey:kSnapshotSerializerConfigKey]){
            // Get the class descriptions from the connection session store.
            serializerConfig = [connection sessionObjectForKey:kSnapshotSerializerConfigKey];
        } else {
            // If neither place has a config, this is probably a stale message and we can't create a snapshot.
            return;
        }

        // Get the object identity provider from the connection's session store or create one if there is none already.
        ZGObjectIdentityProvider *objectIdentityProvider = [connection sessionObjectForKey:kObjectIdentityProviderKey];
        if (objectIdentityProvider == nil) {
            objectIdentityProvider = [[ZGObjectIdentityProvider alloc] init];
            [connection setSessionObject:objectIdentityProvider forKey:kObjectIdentityProviderKey];
        }

        ZGApplicationStateSerializer *serializer = [[ZGApplicationStateSerializer alloc] initWithApplication:[UIApplication sharedApplication]
            configuration:serializerConfig
            objectIdentityProvider:objectIdentityProvider];

        ZGABTestDesignerSnapshotResponseMessage *snapshotMessage = [ZGABTestDesignerSnapshotResponseMessage message];
        __block UIImage *screenshot = nil;
        __block NSDictionary *serializedObjects = nil;

        dispatch_sync(dispatch_get_main_queue(), ^{
            screenshot = [serializer screenshotImageForWindowAtIndex:0];
        });
        snapshotMessage.screenshot = screenshot;
        if (imageHash && [imageHash isEqualToString:snapshotMessage.imageHash]) {
//            serializedObjects = [connection sessionObjectForKey:@"snapshot_hierarchy"];
            return;
        } else {
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                serializedObjects = [serializer objectHierarchyForWindowAtIndex:0];
            });
//            [connection setSessionObject:serializedObjects forKey:@"snapshot_hierarchy"];
            snapshotMessage.serializedObjects = serializedObjects;
//            snapshotMessage.serializedObjects = @{@"a":@"b"};

            [conn sendMessage:snapshotMessage];

        }

    }];

    return operation;
}

@end
