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

#import "UIColor+XPKit.h"

@implementation UIColor (XPKit)

- (BOOL)red:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha {
	const CGFloat *components = CGColorGetComponents(self.CGColor);
	CGFloat r, g, b, a;

	switch (self.colorSpaceModel) {
		case kCGColorSpaceModelRGB:
			r = components[0];
			g = components[1];
			b = components[2];
			a = components[3];
			break;

		default:                        // We don't know how to handle this model
			return NO;
	}

	if (red) *red = r;

	if (green) *green = g;

	if (blue) *blue = b;

	if (alpha) *alpha = a;

	return YES;
}

- (CGColorSpaceModel)colorSpaceModel {
	return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
}

- (CGFloat)red {
	const CGFloat *c = CGColorGetComponents(self.CGColor);

	return c[0];
}

- (CGFloat)green {
	const CGFloat *c = CGColorGetComponents(self.CGColor);

	if (self.colorSpaceModel == kCGColorSpaceModelMonochrome) return c[0];

	return c[1];
}

- (CGFloat)blue {
	const CGFloat *c = CGColorGetComponents(self.CGColor);

	if (self.colorSpaceModel == kCGColorSpaceModelMonochrome) return c[0];

	return c[2];
}

- (CGFloat)alpha {
	return CGColorGetAlpha(self.CGColor);
}

- (UInt32)rgbHex {
	CGFloat r, g, b, a;

	if (![self red:&r green:&g blue:&b alpha:&a]) {
		return 0;
	}

	r = MIN(MAX(r, 0.0f), 1.0f);
	g = MIN(MAX(g, 0.0f), 1.0f);
	b = MIN(MAX(b, 0.0f), 1.0f);

	return (UInt32)(((int)roundf(r * 255)) << 16) | (((int)roundf(g * 255)) << 8) | (((int)roundf(b * 255)));
}

+ (UIColor *)colorMakeWithRed:(unsigned int)red green:(unsigned int)green blue:(unsigned int)blue {
	return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

+ (UIColor *)colorMakeWithRed:(unsigned int)red green:(unsigned int)green blue:(unsigned int)blue alpha:(unsigned int)alpha {
	return [UIColor colorWithRed:red / 255.0f green:green / 255.0f blue:blue / 255.0f alpha:alpha / 255.0f];
}

+ (UIColor *)colorWithRGB:(NSString *)rgbString {
	NSArray *rgb = [rgbString componentsSeparatedByString:@","];
	return [UIColor colorWithRed:[[rgb objectAtIndex:0] floatValue] / 255 green:[[rgb objectAtIndex:1] floatValue] / 255 blue:[[rgb objectAtIndex:2] floatValue] / 255 alpha:1];
}

+ (UIColor *)colorWithRGBA:(NSString *)rgbaString {
	NSArray *rgba = [rgbaString componentsSeparatedByString:@","];
	return [UIColor colorWithRed:[[rgba objectAtIndex:0] floatValue] / 255 green:[[rgba objectAtIndex:1] floatValue] / 255 blue:[[rgba objectAtIndex:2] floatValue] / 255 alpha:0.5f];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
	NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
	CGFloat alpha, red, blue, green;
	switch ([colorString length]) {
		case 3: // #RGB
			alpha = 1.0f;
			red = [self colorComponentFrom:colorString start:0 length:1];
			green = [self colorComponentFrom:colorString start:1 length:1];
			blue = [self colorComponentFrom:colorString start:2 length:1];
			break;

		case 4: // #ARGB
			alpha = [self colorComponentFrom:colorString start:0 length:1];
			red = [self colorComponentFrom:colorString start:1 length:1];
			green = [self colorComponentFrom:colorString start:2 length:1];
			blue = [self colorComponentFrom:colorString start:3 length:1];
			break;

		case 6: // #RRGGBB
			alpha = 1.0f;
			red = [self colorComponentFrom:colorString start:0 length:2];
			green = [self colorComponentFrom:colorString start:2 length:2];
			blue = [self colorComponentFrom:colorString start:4 length:2];
			break;

		case 8: // #AARRGGBB
			alpha = [self colorComponentFrom:colorString start:0 length:2];
			red = [self colorComponentFrom:colorString start:2 length:2];
			green = [self colorComponentFrom:colorString start:4 length:2];
			blue = [self colorComponentFrom:colorString start:6 length:2];
			break;

		default:
			[NSException raise:@"Invalid color value" format:@"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
			break;
	}
	return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length {
	NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
	NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat:@"%@%@", substring, substring];
	unsigned hexComponent;
	[[NSScanner scannerWithString:fullHex] scanHexInt:&hexComponent];

	return hexComponent / 255.0;
}

+ (id)colorWithHex:(unsigned int)hex {
	return [UIColor colorWithHex:hex alpha:1.0];
}

+ (id)colorWithHex:(unsigned int)hex alpha:(float)alpha {
	return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:alpha];
}

+ (UIColor *)randomColor {
	int r = arc4random() % 255;
	int g = arc4random() % 255;
	int b = arc4random() % 255;

	return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1.0];
}

+ (UIColor *)colorWithColor:(UIColor *)color alpha:(float)alpha {
	if ([color isEqual:[UIColor whiteColor]])
		return [UIColor colorWithWhite:1.000 alpha:alpha];
	if ([color isEqual:[UIColor blackColor]])
		return [UIColor colorWithWhite:0.000 alpha:alpha];

	const CGFloat *components = CGColorGetComponents(color.CGColor);
	return [UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:alpha];
}

@end
