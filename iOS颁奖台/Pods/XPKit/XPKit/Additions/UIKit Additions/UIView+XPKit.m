//
//  UIView+XPKit.m
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

#import "UIView+XPKit.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>
#import "UIDevice+XPKit.h"

typedef void (^XP_WhenTappedBlock)();

@interface UIView (private)

- (void)runBlockForKey:(void *)blockKey;
- (void)setBlock:(XP_WhenTappedBlock)block forKey:(void *)blockKey;

- (UITapGestureRecognizer *)addTapGestureRecognizerWithTaps:(NSUInteger)taps touches:(NSUInteger)touches selector:(SEL)selector;
- (void)addRequirementToSingleTapsRecognizer:(UIGestureRecognizer *)recognizer;
- (void)addRequiredToDoubleTapsRecognizer:(UIGestureRecognizer *)recognizer;

@end

@implementation UIView (XPKit)
static char kWhenTappedBlockKey;
static char kWhenDoubleTappedBlockKey;
static char kWhenTwoFingerTappedBlockKey;
static char kWhenTouchedDownBlockKey;
static char kWhenTouchedUpBlockKey;

- (void)runBlockForKey:(void *)blockKey {
	XP_WhenTappedBlock block = objc_getAssociatedObject(self, blockKey);

	if (block) block();
}

- (void)setBlock:(XP_WhenTappedBlock)block forKey:(void *)blockKey {
	self.userInteractionEnabled = YES;
	objc_setAssociatedObject(self, blockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)whenTapped:(XP_WhenTappedBlock)block {
	UITapGestureRecognizer *gesture = [self addTapGestureRecognizerWithTaps:1 touches:1 selector:@selector(viewWasTapped)];

	[self addRequiredToDoubleTapsRecognizer:gesture];
	[self setBlock:block forKey:&kWhenTappedBlockKey];
}

- (void)whenDoubleTapped:(XP_WhenTappedBlock)block {
	UITapGestureRecognizer *gesture = [self addTapGestureRecognizerWithTaps:2 touches:1 selector:@selector(viewWasDoubleTapped)];

	[self addRequirementToSingleTapsRecognizer:gesture];
	[self setBlock:block forKey:&kWhenDoubleTappedBlockKey];
}

- (void)whenTwoFingerTapped:(XP_WhenTappedBlock)block {
	[self addTapGestureRecognizerWithTaps:1 touches:2 selector:@selector(viewWasTwoFingerTapped)];
	[self setBlock:block forKey:&kWhenTwoFingerTappedBlockKey];
}

- (void)whenTouchedDown:(XP_WhenTappedBlock)block {
	[self setBlock:block forKey:&kWhenTouchedDownBlockKey];
}

- (void)whenTouchedUp:(XP_WhenTappedBlock)block {
	[self setBlock:block forKey:&kWhenTouchedUpBlockKey];
}

- (void)viewWasTapped {
	[self runBlockForKey:&kWhenTappedBlockKey];
}

- (void)viewWasDoubleTapped {
	[self runBlockForKey:&kWhenDoubleTappedBlockKey];
}

- (void)viewWasTwoFingerTapped {
	[self runBlockForKey:&kWhenTwoFingerTappedBlockKey];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesBegan:touches withEvent:event];
	[self runBlockForKey:&kWhenTouchedDownBlockKey];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesEnded:touches withEvent:event];
	[self runBlockForKey:&kWhenTouchedUpBlockKey];
}

- (UITapGestureRecognizer *)addTapGestureRecognizerWithTaps:(NSUInteger)taps touches:(NSUInteger)touches selector:(SEL)selector {
	UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];

	tapGesture.delegate = self;
	tapGesture.numberOfTapsRequired = taps;
	tapGesture.numberOfTouchesRequired = touches;
	[self addGestureRecognizer:tapGesture];
	return tapGesture;
}

