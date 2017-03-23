//
// Copyright (c) 2014 Zhuge. All rights reserved.

#import "ZGClassDescription.h"
#import "ZGEnumDescription.h"
#import "ZGObjectSerializerConfig.h"
#import "ZGTypeDescription.h"

@implementation ZGObjectSerializerConfig

{
    NSDictionary *_classes;
    NSDictionary *_enums;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        NSMutableDictionary *classDescriptions = [[NSMutableDictionary alloc] init];
        for (NSDictionary *d in dictionary[@"classes"]) {
            NSString *superclassName = d[@"superclass"];
            ZGClassDescription *superclassDescription = superclassName ? classDescriptions[superclassName] : nil;
            ZGClassDescription *classDescription = [[ZGClassDescription alloc] initWithSuperclassDescription:superclassDescription
                                                                                                  dictionary:d];

            classDescriptions[classDescription.name] = classDescription;
        }

        NSMutableDictionary *enumDescriptions = [[NSMutableDictionary alloc] init];
        for (NSDictionary *d in dictionary[@"enums"]) {
            ZGEnumDescription *enumDescription = [[ZGEnumDescription alloc] initWithDictionary:d];
            enumDescriptions[enumDescription.name] = enumDescription;
        }

        _classes = [classDescriptions copy];
        _enums = [enumDescriptions copy];
    }

    return self;
}

- (NSArray *)classDescriptions
{
    return [_classes allValues];
}

- (ZGEnumDescription *)enumWithName:(NSString *)name
{
    return _enums[name];
}

- (ZGClassDescription *)classWithName:(NSString *)name
{
    return _classes[name];
}

- (ZGTypeDescription *)typeWithName:(NSString *)name
{
    ZGEnumDescription *enumDescription = [self enumWithName:name];
    if (enumDescription) {
        return enumDescription;
    }

    ZGClassDescription *classDescription = [self classWithName:name];
    if (classDescription) {
        return classDescription;
    }

    return nil;
}

@end
