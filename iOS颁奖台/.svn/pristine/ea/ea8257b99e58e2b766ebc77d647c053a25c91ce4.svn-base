//
// Copyright (c) 2014 Zhuge. All rights reserved.

#import "ZGValueTransformers.h"

@implementation ZGBOOLToNSNumberValueTransformer

+ (Class)transformedValueClass
{
    return [@YES class];
}

+ (BOOL)allowsReverseTransformation
{
    return NO;
}

- (id)transformedValue:(id)value
{
    if ([value respondsToSelector:@selector(boolValue)]) {
        return [value boolValue] ? @YES : @NO;
    }

    return nil;
}

@end
