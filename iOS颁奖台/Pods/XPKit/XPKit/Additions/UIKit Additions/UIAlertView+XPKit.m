//
//  UIAlertView+XPKit.m
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

#import "UIAlertView+XPKit.h"
#import <objc/runtime.h>

typedef void (^XP_AlertViewButtonCallback)(NSInteger buttonIndex);

@interface SGAlertView : UIAlertView
{
}
@property (nonatomic, strong) XP_AlertViewButtonCallback callBack;
@end

@implementation SGAlertView

- (id)init
{
    if ((self = [super init]))
    {
        self.delegate = self;
    }

    return self;
} 

- (void)alertView:(SGAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.callBack != nil)
    {
        alertView.callBack(buttonIndex);
    }
}

@end



@implementation UIAlertView (XPKit)

+ (void)alertViewWithTitle:(NSString *)title message:(NSString *)message block:(void (^)(NSInteger buttonIndex))inBlock cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    SGAlertView *alert = [[SGAlertView alloc] init];
    alert.title = title;
    alert.callBack = [inBlock copy];
    alert.message = message;
    [alert addButtonWithTitle:cancelButtonTitle];
    NSMutableArray *buttonsArray = [NSMutableArray array];
    va_list argumentList;

    if (otherButtonTitles)
    {
        NSString *eachItem = nil;
        [buttonsArray addObject:otherButtonTitles];
        va_start(argumentList, otherButtonTitles);

        while ((eachItem = va_arg(argumentList, NSString *)))
            [buttonsArray addObject:eachItem];
        va_end(argumentList);
    }

    for (NSString *item in buttonsArray)
    {
        [alert addButtonWithTitle:item];
    }

    [alert show];
}

+ (void)alertViewWithTitle:(NSString *)title message:(NSString *)message block:(void (^)(NSInteger buttonIndex))inBlock buttonTitle:(NSString *)buttonTitle
{
    return [UIAlertView alertViewWithTitle:title message:message block:inBlock cancelButtonTitle:buttonTitle otherButtonTitles:nil];
}

+ (void)alertViewWithTitle:(NSString *)title message:(NSString *)message block:(void (^)(NSInteger buttonIndex))inBlock
{
    return [UIAlertView alertViewWithTitle:title message:message block:inBlock cancelButtonTitle:NSLocalizedString(@"Activity Cancel", nil]) otherButtonTitles:nil];
}

@end