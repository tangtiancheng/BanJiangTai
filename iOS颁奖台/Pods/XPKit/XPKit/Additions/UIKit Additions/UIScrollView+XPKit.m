//
//  UIScrollView+XPKit.m
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

#import "UIScrollView+XPKit.h"

@implementation UIScrollView (XPKit)

+ (UIScrollView *)initWithFrame:(CGRect)frame contentSize:(CGSize)contentSize clipsToBounds:(BOOL)clipsToBounds pagingEnabled:(BOOL)pagingEnabled showScrollIndicators:(BOOL)showScrollIndicators delegate:(id <UIScrollViewDelegate> )delegate {
	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
	[scrollView setDelegate:delegate];
	[scrollView setPagingEnabled:pagingEnabled];
	[scrollView setClipsToBounds:clipsToBounds];
	[scrollView setShowsVerticalScrollIndicator:showScrollIndicators];
	[scrollView setShowsHorizontalScrollIndicator:showScrollIndicators];
	[scrollView setContentSize:contentSize];

	return scrollView;
}

- (void)scrollToTop {
	self.contentOffset = CGPointMake(0, 0);
}

- (void)scrollToTopAnimated:(BOOL)animated {
	[self setContentOffset:CGPointMake(0.0f, 0.0f) animated:animated];
}

- (void)scrollViewToVisible:(UIView *)view animated:(BOOL)animated {
	BOOL needsUpdate = NO;
	CGRect frame = [self.window convertRect:self.frame fromView:self.superview];

	CGRect viewFrame = [self.window convertRect:view.frame fromView:view.superview];
	CGFloat viewMaxX = viewFrame.origin.x + viewFrame.size.width;
	CGFloat viewMaxY = viewFrame.origin.y + viewFrame.size.height;
	CGFloat scrollViewMaxX = frame.origin.x + frame.size.width;
	CGFloat scrollViewMaxY = frame.origin.y + frame.size.height;

	CGPoint offsetPoint = self.contentOffset;

	if (viewMaxX > scrollViewMaxX) {
		// The view is to the right of the view port, so scroll it just into view
		offsetPoint.x = frame.origin.x + viewFrame.size.width;
		needsUpdate = YES;
	}
	else if (viewMaxX < 0.0) {
		offsetPoint.x = viewFrame.origin.x;
		needsUpdate = YES;
	}

	if (viewMaxY > scrollViewMaxY) {
		// The view is below the view port, so scroll it just into view
		offsetPoint.y = frame.origin.y + viewFrame.size.height;
		needsUpdate = YES;
	}
	else if (viewMaxY < 0.0) {
		offsetPoint.y = viewFrame.origin.y;
		needsUpdate = YES;
	}

	if (needsUpdate) {
		offsetPoint = [self.window convertPoint:offsetPoint toView:self.superview];
		[self setContentOffset:offsetPoint animated:animated];
		CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0.2, false);
	}
}

@end
