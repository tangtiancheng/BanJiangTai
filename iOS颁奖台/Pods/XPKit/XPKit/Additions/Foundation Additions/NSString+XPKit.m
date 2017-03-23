//
//  NSString+XPKit.m
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

#import "NSString+XPKit.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSData+XPKit.h"

@implementation NSString (XPKit)

+ (NSString *)searchInString:(NSString *)string charStart:(char)start charEnd:(char)end {
	int inizio = 0, stop = 0;
	for (int i = 0; i < [string length]; i++) {
		if ([string characterAtIndex:i] == start) {
			inizio = i + 1;
			i += 1;
		}
		if ([string characterAtIndex:i] == end) {
			stop = i;
			break;
		}
	}
	stop -= inizio;
	NSString *string2 = [[string substringFromIndex:inizio - 1] substringToIndex:stop + 1];

	return string2;
}

- (NSString *)searchCharStart:(char)start charEnd:(char)end {
	int inizio = 0, stop = 0;
	for (int i = 0; i < [self length]; i++) {
		if ([self characterAtIndex:i] == start) {
			inizio = i + 1;
			i += 1;
		}
		if ([self characterAtIndex:i] == end) {
			stop = i;
			break;
		}
	}
	stop -= inizio;
	NSString *string = [[self substringFromIndex:inizio - 1] substringToIndex:stop + 1];

	return string;
}

