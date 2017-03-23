//
// Copyright (c) 2014 Zhuge. All rights reserved.

#import "ZGClassDescription.h"
#import "ZGPropertyDescription.h"

@implementation ZGDelegateInfo

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        _selectorName = dictionary[@"selector"];
    }
    return self;
}

@end

@implementation ZGClassDescription

{
    NSArray *_propertyDescriptions;
    NSArray *_delegateInfos;
}

- (instancetype)initWithSuperclassDescription:(ZGClassDescription *)superclassDescription dictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        _superclassDescription = superclassDescription;

        NSMutableArray *propertyDescriptions = [NSMutableArray array];
        for (NSDictionary *propertyDictionary in dictionary[@"properties"]) {
            [propertyDescriptions addObject:[[ZGPropertyDescription alloc] initWithDictionary:propertyDictionary]];
        }

        _propertyDescriptions = [propertyDescriptions copy];

        NSMutableArray *delegateInfos = [NSMutableArray array];
        for (NSDictionary *delegateInfoDictionary in dictionary[@"delegateImplements"]) {
            [delegateInfos addObject:[[ZGDelegateInfo alloc] initWithDictionary:delegateInfoDictionary]];
        }
        _delegateInfos = [delegateInfos copy];
    }

    return self;
}

- (NSArray *)propertyDescriptions
{
    NSMutableDictionary *allPropertyDescriptions = [[NSMutableDictionary alloc] init];

    ZGClassDescription *description = self;
    while (description)
    {
        for (ZGPropertyDescription *propertyDescription in description->_propertyDescriptions) {
            if (!allPropertyDescriptions[propertyDescription.name]) {
                allPropertyDescriptions[propertyDescription.name] = propertyDescription;
            }
        }
        description = description.superclassDescription;
    }

    return [allPropertyDescriptions allValues];
}

- (BOOL)isDescriptionForKindOfClass:(Class)class
{
    return [self.name isEqualToString:NSStringFromClass(class)] && [self.superclassDescription isDescriptionForKindOfClass:[class superclass]];
}

- (NSString *)debugDescription
{
    return [NSString stringWithFormat:@"<%@:%p name='%@' superclass='%@'>", NSStringFromClass([self class]), (__bridge void *)self, self.name, self.superclassDescription ? self.superclassDescription.name : @""];
}

@end
