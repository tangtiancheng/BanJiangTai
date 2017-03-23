//
//  UIApplication+XPKit.h
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

#import <UIKit/UIKit.h>

/**
 *  This class add some useful methods to UIApplication
 */
@interface UIApplication (XPKit)

/**
 *  Get applicatin name
 *
 *  @return Return application name as NSString
 */
+ (NSString *)applicationName NS_AVAILABLE(10_5, 2_0);

/**
 *  Set application status bar style
 *
 *  @param style    style
 *  @param animated animated
 */
- (void)setApplicationStyle:(UIStatusBarStyle)style animated:(BOOL)animated;

/**
 *  Send sock
 */
- (void)sendSock;

/**
 *  Register background run model
 */
- (void)registerApplicationBackgroundRun;

/**
 *  Set idle disable
 *
 *  @param disable disable
 */
- (void)setIdleDisable:(BOOL)disable;

@end
