//
//  NSURLRequest+XPKit.h
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
 *  This class add some useful methods to NSURLRequest
 */
@interface NSURLRequest (XPKit)
{
}

/**
 *  cache policy
 */
@property (nonatomic, readonly) NSURLRequestCachePolicy cachePolicy;

/**
 *  http body
 */
@property (nonatomic, readonly) NSString *httpBody;

/**
 *  http method
 */
@property (nonatomic, readonly) NSString *httpMethod;

/**
 *  should use cookies
 */
@property (nonatomic, readonly) BOOL shouldHandleCookies;

/**
 *  mainDocumentURL
 */
@property (nonatomic, readonly) NSURL *mainDocumentURL;

/**
 *  url string
 */
@property (nonatomic, readonly) NSURL *url;

/**
 *  timeout
 */
@property (nonatomic, readonly) NSTimeInterval timeoutInterval;

/**
 *  Create instance with url string
 *
 *  @param urlString url string
 *
 *  @return Return NSURLRequest instance
 */
+ (instancetype)requestWithURLString:(NSString *)urlString;

@end
