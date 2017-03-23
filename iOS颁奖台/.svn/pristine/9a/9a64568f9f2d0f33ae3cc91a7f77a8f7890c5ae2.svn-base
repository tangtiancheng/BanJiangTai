//
//  UIView+XPKit.h
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
 *  This class add some useful methods to UIView
 */
@interface UIView (XPKit) <UIGestureRecognizerDelegate>

/**
 *  Return it's origin
 */
@property (nonatomic, assign) CGPoint origin;

/**
 *  Return it's size
 */
@property (nonatomic, assign) CGSize size;

/**
 *  Return it's left position
 */
@property (nonatomic, assign) CGFloat left;

/**
 *  Return it's right position
 */
@property (nonatomic, assign) CGFloat right;

/**
 *  Return it's top position
 */
@property (nonatomic, assign) CGFloat top;

/**
 *  Return it's bottom position
 */
@property (nonatomic, assign) CGFloat bottom;

/**
 *  Return it's center position on X alas
 */
@property (nonatomic, assign) CGFloat centerX;

/**
 *  Return it's center position on Y alas
 */
@property (nonatomic, assign) CGFloat centerY;

/**
 *  Return it's width
 */
@property (nonatomic, assign) CGFloat width;

/**
 *  Return it's height
 */
@property (nonatomic, assign) CGFloat height;

/**
 *  Return YES it's front level
 */
@property (nonatomic, readonly, getter = isInFront) BOOL inFront;

/**
 *  Return YES it's back level
 */
@property (nonatomic, readonly, getter = isAtBack) BOOL atBack;

/**
 *  Take a screenshot of current window
 *
 *  @return Return the screenshot as an UIImage
 */
- (UIImage *)takeScreenshot;

/**
 *  Create an UIView with the given frame and background color
 *
 *  @param frame           UIView's frame
 *  @param backgroundColor UIView's background color
 */
+ (UIView *)initWithFrame:(CGRect)frame
          backgroundColor:(UIColor *)backgroundColor;

/**
 *  Create an UIView from Nib file
 */
+ (UIView *)viewFromNib;

/**
 *  Create a border around the UIView
 *
 *  @param color  Border's color
 *  @param radius Border's radius
 *  @param width  Border's width
 */
- (void)createBordersWithColor:(UIColor *)color
              withCornerRadius:(CGFloat)radius
                      andWidth:(CGFloat)width;

/**
 *  Remove the borders around the UIView
 */
- (void)removeBorders;

/**
 *  Create a shadow on the UIView
 *
 *  @param offset  Shadow's offset
 *  @param opacity Shadow's opacity
 *  @param radius  Shadow's radius
 */
- (void)createRectShadowWithOffset:(CGSize)offset
                           opacity:(CGFloat)opacity
                            radius:(CGFloat)radius;

/**
 *  Create a corner radius shadow on the UIView
 *
 *  @param cornerRadius Corner radius value
 *  @param offset       Shadow's offset
 *  @param opacity      Shadow's opacity
 *  @param radius       Shadow's radius
 */
- (void)createCornerRadiusShadowWithCornerRadius:(CGFloat)cornerRadius
                                          offset:(CGSize)offset
                                         opacity:(CGFloat)opacity
                                          radius:(CGFloat)radius;

/**
 *  Remove the shadow around the UIView
 */
- (void)removeShadow;

/**
 *  Set the corner radius of UIView
 *
 *  @param radius Radius value
 */
- (void)setCornerRadius:(CGFloat)radius;

/**
 *  Create a shake effect on the UIView
 */
- (void)shakeView;

/**
 *  Create a pulse effect on th UIView
 *
 *  @param seconds Seconds of animation
 */
- (void)pulseViewWithTime:(CGFloat)seconds;

/**
 *  Return super view whole
 *
 *  @return Return super view whole
 */
- (NSArray *)allSuperviews;

/**
 *  Remove subviews
 */
- (void)removeAllSubviews;

/**
 *  Return allsubviews
 *
 *  @return Return array with subviews
 */
- (NSArray *)allSubviews;

/**
 *  Return belong viewcontroller
 *
 *  @return Return UIViewController instance
 */
- (UIViewController *)belongViewController;

/**
 *  Bring it to front level
 */
- (void)bringToFront;

/**
 *  Send it to back level
 */
- (void)sendToBack;

/**
 *  upgrade it one level
 */
- (void)bringOneLevelUp;

/**
 *  downgrade it one level
 */
- (void)sendOneLevelDown;

/**
 *  whe single tapped
 *
 *  @param block block
 */
- (void)whenTapped:(void (^)())block;

/**
 *  whe double tapped
 *
 *  @param block block
 */
- (void)whenDoubleTapped:(void (^)())block;

/**
 *  whe tow finder tapped
 *
 *  @param block block
 */
- (void)whenTwoFingerTapped:(void (^)())block;

/**
 *  whe touched down
 *
 *  @param block block
 */
- (void)whenTouchedDown:(void (^)())block;

/**
 *  whe touched up
 *
 *  @param block block
 */
- (void)whenTouchedUp:(void (^)())block;

@end
