//
//  NSDate+XPKit.h
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
#import <Foundation/Foundation.h>


/**
 *  This class add some useful methods to NSDate
 */
@interface NSData (XPKit)

/**
 *  Convert self to string value
 *
 *  @return Return a string value
 */
- (NSString *)stringValue;

/**
 *  Encoed self to an encoed base64 string
 *
 *  @return Return the encoed string
 */
- (NSString *)base64Encode;

/**
 *  Decoed self to an decoed base64 string
 *
 *  @return Return the decoed string
 */
- (NSString *)base64Decode;

/**
 *  Convert self to hex stringvalue
 *
 *  @return Return a hex string value
 */
- (NSString *)hexValue;

/**
 *  Encoed self to an encode md5 string
 *
 *  @return Return the encoed string
 */
- (NSString *)md5;

/**
 *  Encoed self to an encode aes string
 *
 *  @param key key
 *  @param iv  iv
 *
 *  @return Return the encoed string
 */
- (NSData *)aesEncryptWithKey:(NSString *)key initialVector:(NSString *)iv;

/**
 *  Decoed self to an decode aes string
 *
 *  @param key key
 *  @param iv  iv
 *
 *  @return Return the decoed string
 */
- (NSData *)aesDecryptWithKey:(NSString *)key initialVector:(NSString *)iv;

/**
 *  Convert self to a gb18030 string
 *
 *  @return Return the gb18030 string
 */
- (NSString *)gb18030String;

@end
