//
//  NSObject+XPKit.m
//  XPKit
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014 - 2015 Fabrizio Brancati. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "NSObject+XPKit.h"
#import <objc/runtime.h>


@implementation NSObject (XPKit)

- (id)getAssociatedObjectForKey:(const char *)key
{
    const char *propName = key;
    id currValue = objc_getAssociatedObject(self, propName);
    return currValue;
}

- (id)retainAssociatedObject:(id)obj forKey:(const char *)key;
{
    const char *propName = key;
    id oldValue = objc_getAssociatedObject(self, propName);
    objc_setAssociatedObject(self, propName, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return oldValue;
}

- (void)dispatchWorker:(void (^)())worker withCallback:(void (^)())callback {
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	dispatch_async(queue, ^{
	    worker();
	    dispatch_async(dispatch_get_main_queue(), ^{
	        callback();
		});
	});
}

+ (void)dispatchWorker:(void (^)())worker withCallback:(void (^)())callback {
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	dispatch_async(queue, ^{
	    worker();
	    dispatch_async(dispatch_get_main_queue(), ^{
	        callback();
		});
	});
}

- (void)performBlock:(void (^)())block afterDelay:(NSTimeInterval)delay onMainThread:(BOOL)useMainThread {
	int64_t delta = (int64_t)(1.0e9 * delay);
	if (useMainThread) {
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta), dispatch_get_main_queue(), block);
	}
	else {
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
	}
}

+ (void)performBlock:(void (^)())block afterDelay:(NSTimeInterval)delay onMainThread:(BOOL)useMainThread {
	int64_t delta = (int64_t)(1.0e9 * delay);
	if (useMainThread) {
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta), dispatch_get_main_queue(), block);
	}
	else {
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
	}
}

- (id)performSelector:(SEL)selector withObject:(id)p1 withObject:(id)p2 withObject:(id)p3 {
	NSMethodSignature *sig = [self methodSignatureForSelector:selector];

	if (sig) {
		NSInvocation *invo = [NSInvocation invocationWithMethodSignature:sig];
		[invo setTarget:self];
		[invo setSelector:selector];
		[invo setArgument:&p1 atIndex:2];
		[invo setArgument:&p2 atIndex:3];
		[invo setArgument:&p3 atIndex:4];
		[invo invoke];

		if (sig.methodReturnLength) {
			id anObject;
			[invo getReturnValue:&anObject];
			return anObject;
		}
		else {
			return nil;
		}
	}
	else {
		return nil;
	}
}

- (void)performSelectorOnMainThread:(SEL)selector withObjects:(id)obj1, ...
{
	id argitem; va_list args;
	NSMutableArray *objects = [[NSMutableArray alloc] init];

	if (obj1 != nil) {
		[objects addObject:obj1];
		va_start(args, obj1);

		while ((argitem = va_arg(args, id)))
			[objects addObject:argitem];

		va_end(args);
	}

	[self performSelectorOnMainThread:selector withObjectArray:objects];
}

- (void)performSelectorOnMainThread:(SEL)selector withObjectArray:(NSArray *)objects {
	NSMethodSignature *signature = [self methodSignatureForSelector:selector];

	if (signature) {
		NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
		[invocation setTarget:self];
		[invocation setSelector:selector];

		for (NSUInteger i = 0; i < objects.count; ++i) {
			id obj = [objects objectAtIndex:i];
			[invocation setArgument:&obj atIndex:(NSInteger)(i + 2)];
		}

		[invocation performSelectorOnMainThread:@selector(invoke) withObject:nil waitUntilDone:YES];
	}
}

- (NSString *)className {
	return NSStringFromClass([self class]);
}

