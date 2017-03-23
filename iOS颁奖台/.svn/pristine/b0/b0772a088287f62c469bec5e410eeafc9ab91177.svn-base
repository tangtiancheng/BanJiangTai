//
// Copyright (c) 2014 Zhuge. All rights reserved.

#import "ZGValueTransformers.h"

@implementation ZGPassThroughValueTransformer

+ (Class)transformedValueClass
{
    return [NSObject class];
}

+ (BOOL)allowsReverseTransformation
{
    return NO;
}

- (id)transformedValue:(id)value
{
    if ([[NSNull null] isEqual:value]) {
        return nil;
    }

    if (value == nil) {
        return [NSNull null];
    }

    return value;
}

@end
