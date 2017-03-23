//
//  XPBaseNavigationBar.h
//  Huaban
//
//  Created by huangxinping on 4/21/15.
//  Copyright (c) 2015 iiseeuu.com. All rights reserved.
//没用到

#import <UIKit/UIKit.h>

static CGFloat const XP_kDefaultNavigationBarAlpha = 0.70f;

@interface XPBaseNavigationBar : UINavigationBar

/**
 * If set to YES, this will override the opacity of the barTintColor and will set it to
 * the value contained in kDefaultNavigationBarAlpha.
 */
@property (nonatomic, assign) BOOL overrideOpacity;

@end

@interface UINavigationBar (XPAwesome)

- (void)xp_setBackgroundColor:(UIColor *)backgroundColor;
- (void)xp_setElementsAlpha:(CGFloat)alpha;
- (void)xp_setTranslationY:(CGFloat)translationY;
- (void)xp_reset;

@end