- (NSString *)MD5 {
	if (self == nil || [self length] == 0)
		return nil;

	unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
	CC_MD5([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
	NSMutableString *ms = [NSMutableString string];
	for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
		[ms appendFormat:@"%02x", (int)(digest[i])];
	}
	return [ms copy];
}

- (NSString *)SHA1 {
	if (self == nil || [self length] == 0)
		return nil;

	unsigned char digest[CC_SHA1_DIGEST_LENGTH], i;
	CC_SHA1([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
	NSMutableString *ms = [NSMutableString string];
	for (i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
		[ms appendFormat:@"%02x", (int)(digest[i])];
	}
	return [ms copy];
}

- (NSString *)SHA256 {
	if (self == nil || [self length] == 0)
		return nil;

	unsigned char digest[CC_SHA256_DIGEST_LENGTH], i;
	CC_SHA256([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
	NSMutableString *ms = [NSMutableString string];
	for (i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
		[ms appendFormat:@"%02x", (int)(digest[i])];
	}
	return [ms copy];
}

- (NSString *)SHA512 {
	if (self == nil || [self length] == 0)
		return nil;

	unsigned char digest[CC_SHA512_DIGEST_LENGTH], i;
	CC_SHA512([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
	NSMutableString *ms = [NSMutableString string];
	for (i = 0; i < CC_SHA512_DIGEST_LENGTH; i++) {
		[ms appendFormat:@"%02x", (int)(digest[i])];
	}
	return [ms copy];
}

- (BOOL)hasString:(NSString *)substring {
	return !([self rangeOfString:substring].location == NSNotFound);
}

- (BOOL)isEmail {
	NSString *emailRegEx =
	    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
	    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
	    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
	    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
	    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
	    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
	    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";

	NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
	return [regExPredicate evaluateWithObject:[self lowercaseString]];
}

+ (BOOL)isEmail:(NSString *)email {
	NSString *emailRegEx =
	    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
	    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
	    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
	    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
	    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
	    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
	    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";

	NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
	return [regExPredicate evaluateWithObject:[email lowercaseString]];
}

+ (NSString *)convertToUTF8Entities:(NSString *)string {
	NSString *isoEncodedString = [[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[
	                                                                 [string stringByReplacingOccurrencesOfString:@"%27" withString:@"'"]
	                                                                 stringByReplacingOccurrencesOfString:[@"%e2%80%99" capitalizedString] withString:@"’"]
	                                                             stringByReplacingOccurrencesOfString:[@"%2d" capitalizedString] withString:@"-"]
	                                                            stringByReplacingOccurrencesOfString:[@"%c2%ab" capitalizedString] withString:@"«"]
	                                                           stringByReplacingOccurrencesOfString:[@"%c2%bb" capitalizedString] withString:@"»"]
	                                                          stringByReplacingOccurrencesOfString:[@"%c3%80" capitalizedString] withString:@"À"]
	                                                         stringByReplacingOccurrencesOfString:[@"%c3%82" capitalizedString] withString:@"Â"]
	                                                        stringByReplacingOccurrencesOfString:[@"%c3%84" capitalizedString] withString:@"Ä"]
	                                                       stringByReplacingOccurrencesOfString:[@"%c3%86" capitalizedString] withString:@"Æ"]
	                                                      stringByReplacingOccurrencesOfString:[@"%c3%87" capitalizedString] withString:@"Ç"]
	                                                     stringByReplacingOccurrencesOfString:[@"%c3%88" capitalizedString] withString:@"È"]
	                                                    stringByReplacingOccurrencesOfString:[@"%c3%89" capitalizedString] withString:@"É"]
	                                                   stringByReplacingOccurrencesOfString:[@"%c3%8a" capitalizedString] withString:@"Ê"]
	                                                  stringByReplacingOccurrencesOfString:[@"%c3%8b" capitalizedString] withString:@"Ë"]
	                                                 stringByReplacingOccurrencesOfString:[@"%c3%8f" capitalizedString] withString:@"Ï"]
	                                                stringByReplacingOccurrencesOfString:[@"%c3%91" capitalizedString] withString:@"Ñ"]
	                                               stringByReplacingOccurrencesOfString:[@"%c3%94" capitalizedString] withString:@"Ô"]
	                                              stringByReplacingOccurrencesOfString:[@"%c3%96" capitalizedString] withString:@"Ö"]
	                                             stringByReplacingOccurrencesOfString:[@"%c3%9b" capitalizedString] withString:@"Û"]
	                                            stringByReplacingOccurrencesOfString:[@"%c3%9c" capitalizedString] withString:@"Ü"]
	                                           stringByReplacingOccurrencesOfString:[@"%c3%a0" capitalizedString] withString:@"à"]
	                                          stringByReplacingOccurrencesOfString:[@"%c3%a2" capitalizedString] withString:@"â"]
	                                         stringByReplacingOccurrencesOfString:[@"%c3%a4" capitalizedString] withString:@"ä"]
	                                        stringByReplacingOccurrencesOfString:[@"%c3%a6" capitalizedString] withString:@"æ"]
	                                       stringByReplacingOccurrencesOfString:[@"%c3%a7" capitalizedString] withString:@"ç"]
	                                      stringByReplacingOccurrencesOfString:[@"%c3%a8" capitalizedString] withString:@"è"]
	                                     stringByReplacingOccurrencesOfString:[@"%c3%a9" capitalizedString] withString:@"é"]
	                                    stringByReplacingOccurrencesOfString:[@"%c3%af" capitalizedString] withString:@"ï"]
	                                   stringByReplacingOccurrencesOfString:[@"%c3%b4" capitalizedString] withString:@"ô"]
	                                  stringByReplacingOccurrencesOfString:[@"%c3%b6" capitalizedString] withString:@"ö"]
	                                 stringByReplacingOccurrencesOfString:[@"%c3%bb" capitalizedString] withString:@"û"]
	                                stringByReplacingOccurrencesOfString:[@"%c3%bc" capitalizedString] withString:@"ü"]
	                               stringByReplacingOccurrencesOfString:[@"%c3%XP" capitalizedString] withString:@"ÿ"]
	                              stringByReplacingOccurrencesOfString:@"%20" withString:@" "];

	return isoEncodedString;
}

- (NSString *)sentenceCapitalizedString {
	if (![self length]) {
		return [NSString string];
	}
	NSString *uppercase = [[self substringToIndex:1] uppercaseString];
	NSString *lowercase = [[self substringFromIndex:1] lowercaseString];

	return [uppercase stringByAppendingString:lowercase];
}

- (NSString *)dateFromTimestamp {
	NSString *year = [self substringToIndex:4];
	NSString *month = [[self substringFromIndex:5] substringToIndex:2];
	NSString *day = [[self substringFromIndex:8] substringToIndex:2];
	NSString *hours = [[self substringFromIndex:11] substringToIndex:2];
	NSString *minutes = [[self substringFromIndex:14] substringToIndex:2];

	return [NSString stringWithFormat:@"%@/%@/%@ %@:%@", day, month, year, hours, minutes];
}

