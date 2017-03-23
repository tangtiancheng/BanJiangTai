//
// Copyright (c) 2014 Zhuge. All rights reserved.

#import "ZGObjectIdentityProvider.h"
#import "ZGSequenceGenerator.h"

@implementation ZGObjectIdentityProvider

{
    NSMapTable *_objectToIdentifierMap;
    ZGSequenceGenerator *_sequenceGenerator;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _objectToIdentifierMap = [NSMapTable weakToStrongObjectsMapTable];
        _sequenceGenerator = [[ZGSequenceGenerator alloc] init];
    }

    return self;
}

- (NSString *)identifierForObject:(id)object
{
    if ([object isKindOfClass:[NSString class]]) {
        return object;
    }
    NSString *identifier = [_objectToIdentifierMap objectForKey:object];
    if (identifier == nil) {
        identifier = [NSString stringWithFormat:@"$%" PRIi32, [_sequenceGenerator nextValue]];
        [_objectToIdentifierMap setObject:identifier forKey:object];
    }

    return identifier;
}

@end