//referenced: http://stackoverflow.com/questions/2410081/return-all-properties-of-an-object-in-objective-c
- (NSDictionary *)propertiesDictionaryOfObject:(id)obj withClassType:(Class)cls {
	unsigned int propCount;
	objc_property_t *properties = class_copyPropertyList(cls, &propCount);

	NSMutableDictionary *result = [NSMutableDictionary dictionary];
	NSString *propertyName;
	id propertyValue;

	for (size_t i = 0; i < propCount; i++) {
		@try {
			propertyName = [NSString stringWithUTF8String:property_getName(properties[i])];
			propertyValue = [obj valueForKey:propertyName];
			[result setValue:(propertyValue ? propertyValue : @"nil") forKey:propertyName];
		}
		@catch (NSException *exception)
		{
			/* do nothing */
		}
	}

	free(properties);

	//lookup super classes
	Class superCls = class_getSuperclass(cls);

	while (superCls && ![superCls isEqual:[NSObject class]]) {
		[result addEntriesFromDictionary:[self propertiesDictionaryOfObject:obj withClassType:superCls]];
		superCls = class_getSuperclass(superCls);
	}

	return result;
}

- (NSDictionary *)propertiesDictionary {
	return [self propertiesDictionaryOfObject:self withClassType:[self class]];
}

-(NSDictionary *)iVarsDict{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    NSUInteger outCount;
    
    Ivar* ivars = class_copyIvarList([self class], &outCount);
    for (NSInteger i = 0; i < outCount ; i++){
        Ivar ivar=ivars[i];
        const char* ivarName = ivar_getName(ivar);
        NSString *ivarNameString = [NSString stringWithUTF8String:ivarName];
        NSValue *value = [self valueForKey:ivarNameString];
        
        if (value) {
            [dict setValue:value forKey:ivarNameString];
        }
        
        else {
            [dict setValue:[NSNull null] forKey:ivarNameString];
        }
    }
    
    free(ivars);
    
    return dict;
}

-(NSDictionary *)methodsDict{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    NSUInteger outCount;
    
    Method* methods = class_copyMethodList([self class], &outCount);
    
    for (NSInteger i=0; i<outCount; i++) {
        Method method = methods[i];
        SEL selector = method_getName(method);
        NSString *methodNameString = NSStringFromSelector(selector);
        
        if ([methodNameString isEqualToString:@".cxx_destruct"]) {
            continue; //all NSObjects have this method, clutters the dictionary
        }
        
        if (selector) {
            [dict setValue:methodNameString forKey:methodNameString]; //set string as value instead of selector, to retrieve use NSSelectorFromString()
        }
    }
    
    free(methods);
    
    return dict;
}

-(NSDictionary *)objectIntrospectDictionary{
    
    NSDictionary *dict=@{@"properties" : [self propertiesDictionary],
                         @"iVars" : [self iVarsDict],
                         @"methods" : [self methodsDict]
                         };
    
    return dict;
}

- (instancetype)tap:(void (^)(id))block
{
    NSParameterAssert(block != nil);
    block(self);
    return self;
}

// It is inspired by the `tapp` RubyGem at http://rubygems.org/gems/tapp.
- (instancetype)tapp
{
    NSLog(@"tapp:%@", self);
    return self;
}

