//
// Copyright (c) 2014 Zhuge. All rights reserved.

#import <QuartzCore/QuartzCore.h>
#import "ZGApplicationStateSerializer.h"
#import "ZGClassDescription.h"
#import "ZGLog.h"
#import "ZGObjectIdentityProvider.h"
#import "ZGObjectSerializer.h"
#import "ZGObjectSerializerConfig.h"

@implementation ZGApplicationStateSerializer

{
    ZGObjectSerializer *_serializer;
    UIApplication *_application;
}

- (instancetype)initWithApplication:(UIApplication *)application configuration:(ZGObjectSerializerConfig *)configuration objectIdentityProvider:(ZGObjectIdentityProvider *)objectIdentityProvider
{
    NSParameterAssert(application != nil);
    NSParameterAssert(configuration != nil);

    self = [super init];
    if (self) {
        _application = application;
        _serializer = [[ZGObjectSerializer alloc] initWithConfiguration:configuration objectIdentityProvider:objectIdentityProvider];
    }

    return self;
}

- (UIImage *)screenshotImageForWindowAtIndex:(NSUInteger)index
{
    UIImage *image = nil;

    UIWindow *window = [self windowAtIndex:index];
    if (window && !CGRectEqualToRect(window.frame, CGRectZero)) {
        UIGraphicsBeginImageContextWithOptions(window.bounds.size, YES, window.screen.scale);
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
            if ([window drawViewHierarchyInRect:window.bounds afterScreenUpdates:NO] == NO) {
                ZhugeDebug(@"Unable to get complete screenshot for window at index: %d.", (int)index);
            }
        } else {
            [window.layer renderInContext:UIGraphicsGetCurrentContext()];
        }
#else
        [window.layer renderInContext:UIGraphicsGetCurrentContext()];
#endif
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }

    return image;
}

- (UIWindow *)windowAtIndex:(NSUInteger)index
{
    NSParameterAssert(index < [_application.windows count]);
    return _application.windows[index];
}

- (NSDictionary *)objectHierarchyForWindowAtIndex:(NSUInteger)index
{
    UIWindow *window = [self windowAtIndex:index];
    if (window) {
        return [_serializer serializedObjectsWithRootObject:window];
    }

    return @{};
}

@end
