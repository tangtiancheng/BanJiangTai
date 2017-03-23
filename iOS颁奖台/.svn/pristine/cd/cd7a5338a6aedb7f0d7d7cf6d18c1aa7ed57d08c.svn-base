//
//  XPBaseObject.m
//  Huaban
//
//  Created by huangxinping on 4/21/15.
//  Copyright (c) 2015 iiseeuu.com. All rights reserved.
//

#import "XPBaseModel.h"
#import <XPKit/NSObject+XPKit.h>

@implementation XPBaseModel

- (NSString *)description
{
    return [self autoDescription];
}

- (NSString *)debugDescription
{
    return [self autoDescription];
}

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"access_token": @"accessToken"
                                                       }];
    //    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

//+ (void)initialize
//{
//    [JSONModel setGlobalKeyMapper:[
//                                   [JSONKeyMapper alloc] initWithDictionary:@{
//                                                                              @"description":@"descriptionInfo"
//                                                                              }]
//     ];
//}

- (instancetype)init
{
    if((self = [super init])) {
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [self autoEncodeWithCoder:coder];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init]) {
        [self autoDecode:aDecoder];
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    XPBaseModel *temp = [[[self class] allocWithZone:zone] init];
    return temp;
}

- (BOOL)isEqual:(XPBaseModel *)object
{
    if(self == object) {
        return YES;
    }
    if(![object isKindOfClass:XPBaseModel.class]) {
        return NO;
    }
    
    BOOL selfEqual = self.identifier == object.identifier && self.baseTransfer == object.baseTransfer;
    return [super isEqual:object] && selfEqual;
}

@end

static NSMutableDictionary *_singletons;
@implementation XPBaseModel (Singleton)

+ (instancetype)singleton
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singletons = [NSMutableDictionary dictionary];
    });
    
    id instance = nil;
    @synchronized(self){
        NSString *klass = NSStringFromClass(self);
        instance = _singletons[klass];
        if(!instance) {
            instance = [[self alloc] init];
            _singletons[klass] = instance;
        }
    }
    return instance;
}

@end