- (void)autoEncodeWithCoder:(NSCoder *)coder {
    NSDictionary *properties = [self propertiesDictionary];
    for (NSString *key in properties) {
        NSString *type = [properties objectForKey:key];
        id value;
        unsigned long long ullValue;
        BOOL boolValue;
        float floatValue;
        double doubleValue;
        NSInteger intValue;
        unsigned long ulValue;
        long longValue;
        unsigned unsignedValue;
        short shortValue;
        NSString *className;
        
        NSMethodSignature *signature = [self methodSignatureForSelector:NSSelectorFromString(key)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setSelector:NSSelectorFromString(key)];
        [invocation setTarget:self];
        
        switch ([type characterAtIndex:0]) {
            case '@':   // object
                if ([[type componentsSeparatedByString:@"\""] count] > 1) {
                    className = [[type componentsSeparatedByString:@"\""] objectAtIndex:1];
                    Class class = NSClassFromString(className);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                    value = [self performSelector:NSSelectorFromString(key)];
#pragma clang diagnostic pop
                    
                    // only decode if the property conforms to NSCoding
                    if([class conformsToProtocol:@protocol(NSCoding)]){
                        [coder encodeObject:value forKey:key];
                    }
                }
                break;
            case 'c':   // bool
                [invocation invoke];
                [invocation getReturnValue:&boolValue];
                [coder encodeObject:[NSNumber numberWithBool:boolValue] forKey:key];
                break;
            case 'f':   // float
                [invocation invoke];
                [invocation getReturnValue:&floatValue];
                [coder encodeObject:[NSNumber numberWithFloat:floatValue] forKey:key];
                break;
            case 'd':   // double
                [invocation invoke];
                [invocation getReturnValue:&doubleValue];
                [coder encodeObject:[NSNumber numberWithDouble:doubleValue] forKey:key];
                break;
            case 'i':   // int
                [invocation invoke];
                [invocation getReturnValue:&intValue];
                [coder encodeObject:[NSNumber numberWithInteger:intValue] forKey:key];
                break;
            case 'L':   // unsigned long
                [invocation invoke];
                [invocation getReturnValue:&ulValue];
                [coder encodeObject:[NSNumber numberWithUnsignedLong:ulValue] forKey:key];
                break;
            case 'Q':   // unsigned long long
                [invocation invoke];
                [invocation getReturnValue:&ullValue];
                [coder encodeObject:[NSNumber numberWithUnsignedLongLong:ullValue] forKey:key];
                break;
            case 'l':   // long
                [invocation invoke];
                [invocation getReturnValue:&longValue];
                [coder encodeObject:[NSNumber numberWithLong:longValue] forKey:key];
                break;
            case 's':   // short
                [invocation invoke];
                [invocation getReturnValue:&shortValue];
                [coder encodeObject:[NSNumber numberWithShort:shortValue] forKey:key];
                break;
            case 'I':   // unsigned
                [invocation invoke];
                [invocation getReturnValue:&unsignedValue];
                [coder encodeObject:[NSNumber numberWithUnsignedInt:unsignedValue] forKey:key];
                break;
            default:
                break;
        }
    }
}

- (void)autoDecode:(NSCoder *)coder {
    NSDictionary *properties = [self propertiesDictionary];
    for (NSString *key in properties) {
        NSString *type = [properties objectForKey:key];
        id value;
        NSNumber *number;
        NSInteger i;
        CGFloat f;
        BOOL b;
        double d;
        unsigned long ul;
        unsigned long long ull;
        long longValue;
        unsigned unsignedValue;
        short shortValue;
        
        NSString *className;
        
        switch ([type characterAtIndex:0]) {
            case '@':   // object
                if ([[type componentsSeparatedByString:@"\""] count] > 1) {
                    className = [[type componentsSeparatedByString:@"\""] objectAtIndex:1];
                    Class class = NSClassFromString(className);
                    // only decode if the property conforms to NSCoding
                    if ([class conformsToProtocol:@protocol(NSCoding )]){
                        value = [coder decodeObjectForKey:key];
                        [self setValue:value forKey:key];
                    }
                }
                break;
            case 'c':   // bool
                number = [coder decodeObjectForKey:key];
                b = [number boolValue];
                [self setValue:@(b) forKey:key];
                break;
            case 'f':   // float
                number = [coder decodeObjectForKey:key];
                f = [number floatValue];
                [self setValue:@(f) forKey:key];
                break;
            case 'd':   // double
                number = [coder decodeObjectForKey:key];
                d = [number doubleValue];
                [self setValue:@(d) forKey:key];
                break;
            case 'i':   // int
                number = [coder decodeObjectForKey:key];
                i = [number intValue];
                [self setValue:@(i) forKey:key];
                break;
            case 'L':   // unsigned long
                number = [coder decodeObjectForKey:key];
                ul = [number unsignedLongValue];
                [self setValue:@(ul) forKey:key];
                break;
            case 'Q':   // unsigned long long
                number = [coder decodeObjectForKey:key];
                ull = [number unsignedLongLongValue];
                [self setValue:@(ull) forKey:key];
                break;
            case 'l':   // long
                number = [coder decodeObjectForKey:key];
                longValue = [number longValue];
                [self setValue:@(longValue) forKey:key];
                break;
            case 'I':   // unsigned
                number = [coder decodeObjectForKey:key];
                unsignedValue = [number unsignedIntValue];
                [self setValue:@(unsignedValue) forKey:key];
                break;
            case 's':   // short
                number = [coder decodeObjectForKey:key];
                shortValue = [number shortValue];
                [self setValue:@(shortValue) forKey:key];
                break;
            default:
                break;
        }
    }
}