- (void)addRequirementToSingleTapsRecognizer:(UIGestureRecognizer *)recognizer {
	for (UIGestureRecognizer *gesture in[self gestureRecognizers]) {
		if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
			UITapGestureRecognizer *tapGesture = (UITapGestureRecognizer *)gesture;

			if (tapGesture.numberOfTouchesRequired == 1 && tapGesture.numberOfTapsRequired == 1) {
				[tapGesture requireGestureRecognizerToFail:recognizer];
			}
		}
	}
}

- (void)addRequiredToDoubleTapsRecognizer:(UIGestureRecognizer *)recognizer {
	for (UIGestureRecognizer *gesture in[self gestureRecognizers]) {
		if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
			UITapGestureRecognizer *tapGesture = (UITapGestureRecognizer *)gesture;

			if (tapGesture.numberOfTouchesRequired == 2 && tapGesture.numberOfTapsRequired == 1) {
				[recognizer requireGestureRecognizerToFail:tapGesture];
			}
		}
	}
}

+ (UIView *)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor {
	UIView *view = [[UIView alloc] initWithFrame:frame];
	[view setBackgroundColor:backgroundColor];

	return view;
}

+ (UIView*)viewFromNib
{
    __weak id wSelf = self;
    
    // There is a swift bug, compiler will add a package name in front of the class name
    NSString *className = NSStringFromClass(self);
    NSArray *components = [className componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
    className = [components lastObject];
    
    return [[[[UINib nibWithNibName:className bundle:[NSBundle bundleForClass:self]] instantiateWithOwner:nil options:nil] filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^(id evaluatedObject, NSDictionary *bindings) {
        return [evaluatedObject isKindOfClass:wSelf];
    }]] lastObject];
}

// Borders
- (void)createBordersWithColor:(UIColor *)color withCornerRadius:(CGFloat)radius andWidth:(CGFloat)width {
	self.layer.borderWidth = width;
	self.layer.cornerRadius = radius;
	self.layer.shouldRasterize = NO;
	self.layer.rasterizationScale = 2;
	self.layer.edgeAntialiasingMask = kCALayerLeftEdge | kCALayerRightEdge | kCALayerBottomEdge | kCALayerTopEdge;
	self.clipsToBounds = YES;
	self.layer.masksToBounds = YES;

	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	CGColorRef cgColor = [color CGColor];
	self.layer.borderColor = cgColor;
	CGColorSpaceRelease(space);
}

- (void)removeBorders {
	self.layer.borderWidth = 0;
	self.layer.cornerRadius = 0;
	self.layer.borderColor = nil;
}

- (void)removeShadow {
	[self.layer setShadowColor:[[UIColor clearColor] CGColor]];
	[self.layer setShadowOpacity:0.0f];
	[self.layer setShadowOffset:CGSizeMake(0.0f, 0.0f)];
}

- (void)setCornerRadius:(CGFloat)radius {
	self.layer.cornerRadius = radius;
	[self.layer setMasksToBounds:YES];
}

// Shadows
- (void)createRectShadowWithOffset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius {
	self.layer.shadowColor = [UIColor blackColor].CGColor;
	self.layer.shadowOpacity = opacity;
	self.layer.shadowOffset = offset;
	self.layer.shadowRadius = radius;
	self.layer.masksToBounds = NO;
}

- (void)createCornerRadiusShadowWithCornerRadius:(CGFloat)cornerRadius offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius {
	self.layer.shadowColor = [UIColor blackColor].CGColor;
	self.layer.shadowOpacity = opacity;
	self.layer.shadowOffset = offset;
	self.layer.shadowRadius = radius;
	self.layer.shouldRasterize = YES;
	self.layer.cornerRadius = cornerRadius;
	self.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:[self bounds] cornerRadius:cornerRadius] CGPath];
	self.layer.masksToBounds = NO;
}

