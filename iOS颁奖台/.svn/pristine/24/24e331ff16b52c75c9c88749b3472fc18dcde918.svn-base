//
//  UIPopoverController+XPKit.m
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

#import "UIPopoverController+XPKit.h"

typedef void (^XP_VoidBlock)();

static XP_VoidBlock _shouldDismissBlock;
static XP_VoidBlock _cancelBlock;

@implementation UIPopoverController (XPKit)

+ (void)popOverWithContentViewController:(UIViewController *)controller
                              showInView:(UIView *)view
                         onShouldDismiss:(void (^)())shouldDismiss
                                onCancel:(void (^)())cancelled {
	_shouldDismissBlock = [shouldDismiss copy];
	_cancelBlock = [cancelled copy];

	UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:controller];
	popover.delegate = [self class];

	if ([view isKindOfClass:[UIBarButtonItem class]]) {
		[popover presentPopoverFromBarButtonItem:(UIBarButtonItem *)view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	}
	else if ([view isKindOfClass:[UIView class]]) {
		[popover presentPopoverFromRect:view.frame inView:view.superview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	}
}

+ (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController {
	if (_shouldDismissBlock) {
		_shouldDismissBlock();
	}

	return YES;
}

+ (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
	if (_cancelBlock) {
		_cancelBlock();
	}
}

@end
