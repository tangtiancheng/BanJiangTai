//
//  UINavigationController+XPShouldPop.m
//  XPApp
//
//  Created by huangxinping on 5/5/15.
//  Copyright (c) 2015 iiseeuu.com. All rights reserved.
//

#import "UINavigationController+XPShouldPop.h"
#import <objc/runtime.h>

static NSString *const kXPOriginDelegate = @"kXPOriginDelegate";

@implementation UINavigationController (XPShouldPop)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        {
            SEL originalSelector = @selector(navigationBar:shouldPopItem:);
            SEL swizzledSelector = @selector(xp_navigationBar:shouldPopItem:);
            
            Method originalMethod = class_getInstanceMethod(class, originalSelector);
            Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
            
            BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
            if(didAddMethod) {
                class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
            }
            else
            {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        }
        {
            SEL originalSelector = @selector(viewDidLoad);
            SEL swizzledSelector = @selector(xp_viewDidLoad);
            
            Method originalMethod = class_getInstanceMethod(class, originalSelector);
            Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
            
            BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
            if(didAddMethod) {
                class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
            }
            else
            {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        }
    });
}

- (void)xp_viewDidLoad
{
    [self xp_viewDidLoad];
    
    objc_setAssociatedObject(self, [kXPOriginDelegate UTF8String], self.interactivePopGestureRecognizer.delegate, OBJC_ASSOCIATION_ASSIGN);
    self.interactivePopGestureRecognizer.delegate = (id <UIGestureRecognizerDelegate> )self;
}

- (BOOL)xp_navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    UIViewController *viewController = self.topViewController;
    if(item != viewController.navigationItem) {
        return YES;
    }
    if([viewController conformsToProtocol:@protocol(UINavigationControllerShouldPop)]) {
        if([(id < UINavigationControllerShouldPop >)viewController navigationControllerShouldPop:self]) {
            return [self xp_navigationBar:navigationBar shouldPopItem:item];
        }
        else
        {
            return NO;
        }
    }
    else
    {
        return [self xp_navigationBar:navigationBar shouldPopItem:item];
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if(gestureRecognizer == self.interactivePopGestureRecognizer) {
        UIViewController *viewController = [self topViewController];
        if([viewController conformsToProtocol:@protocol(UINavigationControllerShouldPop)]) {
            if(![(id < UINavigationControllerShouldPop >)viewController navigationControllerShouldPop:self]) {
                return NO;
            }
        }
        
        id <UIGestureRecognizerDelegate> originDelegate = objc_getAssociatedObject(self, [kXPOriginDelegate UTF8String]);
        return [originDelegate gestureRecognizerShouldBegin:gestureRecognizer];
    }
    
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if(gestureRecognizer == self.interactivePopGestureRecognizer) {
        id <UIGestureRecognizerDelegate> originDelegate = objc_getAssociatedObject(self, [kXPOriginDelegate UTF8String]);
        return [originDelegate gestureRecognizerShouldBegin:gestureRecognizer];
    }
    
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if(gestureRecognizer == self.interactivePopGestureRecognizer) {
        id <UIGestureRecognizerDelegate> originDelegate = objc_getAssociatedObject(self, [kXPOriginDelegate UTF8String]);
        return [originDelegate gestureRecognizerShouldBegin:gestureRecognizer];
    }
    
    return YES;
}

@end
