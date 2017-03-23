//
//  UIActionSheet+XPKit.m
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

#import "UIActionSheet+XPKit.h"

#define kPhotoActionSheetTag 9999

typedef void (^XP_CancelBlock)();

typedef void (^XP_DismissBlock)(NSInteger buttonIndex, NSString *buttonTitle);
typedef void (^XP_PhotoPickedBlock)(UIImage *chosenImage
                                    );

static XP_DismissBlock _dismissBlock;
static XP_CancelBlock _cancelBlock;
static XP_PhotoPickedBlock _photoPickedBlock;
static UIViewController *_presentVC;
static BOOL _allowsEdit;

@implementation UIActionSheet (block)

+ (void)actionSheetWithTitle:(NSString *)title
                     message:(NSString *)message
                     buttons:(NSArray *)buttonTitles
                  showInView:(UIView *)view
                   onDismiss:(void (^)(NSInteger buttonIndex, NSString *buttonTitle))dismissed
                    onCancel:(void (^)())cancelled
{
    [UIActionSheet actionSheetWithTitle:title
                                message:message
                 destructiveButtonTitle:nil
                      cancelButtonTitle:@"取消"
                                buttons:buttonTitles
                             showInView:view
                              onDismiss:dismissed
                               onCancel:cancelled];
}

+ (void)actionSheetWithTitle:(NSString *)title
                     message:(NSString *)message
      destructiveButtonTitle:(NSString *)destructiveButtonTitle
           cancelButtonTitle:(NSString *)cancelButtonTitle
                     buttons:(NSArray *)buttonTitles
                  showInView:(UIView *)view
                   onDismiss:(void (^)(NSInteger buttonIndex, NSString *buttonTitle))dismissed
                    onCancel:(void (^)())cancelled
{
    _cancelBlock = [cancelled copy];
    _dismissBlock = [dismissed copy];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                             delegate:[self class]
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:destructiveButtonTitle
                                                    otherButtonTitles:nil];
    
    for(NSString *thisButtonTitle in buttonTitles) {
        [actionSheet addButtonWithTitle:thisButtonTitle];
    }
    [actionSheet addButtonWithTitle:cancelButtonTitle];
    actionSheet.cancelButtonIndex = [buttonTitles count];
    if(destructiveButtonTitle) {
        actionSheet.cancelButtonIndex++;
    }
    if([view isKindOfClass:[UIView class]]) {
        [actionSheet showInView:view];
    }
    if([view isKindOfClass:[UITabBar class]]) {
        [actionSheet showFromTabBar:(UITabBar *)view];
    }
    if([view isKindOfClass:[UIBarButtonItem class]]) {
        [actionSheet showFromBarButtonItem:(UIBarButtonItem *)view animated:YES];
    }
}

+ (void)photoPickerWithTitle:(NSString *)title
                  showInView:(UIView *)view
                   presentVC:(UIViewController *)presentVC
                  allowsEdit:(BOOL)allowsEdit
               onPhotoPicked:(void (^)(UIImage *chosenImage))photoPicked
                    onCancel:(void (^)())cancelled
{
    _cancelBlock = [cancelled copy];
    
    _photoPickedBlock = [photoPicked copy];
    
    _presentVC = presentVC;
    
    _allowsEdit = allowsEdit;
    
    int cancelButtonIndex = -1;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                             delegate:[self class]
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [actionSheet addButtonWithTitle:@"拍照"];
        cancelButtonIndex++;
    }
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [actionSheet addButtonWithTitle:@"从相册选择"];
        cancelButtonIndex++;
    }
    
    [actionSheet addButtonWithTitle:@"取消"];
    cancelButtonIndex++;
    
    actionSheet.tag = kPhotoActionSheetTag;
    actionSheet.cancelButtonIndex = cancelButtonIndex;
    if([view isKindOfClass:[UIView class]]) {
        [actionSheet showInView:view];
    }
    if([view isKindOfClass:[UITabBar class]]) {
        [actionSheet showFromTabBar:(UITabBar *)view];
    }
    if([view isKindOfClass:[UIBarButtonItem class]]) {
        [actionSheet showFromBarButtonItem:(UIBarButtonItem *)view animated:YES];
    }
}

+ (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *editedImage = (UIImage *)[info valueForKey:UIImagePickerControllerEditedImage];
    if(!editedImage) {
        editedImage = (UIImage *)[info valueForKey:UIImagePickerControllerOriginalImage];
    }
    
    _photoPickedBlock(editedImage);
    [picker dismissViewControllerAnimated:YES completion:nil];
}

+ (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    // Dismiss the image selection and close the program
    [picker dismissViewControllerAnimated:YES completion:nil];
    _cancelBlock();
}

+ (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == [actionSheet cancelButtonIndex]) {
        _cancelBlock();
    } else {
        if(actionSheet.tag == kPhotoActionSheetTag) {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                buttonIndex++;
            }
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                buttonIndex++;
            }
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = [self class];
            picker.allowsEditing = _allowsEdit;
            if(buttonIndex == 1) {
                picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            } else if(buttonIndex == 2) {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;;
            }
            
            [_presentVC presentViewController:picker animated:YES completion:nil];
        } else {
            _dismissBlock(buttonIndex, [actionSheet buttonTitleAtIndex:buttonIndex]);
        }
    }
}

@end
