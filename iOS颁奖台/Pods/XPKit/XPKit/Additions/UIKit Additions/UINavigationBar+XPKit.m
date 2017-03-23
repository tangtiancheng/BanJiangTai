//
//  UINavigationBar+XPKit.m
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

#import "UINavigationBar+XPKit.h"

@implementation UINavigationBar (XPKit)

/**
 * Hide 1px hairline of the nav bar
 */
- (void)hideBottomHairline {
	UIImageView *navBarHairlineImageView = [self findHairlineImageViewUnder:self];

	navBarHairlineImageView.hidden = YES;
}

/**
 * Show 1px hairline of the nav bar
 */
- (void)showBottomHairline {
	// Show 1px hairline of translucent nav bar
	UIImageView *navBarHairlineImageView = [self findHairlineImageViewUnder:self];

	navBarHairlineImageView.hidden = NO;
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
	if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
		return (UIImageView *)view;
	}

	for (UIView *subview in view.subviews) {
		UIImageView *imageView = [self findHairlineImageViewUnder:subview];

		if (imageView) {
			return imageView;
		}
	}

	return nil;
}

- (void)setBarColor:(UIColor *)color {
	self.barTintColor = color;
}

- (void)setArrowColor:(UIColor *)color {
	self.tintColor = color;
}

@end
