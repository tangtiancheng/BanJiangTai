//
//  UIColor+XPKit.h
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
 *  This class add some useful methods to UIColor
 */
@interface UIColor (XPKit)

/**
 *  Return the color space
 */
@property (nonatomic, readonly) CGColorSpaceModel colorSpaceModel;

/**
 *  Return red channel
 */
@property (nonatomic, readonly) CGFloat red;

/**
 *  Return green channel
 */
@property (nonatomic, readonly) CGFloat green;

/**
 *  Return blue channel
 */
@property (nonatomic, readonly) CGFloat blue;

/**
 *  Return alpha channel
 */
@property (nonatomic, readonly) CGFloat alpha;

/**
 *  Return hex value
 */
@property (nonatomic, readonly) UInt32 rgbHex;

/**
 *  Create a color form red,green,blue value
 *
 *  @param red   red channel value
 *  @param green green channel value
 *  @param blue  blue channel value
 *
 *  @return Return the UIColor instance
 */
+ (UIColor *)colorMakeWithRed:(unsigned int)red green:(unsigned int)green blue:(unsigned int)blue;

/**
 *  Create a color form red,green,blue,alpha value
 *
 *  @param red    red channel value
 *  @param green  green channel value
 *  @param blue   blue channel value
 *  @param alpha  alpha channel value
 *
 *  @return Return the UIColor instance

 */
+ (UIColor *)colorMakeWithRed:(unsigned int)red green:(unsigned int)green blue:(unsigned int)blue alpha:(unsigned int)alpha;

/**
 *  Create a color form a RGB string
 *
 *  @param rgbString RGB string
 *
 *  @return Return the UIColor instance
 */
+ (UIColor *)colorWithRGB:(NSString *)rgbString;

/**
 *  Create a color from a RGBA string
 *
 *  @param rgbaString RGBA string
 *
 *  @return Return the UIColor instance
 */
+ (UIColor *)colorWithRGBA:(NSString *)rgbaString;

/**
 *  Create a color from a HEX string
 *
 *  @param hexString HEX string
 *
 *  @return Return the UIColor instance
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;

/**
 *  Create a color from HEX
 *
 *  @param hex HEX value
 *
 *  @return Return the UIColor instance
 */
+ (UIColor *)colorWithHex:(unsigned int)hex;

/**
 *  Create a color from HEX with alpha
 *
 *  @param hex   HEX value
 *  @param alpha Alpha value
 *
 *  @return Return the UIColor instance
 */
+ (UIColor *)colorWithHex:(unsigned int)hex
                    alpha:(float)alpha;

/**
 *  Create a random color
 *
 *  @return Return the UIColor instance
 */
+ (UIColor *)randomColor;

/**
 *  Create a color from a given color with alpha
 *
 *  @param color UIColor value
 *  @param alpha Alpha value
 *
 *  @return Return the UIColor instance
 */
+ (UIColor *)colorWithColor:(UIColor *)color
                      alpha:(float)alpha;

@end
