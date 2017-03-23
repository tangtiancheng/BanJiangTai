//
//  XPLog.h
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
 *  NSLog only if in DEBUG mode
 */
#ifdef DEBUG
#define XPLog(...)                 do { printf("\n\n------------------------------ShareMerge------------------------------\n"); printf("文件：%s\n函数：%s\n行号：%u\n", __FILE__, __FUNCTION__, __LINE__); NSLog(__VA_ARGS__); printf("------------------------------ShareMerge------------------------------\n\n"); } while (0)

#define XCODE_COLORS_ESCAPE   @"\033["
#define XCODE_COLORS_RESET_FG XCODE_COLORS_ESCAPE @"fg;"  // Clear any foreground color
#define XCODE_COLORS_RESET_BG XCODE_COLORS_ESCAPE @"bg;"  // Clear any background color
#define XCODE_COLORS_RESET    XCODE_COLORS_ESCAPE @";"    // Clear any foreground or background color
#define XPLogError(frmt, ...)      do { printf("\n\n------------------------------ShareMerge------------------------------\n"); printf("文件：%s\n函数：%s\n行号：%u\n", __FILE__, __FUNCTION__, __LINE__); NSLog((XCODE_COLORS_ESCAPE @"fg255,0,0;" frmt XCODE_COLORS_RESET), ## __VA_ARGS__); printf("------------------------------ShareMerge------------------------------\n\n"); } while (0)
#define XPLogWarn(frmt, ...)       do { printf("\n\n------------------------------ShareMerge------------------------------\n"); printf("文件：%s\n函数：%s\n行号：%u\n", __FILE__, __FUNCTION__, __LINE__); NSLog((XCODE_COLORS_ESCAPE @"fg245,245,0;" frmt XCODE_COLORS_RESET), ## __VA_ARGS__); printf("------------------------------ShareMerge------------------------------\n\n"); } while (0)
#define XPLogInfo(frmt, ...)       do { printf("\n\n------------------------------ShareMerge------------------------------\n"); printf("文件：%s\n函数：%s\n行号：%u\n", __FILE__, __FUNCTION__, __LINE__); NSLog((XCODE_COLORS_ESCAPE @"fg0,0,255;" frmt XCODE_COLORS_RESET), ## __VA_ARGS__); printf("------------------------------ShareMerge------------------------------\n\n"); } while (0)
#define XPLogVerbose(frmt, ...)    do { printf("\n\n------------------------------ShareMerge------------------------------\n"); printf("文件：%s\n函数：%s\n行号：%u\n", __FILE__, __FUNCTION__, __LINE__); NSLog((XCODE_COLORS_ESCAPE @"fg0,255,0;" frmt XCODE_COLORS_RESET), ## __VA_ARGS__); printf("------------------------------ShareMerge------------------------------\n\n"); } while (0)
#else
#define XPLog(...)                 do {} while (0)
#define XPLogError(...)            do {} while (0)
#define XPLogWarn(...)             do {} while (0)
#define XPLogInfo(...)             do {} while (0)
#define XPLogVerbose(...)          do {} while (0)
#endif

@interface XPLog : NSObject

@end
