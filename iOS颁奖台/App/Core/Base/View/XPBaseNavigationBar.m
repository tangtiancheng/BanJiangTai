//
//  XPBaseNavigationBar.m
//  Huaban
//
//  Created by huangxinping on 4/21/15.
//  Copyright (c) 2015 iiseeuu.com. All rights reserved.
//

#import "XPBaseNavigationBar.h"
#import <objc/runtime.h>

@interface XPBaseNavigationBar ()

@property (nonatomic, strong) CALayer *colorLayer;

@end

@implementation XPBaseNavigationBar

#define XP_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare : v options : NSNumericSearch] != NSOrderedAscending)

static CGFloat const XP_kDefaultColorLayerOpacity = 0.5f;
static CGFloat const XP_kSpaceToCoverStatusBars = 20.0f;

- (void)setBarTintColor:(UIColor *)barTintColor
{
    [super setBarTintColor:barTintColor];
    // iOS 7.1 seems to completely ignore the alpha channel and any modifications to it.
    // Hence, adding an extra layer is moot.
    // Still looking into possible solutions for this, but for now, this method is empty.
    if(XP_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.1")) {
    }
    // As of iOS 7.0.3, colors definitely seem a little bit more saturated.
    else if(XP_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0.3")) {
        // Override the opacity if wanted.
        if(self.overrideOpacity) {
            CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
            [barTintColor getRed:&red green:&green blue:&blue alpha:&alpha];
            [super setBarTintColor:[UIColor colorWithRed:red green:green blue:blue alpha:XP_kDefaultNavigationBarAlpha]];
        }
        
        // This code isn't perfect and has been commented out for now. It seems like
        // the additional color layer doesn't work well now that translucency is based
        // primarily on the opacity of the navigation bar (and its respective layers).
        // However, if you'd like to experiment, feel free to uncomment this out and
        // give it a spin.
        
        // if (self.colorLayer == nil) {
        //    self.colorLayer = [CALayer layer];
        //    self.colorLayer.opacity = kDefaultColorLayerOpacity - 0.2f;
        //    [self.layer addSublayer:self.colorLayer];
        // }
        
        // self.colorLayer.backgroundColor = barTintColor.CGColor;
    }
    // iOS 7.0 benefits from the extra color layer.
    else {
        // Create a CALayer with some opacity, and add the layer.
        if(self.colorLayer == nil) {
            self.colorLayer = [CALayer layer];
            self.colorLayer.opacity = XP_kDefaultColorLayerOpacity;
            [self.layer addSublayer:self.colorLayer];
        }
        
        self.colorLayer.backgroundColor = barTintColor.CGColor;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if(self.colorLayer != nil) {
        self.colorLayer.frame = CGRectMake(0, 0 - XP_kSpaceToCoverStatusBars, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + XP_kSpaceToCoverStatusBars);
        
        [self.layer insertSublayer:self.colorLayer atIndex:1];
    }
}

@end

@implementation UINavigationBar (XPAwesome)
static char overlayKey;

- (UIView *)overlay
{
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)xp_setBackgroundColor:(UIColor *)backgroundColor
{
    if(!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.bounds) + 20)];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.overlay atIndex:0];
    }
    
    self.overlay.backgroundColor = backgroundColor;
}

- (void)xp_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)xp_setElementsAlpha:(CGFloat)alpha
{
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    //    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
}

- (void)xp_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlay removeFromSuperview];
    self.overlay = nil;
}

@end
