//
//  ZGSwizzler.h
//  HelloZhuge
//
//  Created by Alex Hofsteede on 1/5/14.
//  Copyright (c) 2014 Zhuge. All rights reserved.
//

#import <Foundation/Foundation.h>

// Cast to turn things that are not ids into NSMapTable keys
#define MAPTABLE_ID(x) (__bridge id)((void *)x)

typedef void (^swizzleBlock)();

@interface ZGSwizzler : NSObject

+ (void)swizzleSelector:(SEL)aSelector onClass:(Class)aClass withBlock:(swizzleBlock)block named:(NSString *)aName;
+ (void)unswizzleSelector:(SEL)aSelector onClass:(Class)aClass named:(NSString *)aName;
+ (void)printSwizzles;

@end