// Animations
- (void)shakeView {
	CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
	shake.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-5.0f, 0.0f, 0.0f)], [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(5.0f, 0.0f, 0.0f)]];
	shake.autoreverses = YES;
	shake.repeatCount = 2.0f;
	shake.duration = 0.07f;

	[self.layer addAnimation:shake forKey:nil];
}

- (void)pulseViewWithTime:(CGFloat)seconds {
	[UIView animateWithDuration:seconds / 6 animations: ^{
	    [self setTransform:CGAffineTransformMakeScale(1.1, 1.1)];
	} completion: ^(BOOL finished) {
	    if (finished) {
	        [UIView animateWithDuration:seconds / 6 animations: ^{
	            [self setTransform:CGAffineTransformMakeScale(0.96, 0.96)];
			} completion: ^(BOOL finished) {
	            if (finished) {
	                [UIView animateWithDuration:seconds / 6 animations: ^{
	                    [self setTransform:CGAffineTransformMakeScale(1.03, 1.03)];
					} completion: ^(BOOL finished) {
	                    if (finished) {
	                        [UIView animateWithDuration:seconds / 6 animations: ^{
	                            [self setTransform:CGAffineTransformMakeScale(0.985, 0.985)];
							} completion: ^(BOOL finished) {
	                            if (finished) {
	                                [UIView animateWithDuration:seconds / 6 animations: ^{
	                                    [self setTransform:CGAffineTransformMakeScale(1.007, 1.007)];
									} completion: ^(BOOL finished) {
	                                    if (finished) {
	                                        [UIView animateWithDuration:seconds / 6 animations: ^{
	                                            [self setTransform:CGAffineTransformMakeScale(1, 1)];
											} completion: ^(BOOL finished) {
	                                            if (finished) {
												}
											}];
										}
									}];
								}
							}];
						}
					}];
				}
			}];
		}
	}];
}

- (UIImage *)takeScreenshot {
	// Source (Under MIT License): https://github.com/shinydevelopment/SDScreenshotCapture/blob/master/SDScreenshotCapture/SDScreenshotCapture.m#L35

	BOOL ignoreOrientation = SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0");

	UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;

	CGSize imageSize = CGSizeZero;
	if (UIInterfaceOrientationIsPortrait(orientation) || ignoreOrientation)
		imageSize = [UIScreen mainScreen].bounds.size;
	else
		imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);

	UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	CGContextTranslateCTM(context, self.center.x, self.center.y);
	CGContextConcatCTM(context, self.transform);
	CGContextTranslateCTM(context, -self.bounds.size.width * self.layer.anchorPoint.x, -self.bounds.size.height * self.layer.anchorPoint.y);

	// Correct for the screen orientation
	if (!ignoreOrientation) {
		if (orientation == UIInterfaceOrientationLandscapeLeft) {
			CGContextRotateCTM(context, (CGFloat)M_PI_2);
			CGContextTranslateCTM(context, 0, -imageSize.width);
		}
		else if (orientation == UIInterfaceOrientationLandscapeRight) {
			CGContextRotateCTM(context, (CGFloat) - M_PI_2);
			CGContextTranslateCTM(context, -imageSize.height, 0);
		}
		else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
			CGContextRotateCTM(context, (CGFloat)M_PI);
			CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
		}
	}

	if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
		[self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
	else
		[self.layer renderInContext:UIGraphicsGetCurrentContext()];

	CGContextRestoreGState(context);
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	return image;
}

- (NSArray *)allSuperviews {
	NSMutableArray *superviews = [[NSMutableArray alloc] init];
	UIView *view = self;
	UIView *superview = nil;

	while (view) {
		superview = [view superview];

		if (!superview) {
			break;
		}

		[superviews addObject:superview];
		view = superview;
	}
	return superviews;
}

- (NSArray *)allSubviews {
	NSArray *results = [self subviews];

	for (UIView *eachView in[self subviews]) {
		NSArray *riz = [eachView allSubviews];

		if (riz) {
			results = [results arrayByAddingObjectsFromArray:riz];
		}
	}

	return results;
}