- (NSString *)urlEncode {
	NSMutableString *output = [NSMutableString string];
	const unsigned char *source = (const unsigned char *)[self UTF8String];
	int sourceLen = (int)strlen((const char *)source);
	for (int i = 0; i < sourceLen; ++i) {
		const unsigned char thisChar = source[i];

		if (thisChar == ' ') {
			[output appendString:@"+"];
		}
		else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' || (thisChar >= 'a' && thisChar <= 'z') || (thisChar >= 'A' && thisChar <= 'Z') || (thisChar >= '0' && thisChar <= '9')) {
			[output appendFormat:@"%c", thisChar];
		}
		else {
			[output appendFormat:@"%%%02X", thisChar];
		}
	}

	return output;
}

- (NSString *)urlDecode {
	NSMutableString *outputStr = [NSMutableString stringWithString:self];
	[outputStr replaceOccurrencesOfString:@"+" withString:@" " options:NSLiteralSearch range:NSMakeRange(0, [outputStr length])];
	NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
	                                                                                                         (CFStringRef)outputStr,
	                                                                                                         CFSTR(""),
	                                                                                                         kCFStringEncodingUTF8));
	return result;
}

- (instancetype)stringToObject {
	return [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
}

- (NSString *)hmacAlgorithm:(CCHmacAlgorithm)type secret:(NSString *)secret {
	NSInteger length = 0;

	switch (type) {
		case kCCHmacAlgMD5:
			length = CC_MD5_DIGEST_LENGTH;
			break;

		case kCCHmacAlgSHA1:
			length = CC_SHA1_DIGEST_LENGTH;
			break;

		case kCCHmacAlgSHA224:
			length = CC_SHA224_DIGEST_LENGTH;
			break;

		case kCCHmacAlgSHA256:
			length = CC_SHA256_DIGEST_LENGTH;
			break;

		case kCCHmacAlgSHA384:
			length = CC_SHA384_DIGEST_LENGTH;
			break;

		case kCCHmacAlgSHA512:
			length = CC_SHA512_DIGEST_LENGTH;
			break;

		default:
			return nil;

			break;
	}
	CCHmacContext ctx;
	const char *key = [secret UTF8String];
	const char *str = [self UTF8String];
	unsigned char mac[length];
	char hexmac[2 * length + 1];
	char *p;

	CCHmacInit(&ctx, type, key, strlen(key));
	CCHmacUpdate(&ctx, str, strlen(str));
	CCHmacFinal(&ctx, mac);

	p = hexmac;

	for (int i = 0; i < length; i++) {
		snprintf(p, 3, "%02x", mac[i]);
		p += 2;
	}

	return [NSString stringWithUTF8String:hexmac];
}

- (NSString *)base64Encode {
	NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
	return [data base64Encode];
}

- (NSString *)base64Decode {
	NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
	return [data base64Decode];
}

- (unsigned long long)unsignedLongLongValue {
	return strtoull([self UTF8String], NULL, 0);
}

- (NSString *)removeWhitespaceAndNewline {
	NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
	return [self stringByTrimmingCharactersInSet:whitespace];
}

- (NSInteger)hexValue {
	CFStringRef cfSelf = (__bridge CFStringRef)self;
	UInt8 buffer[64];
	const char *cptr;

	if ((cptr = CFStringGetCStringPtr(cfSelf, kCFStringEncodingMacRoman)) == NULL) {
		CFRange range     = CFRangeMake(0L, CFStringGetLength(cfSelf));
		CFIndex usedBytes = 0L;
		CFStringGetBytes(cfSelf, range, kCFStringEncodingUTF8, '?', false, buffer, 60L, &usedBytes);
		buffer[usedBytes] = 0;
		cptr              = (const char *)buffer;
	}

	return((NSInteger)strtol(cptr, NULL, 16));
}

- (unsigned int)unsignedIntValue {
	return (unsigned int)strtoull([self UTF8String], NULL, 0);
}

- (CGSize)findHeightForHavingWidth:(CGFloat)widthValue andFont:(UIFont *)font {
    CGSize size = CGSizeZero;
    if(self) {
        CGRect frame = [self boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font }
                                          context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    
    return size;
}

@end
