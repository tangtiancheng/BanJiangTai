//
// Copyright (c) 2014 Zhuge. All rights reserved.

#import "ZGValueTransformers.h"

@implementation ZGNSNumberToCGFloatValueTransformer

+ (Class)transformedValueClass
{
    return [NSNumber class];
}

+ (BOOL)allowsReverseTransformation
{
    return NO;
}

- (id)transformedValue:(id)value
{
    if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber *number = (NSNumber *) value;

        // if the number is not a cgfloat, cast it to a cgfloat
        if (strcmp([number objCType], (char *) @encode(CGFloat)) != 0) {
            if (strcmp((char *) @encode(CGFloat), (char *) @encode(double)) == 0) {
                value = @([number doubleValue]);
            } else {
                value = @([number floatValue]);
            }
        }

        return value;
    }

    return nil;
}

@end
