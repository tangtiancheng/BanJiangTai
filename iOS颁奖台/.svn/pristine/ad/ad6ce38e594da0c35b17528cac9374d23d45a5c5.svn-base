//
// Copyright (c) 2014 Zhuge. All rights reserved.

#import <UIKit/UIKit.h>

@interface ZGPassThroughValueTransformer : NSValueTransformer

@end

@interface ZGBOOLToNSNumberValueTransformer : NSValueTransformer

@end

@interface ZGCATransform3DToNSDictionaryValueTransformer : NSValueTransformer

@end

@interface ZGCGAffineTransformToNSDictionaryValueTransformer : NSValueTransformer

@end

@interface ZGCGColorRefToNSStringValueTransformer : NSValueTransformer

@end

@interface ZGCGPointToNSDictionaryValueTransformer : NSValueTransformer

@end

@interface ZGCGRectToNSDictionaryValueTransformer : NSValueTransformer

@end

@interface ZGCGSizeToNSDictionaryValueTransformer : NSValueTransformer

@end

@interface ZGNSAttributedStringToNSDictionaryValueTransformer : NSValueTransformer

@end

@interface ZGUIColorToNSStringValueTransformer : NSValueTransformer

@end

@interface ZGUIEdgeInsetsToNSDictionaryValueTransformer : NSValueTransformer

@end

@interface ZGUIFontToNSDictionaryValueTransformer : NSValueTransformer

@end

@interface ZGUIImageToNSDictionaryValueTransformer : NSValueTransformer

@end

@interface ZGNSNumberToCGFloatValueTransformer : NSValueTransformer

@end

__unused static id transformValue(id value, NSString *toType)
{
    assert(value != nil);

    if ([value isKindOfClass:[NSClassFromString(toType) class]]) {
        return [[NSValueTransformer valueTransformerForName:@"ZGPassThroughValueTransformer"] transformedValue:value];
    }

    NSString *fromType = nil;
    NSArray *validTypes = @[[NSString class], [NSNumber class], [NSDictionary class], [NSArray class], [NSNull class]];
    for (Class c in validTypes) {
        if ([value isKindOfClass:c]) {
            fromType = NSStringFromClass(c);
            break;
        }
    }

    assert(fromType != nil);
    NSValueTransformer *transformer = nil;
    NSString *forwardTransformerName = [NSString stringWithFormat:@"ZG%@To%@ValueTransformer", fromType, toType];
    transformer = [NSValueTransformer valueTransformerForName:forwardTransformerName];
    if (transformer) {
        return [transformer transformedValue:value];
    }

    NSString *reverseTransformerName = [NSString stringWithFormat:@"ZG%@To%@ValueTransformer", toType, fromType];
    transformer = [NSValueTransformer valueTransformerForName:reverseTransformerName];
    if (transformer && [[transformer class] allowsReverseTransformation]) {
        return [transformer reverseTransformedValue:value];
    }

    return [[NSValueTransformer valueTransformerForName:@"ZGPassThroughValueTransformer"] transformedValue:value];
}
