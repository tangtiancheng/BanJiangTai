//
//  UIControl+XPKit.m
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

#import "UIControl+XPKit.h"
#import <objc/runtime.h>

typedef void (^UIControlBlocksActionBlock)(UIControl *sender, UIEvent *event);

static NSString *const UIControlBlocksControlEventsKey = @"UIControlBlocksControlEventsKey";
static NSString *const UIControlBlocksSelectorKey      = @"UIControlBlocksSelectorKey";

static inline const char *uuid() {
	return [[[NSUUID UUID] UUIDString] UTF8String];
}

#pragma mark - Private Helper Categoty
@interface NSObject (Blocks_Private)

@property (atomic, readonly) BOOL Blocks_supportsBlocks;

@end

@implementation NSObject (Blocks_Private)

- (BOOL)Blocks_supportsBlocks {
	return NO;
}

@end

#pragma mark - Action Object

@interface HCSBlockAction : NSObject

@property (nonatomic, readonly) SEL selector;
@property (nonatomic, readonly) UIControlEvents controlEvents;

+ (instancetype)actionWithSelector:(SEL)selector controlEvents:(UIControlEvents)controlEvents;

@end

@implementation HCSBlockAction

+ (instancetype)actionWithSelector:(SEL)selector controlEvents:(UIControlEvents)controlEvents {
	HCSBlockAction *action = [[self alloc] init];

	if (action) {
		action->_controlEvents = controlEvents;
		action->_selector = selector;
	}

	return action;
}

@end

#pragma mark - IMPs

static Class returnSuperClassIMP(id self, SEL _cmd) {
	return class_getSuperclass(object_getClass(self));
}

static BOOL returnYesIMP(id self, SEL _cmd) {
	return YES;
}

static void nop2IMP(id self, SEL _cmd, __unused id _1, __unused id _2) {
}

#pragma mark -

@implementation UIControl (block)

- (NSMutableArray *)actionsArray {
	NSMutableArray *actionsArray = objc_getAssociatedObject(self, _cmd);

	if (!actionsArray) {
		actionsArray = [NSMutableArray array];
		objc_setAssociatedObject(self, _cmd, actionsArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}

	return actionsArray;
}

- (id)addActionForControlEvents:(UIControlEvents)controlEvents
                     usingBlock:(UIControlBlocksActionBlock)block {
	static const char *CommonPart = "UIControlBlocks";

	if (![self Blocks_supportsBlocks]) {
		char *newClassName;
		asprintf(&newClassName,
		         "%s_%s", object_getClassName(self), CommonPart);

		Class newClass = objc_allocateClassPair([self class], newClassName, 0);

		if (newClass) {
			objc_registerClassPair(newClass);
		}
		else {
			newClass = objc_lookUpClass(newClassName);
		}

		free(newClassName);

		if (newClass) {
			object_setClass(self, newClass);

			// Hide the subclassing
			class_addMethod(newClass, @selector(class),                 (IMP)returnSuperClassIMP, "#@:");
			class_addMethod(newClass, @selector(Blocks_supportsBlocks), (IMP)returnYesIMP,        "c@:");
		}
	}

	char *actionString;
	asprintf(&actionString,
	         "%s_action_%s:forEvent:", CommonPart, uuid());

	SEL selector = sel_getUid(actionString);

	free(actionString);

	IMP imp = imp_implementationWithBlock ( ^(id _self, UIControl *sender, UIEvent *event) { block(sender, event); });

	if (class_addMethod(object_getClass(self), selector, imp, "v@:@@")) {
		[self addTarget:self action:selector forControlEvents:controlEvents];

		id actionIdentifier = [HCSBlockAction actionWithSelector:selector
		                                           controlEvents:controlEvents];

		[self.actionsArray addObject:actionIdentifier];

		return actionIdentifier;
	}
	else {
		return nil;
	}
}

- (void)removeAllActions {
	for (id action in[self.actionsArray copy]) {
		[self removeAction:action];
	}
}

- (void)removeAction:(HCSBlockAction *)action {
	NSParameterAssert([action isMemberOfClass:[HCSBlockAction class]]);

	@try {
		[self   removeTarget:self
		              action:action.selector
		    forControlEvents:action.controlEvents];

		Method method = class_getInstanceMethod(object_getClass(self), action.selector);
		IMP currentIMP = method_getImplementation(method);

		imp_removeBlock(currentIMP);
		method_setImplementation(method, (IMP)nop2IMP);

		[self.actionsArray removeObject:action];

		if (self.actionsArray.count == 0) {
			object_setClass(self, [self class]);
		}
	}
	@catch (NSException *exception)
	{
	}
}

- (void)dealloc {
	[self removeAllActions];
}

@end