@end

@implementation NSObject (XPDescription)

- (NSString *)autoDescription
{
    return [NSString stringWithFormat:@"<%@: %p; %@>", NSStringFromClass([self class]), self, [self keyValueAutoDescription]];
}

- (NSString *)keyValueAutoDescription
{
    NSMutableString *result = [NSMutableString string];
    
    dispatch_queue_t currentQueue = dispatch_get_current_queue();
    
    id associatedObject = objc_getAssociatedObject(self, (__bridge const void *)(currentQueue));
    if (associatedObject) {
        return @"(self)";
    }
    
    objc_setAssociatedObject(self, (__bridge const void *)(currentQueue), result, OBJC_ASSOCIATION_RETAIN);
    
    Class currentClass = [self class];
    while (currentClass != [NSObject class]) {
        unsigned int propertyListCount = 0;
        objc_property_t *propertyList = class_copyPropertyList(currentClass, &propertyListCount);
        for (int i = 0; i < propertyListCount; i++) {
            const char *property_name = property_getName(propertyList[i]);
            NSString *propertyName = [NSString stringWithCString:property_name encoding:NSASCIIStringEncoding];
            
            if (propertyName) {
                id propertyValue = [self valueForKey:propertyName];
                [result appendFormat:@"%@ = %@; ", propertyName, [propertyValue cleanDescription]];
            }
        }
        free(propertyList);
        currentClass = class_getSuperclass(currentClass);
    }
    NSUInteger length = [result length];
    if (length) {
        [result deleteCharactersInRange:NSMakeRange(length - 1, 1)];
    }
    
    objc_setAssociatedObject(self, (__bridge const void *)(currentQueue), nil, OBJC_ASSOCIATION_RETAIN);
    
    return result;
}

- (NSString *)cleanDescription
{
    NSString *result;
    result = [self description];
    return result;
}

@end

@implementation NSString (XPDescription)

- (NSString *)cleanDescription
{
    NSString *result;
    
    if ([self rangeOfCharacterFromSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]].location == NSNotFound) {
        result = self;
    } else {
        result = [NSString stringWithFormat:@"\"%@\"", self];
    }
    
    return result;
}

@end


@implementation NSArray (XPDescription)

- (NSString *)cleanDescription
{
    NSString *result;
    
    NSMutableString *elements = [NSMutableString string];
    for (id value in self) {
        [elements appendFormat:@"%@, ", [value cleanDescription]];
    }
    NSUInteger length = [elements length];
    if (length > 2) {
        [elements deleteCharactersInRange:NSMakeRange(length - 2, 2)];
    }
    
    result = [NSString stringWithFormat:@"(%@)", elements];
    
    return result;
}

@end


@implementation NSSet (XPDescription)

- (NSString *)cleanDescription
{
    NSString *result;
    
    result = [NSString stringWithFormat:@"{%@}", [[self allObjects] cleanDescription]];
    
    return result;
}

@end


@implementation NSDictionary (XPDescription)

- (NSString *)cleanDescription
{
    NSString *result;
    
    NSMutableString *elements = [NSMutableString string];
    for (id key in self) {
        id value = [self objectForKey:key];
        [elements appendFormat:@"%@ = %@; ", [key cleanDescription], [value cleanDescription]];
    }
    NSUInteger length = [elements length];
    if (length) {
        [elements deleteCharactersInRange:NSMakeRange(length - 1, 1)];
    }
    
    result = [NSString stringWithFormat:@"{%@}", elements];
    
    return result;
}

@end