- (void)roundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii {
	UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
	CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];

	maskLayer.frame = self.bounds;
	maskLayer.path = maskPath.CGPath;
	self.layer.mask = maskLayer;
}

- (void)removeAllSubviews {
	UIView *view;
	NSArray *subviews = [self subviews];
	NSUInteger i = [subviews count];

	for (; i > 0; --i) {
		view = [subviews objectAtIndex:(i - 1)];
		[view removeFromSuperview];
	}
}

- (UIViewController *)belongViewController {
	for (UIView *next = [self superview]; next; next = next.superview) {
		UIResponder *nextResponder = [next nextResponder];

		if ([nextResponder isKindOfClass:[UIViewController class]]) {
			return (UIViewController *)nextResponder;
		}
	}

	return nil;
}

- (CGPoint)origin {
	return self.frame.origin;
}

- (void)setOrigin:(CGPoint)newOrigin {
	self.frame = CGRectMake(newOrigin.x, newOrigin.y, self.frame.size.width, self.frame.size.height);
}

- (void)setSize:(CGSize)size {
	CGPoint origin = [self frame].origin;

	[self setFrame:CGRectMake(origin.x, origin.y, size.width, size.height)];
}

- (CGSize)size {
	return [self frame].size;
}

- (CGFloat)left {
	return CGRectGetMinX([self frame]);
}

- (void)setLeft:(CGFloat)x {
	CGRect frame = [self frame];

	frame.origin.x = x;
	[self setFrame:frame];
}

- (CGFloat)top {
	return CGRectGetMinY([self frame]);
}

- (void)setTop:(CGFloat)y {
	CGRect frame = [self frame];

	frame.origin.y = y;
	[self setFrame:frame];
}

- (CGFloat)right {
	return CGRectGetMaxX([self frame]);
}

- (void)setRight:(CGFloat)right {
	CGRect frame = [self frame];

	frame.origin.x = right - frame.size.width;

	[self setFrame:frame];
}

- (CGFloat)bottom {
	return CGRectGetMaxY([self frame]);
}

- (void)setBottom:(CGFloat)bottom {
	CGRect frame = [self frame];

	frame.origin.y = bottom - frame.size.height;

	[self setFrame:frame];
}

- (CGFloat)centerX {
	return [self center].x;
}

- (void)setCenterX:(CGFloat)centerX {
	[self setCenter:CGPointMake(centerX, self.center.y)];
}

- (CGFloat)centerY {
	return [self center].y;
}

- (void)setCenterY:(CGFloat)centerY {
	[self setCenter:CGPointMake(self.center.x, centerY)];
}

- (CGFloat)width {
	return CGRectGetWidth([self frame]);
}

- (void)setWidth:(CGFloat)width {
	CGRect frame = [self frame];

	frame.size.width = width;

	[self setFrame:CGRectStandardize(frame)];
}

- (CGFloat)height {
	return CGRectGetHeight([self frame]);
}

- (void)setHeight:(CGFloat)height {
	CGRect frame = [self frame];

	frame.size.height = height;

	[self setFrame:CGRectStandardize(frame)];
}

- (void)bringToFront {
	[self.superview bringSubviewToFront:self];
}

- (void)sendToBack {
	[self.superview sendSubviewToBack:self];
}

- (NSUInteger)indexOfSuperView {
	return [self.superview.subviews indexOfObject:self];
}

- (void)bringOneLevelUp {
	NSInteger currentIndex = [self indexOfSuperView];

	[self.superview exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:currentIndex + 1];
}

- (void)sendOneLevelDown {
	NSInteger currentIndex = [self indexOfSuperView];

	[self.superview exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:currentIndex - 1];
}

- (BOOL)isInFront {
	return ([self.superview.subviews lastObject] == self);
}

- (BOOL)isAtBack {
	return ([self.superview.subviews objectAtIndex:0] == self);
}

@end
