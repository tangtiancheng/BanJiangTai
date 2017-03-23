//
//  JSONModel+RACExtensions.m
//
//  Created by Dal Rupnik on 1/21/15
//  Copyright (c) 2015 arvystate.net. All rights reserved.
//

#import "JSONModel+RACExtensions.h"

@implementation JSONModel (RACExtensions)

+ (RACSignal *)parseSignalForObject:(id)object
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber)
    {
        NSError* error;
        
        id result = [self objectByTraversingObject:object withError:&error];
        
        if (result)
        {
            [subscriber sendNext:result];
            [subscriber sendCompleted];
        }
        else if (error)
        {
            [subscriber sendError:error];
        }
        
        return nil;
    }];
}

+ (RACSignal *)parseSignalForModelObject:(id)object
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber)
    {
        NSError* error;
        
        id result = [self objectForModelObject:object withError:&error];
        
        if (result)
        {
            [subscriber sendNext:result];
            [subscriber sendCompleted];
        }
        else if (error)
        {
            [subscriber sendError:error];
        }
        
        return nil;

    }];
}

+ (RACSignal *)parseSignalForDictionary:(NSDictionary *)dictionary
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber)
    {
        NSError* error;
        
        id result = [[self alloc] initWithDictionary:dictionary error:&error];
        
        if (result)
        {
            [subscriber sendNext:result];
            [subscriber sendCompleted];
        }
        else if (error)
        {
            [subscriber sendError:error];
        }
        
        return nil;
    }];
}

+ (RACSignal *)parseSignalForArray:(NSArray *)array
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber)
    {
        NSError* error;
        
        id result = [self arrayOfModelsFromDictionaries:array error:&error];
        
        if (result)
        {
            [subscriber sendNext:result];
            [subscriber sendCompleted];
        }
        else if (error)
        {
            [subscriber sendError:error];
        }
        
        return nil;
    }];
}

/*!
 *  Function returns array of objects if array is provided or model object if a
 *  single dictionary is provided.
 *
 *  @param object to be parsed
 *  @param error  error pointer
 *
 *  @return array of objects, object or nil
 */
+ (id)objectForModelObject:(id)object withError:(NSError * __autoreleasing *)error
{
    if ([object isKindOfClass:[NSDictionary class]])
    {
        id currentObject = [[self alloc] initWithDictionary:object error:error];
        
        return currentObject;
    }
    else if ([object isKindOfClass:[NSArray class]])
    {
        return [self arrayOfModelsFromDictionaries:object error:error];
    }
    
    return nil;
}

/*!
 *  Same as object for data object, except that in case of a dictionary, it traverses
 *  first level of objects to attempt to create objects. Should be used in cases where
 *  first parameter is not the object itself.
 *
 *  @param object dictionary or array
 *  @param error  return
 *
 *  @return objects
 */
+ (id)objectByTraversingObject:(id)object withError:(NSError * __autoreleasing *)error
{
    id createdObject = [self objectForModelObject:object withError:error];
    
    if (createdObject)
    {
        return createdObject;
    }
    else if (!createdObject && [object conformsToProtocol:@protocol(NSFastEnumeration)])
    {
        for (id key in object)
        {
            id internalObject = nil;
            
            if ([object respondsToSelector:@selector(objectForKeyedSubscript:)])
            {
                internalObject = [self objectForModelObject:object[key] withError:error];
            }
            else
            {
                internalObject = [self objectByTraversingObject:key withError:error];
            }
            
            if (internalObject)
            {
                return internalObject;
            }
        }
    }
    
    return nil;
}

@end
