//
//  NSObject+XPKit.h
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

/**
 *  This class add some useful methods to NSObject
 */

/* Runtime shorthand
 
 @interface UINavigationBar (XP)
 xp_property_as_associated_strong(id, test2);
 @end
 
 @implementation UINavigationBar (XP)
 xp_property_def_associated_strong(id, test2)
 @end
 
 */
#define xp_property_as_associated_strong(__type, __name) \
@property (nonatomic, strong, setter = set__ ## __name:, getter = __ ## __name) __type __name;
#define xp_property_def_associated_strong(__type, __name) \
- (__type)__ ## __name   \
{ return [self getAssociatedObjectForKey:#__name]; }   \
- (void)set__ ## __name: (id)__ ## __name   \
{ [self retainAssociatedObject:__ ## __name forKey:#__name]; }

@interface NSObject (XPKit)

- (id)getAssociatedObjectForKey:(const char *)key;
- (id)retainAssociatedObject:(id)obj forKey:(const char *)key;

/**
 *  Dispatch GCD
 *
 *  @param worker   worker
 *  @param callback callback
 */
- (void)dispatchWorker:(void (^)())worker withCallback:(void (^)())callback;

/**
 *  Dispatch GCD
 *
 *  @param worker   worker
 *  @param callback callback

 */
+ (void)dispatchWorker:(void (^)())worker withCallback:(void (^)())callback;

/**
 *  Perfrom GCD
 *
 *  @param block         block
 *  @param delay         delay
 *  @param useMainThread useMainThread
 */
- (void)performBlock:(void (^)())block afterDelay:(NSTimeInterval)delay onMainThread:(BOOL)useMainThread;

/**
 *  Perfrom GCD
 *
 *  @param block         block
 *  @param delay         delay
 *  @param useMainThread useMainThread
 */
+ (void)performBlock:(void (^)())block afterDelay:(NSTimeInterval)delay onMainThread:(BOOL)useMainThread;

/**
 *  Perfrom selector
 *
 *  @param selector slector
 *  @param object1  object1 description
 *  @param object2  object2 description
 *  @param object3  object3 description
 *
 *  @return Return NSObject instance
 */
- (instancetype)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3;

/**
 *  Perfrom selector
 *
 *  @param selector slector
 *  @param object1  object1 description
 */
- (void)performSelectorOnMainThread:(SEL)selector withObjects:(id)object1, ...;

/**
 *  Perfrom selector
 *
 *  @param selector slector
 *  @param objects  param array
 */
- (void)performSelectorOnMainThread:(SEL)selector withObjectArray:(NSArray *)objects;

/**
 *  Get class name
 *
 *  @return Return class name
 */
- (NSString *)className;

/**
 *  Get properties dictionary
 *
 *  @return Return properties dictionary
 */
- (NSDictionary *)propertiesDictionary;

- (NSDictionary *)iVarsDict;
- (NSDictionary *)methodsDict;
- (NSDictionary *)objectIntrospectDictionary;

- (instancetype)tap:(void (^)(id x))block;

/**
 *  Calls `NSLog(@"%@", self);`, then returns the receiver.
 */
- (instancetype)tapp;

- (void)autoEncodeWithCoder:(NSCoder *)coder;
- (void)autoDecode:(NSCoder *)coder;

@end


@interface NSObject (XPDescription)

- (NSString *)autoDescription;
- (NSString *)cleanDescription;

@end

@interface NSString (XPDescription)

- (NSString *)cleanDescription;

@end


@interface NSArray (XPDescription)

- (NSString *)cleanDescription;

@end


@interface NSSet (XPDescription)

- (NSString *)cleanDescription;

@end


@interface NSDictionary (XPDescription)

- (NSString *)cleanDescription;

@end
