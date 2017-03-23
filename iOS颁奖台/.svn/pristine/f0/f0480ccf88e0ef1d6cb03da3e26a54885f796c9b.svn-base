//
//  UIActionSheet+XPKit.h
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
 *  This class add some useful methods to UIActionSheet
 */
@interface UIActionSheet (block) <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

/**
 *  Create UIActionSheet instance
 *
 *  @param title        title
 *  @param message      message
 *  @param buttonTitles button titles
 *  @param view         view
 *  @param dismissed    dismissed block
 *  @param cancelled    cancelled block
 */
+ (void)actionSheetWithTitle:(NSString *)title
                     message:(NSString *)message
                     buttons:(NSArray *)buttonTitles
                  showInView:(UIView *)view
                   onDismiss:(void (^)(NSInteger buttonIndex, NSString *buttonTitle))dismissed
                    onCancel:(void (^)())cancelled;

/**
 *  Create UIActionSheet instance
 *
 *  @param title                  title
 *  @param message                message
 *  @param destructiveButtonTitle destructive button title
 *  @param cancelButtonTitle      cancel button title
 *  @param buttonTitles           button titles
 *  @param view                   view
 *  @param dismissed              dismissed block
 *  @param cancelled              cancelled block
 */
+ (void)actionSheetWithTitle:(NSString *)title
                     message:(NSString *)message
      destructiveButtonTitle:(NSString *)destructiveButtonTitle
           cancelButtonTitle:(NSString *)cancelButtonTitle
                     buttons:(NSArray *)buttonTitles
                  showInView:(UIView *)view
                   onDismiss:(void (^)(NSInteger buttonIndex, NSString *buttonTitle))dismissed
                    onCancel:(void (^)())cancelled;

/**
 *  Create photo picker UIActionSheet instance
 *
 *  @param title       title
 *  @param view        view
 *  @param presentVC   presentVC
 *  @param allowsEdit   allowsEdit
 *  @param photoPicked photoPicked block
 *  @param cancelled   cancelled block
 */
+ (void)photoPickerWithTitle:(NSString *)title
                  showInView:(UIView *)view
                   presentVC:(UIViewController *)presentVC
                  allowsEdit:(BOOL)allowsEdit
               onPhotoPicked:(void (^)(UIImage *chosenImage))photoPicked
                    onCancel:(void (^)())cancelled;

@end
