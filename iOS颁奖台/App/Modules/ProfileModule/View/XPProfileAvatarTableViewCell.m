//
//  XPProfileAvatarTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 12/29/15.
//  Copyright 2015 ShareMerge. All rights reserved.
//

#import "NSString+XPRemoteImage.h"
#import "XPLoginModel.h"
#import "XPProfileAvatarTableViewCell.h"
#import "XPProfileViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XPAlertController/XPAlertController.h>
#import <XPKit/XPKit.h>

@interface XPProfileAvatarTableViewCell ()<XPAlertControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) XPAlertController *alertController;
@property (nonatomic, weak) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, strong) XPProfileViewModel *viewModel;

@end

@implementation XPProfileAvatarTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    @weakify(self);
    RAC(self, avatarImageView.image) = [RACObserve([XPLoginModel singleton], userImage) flattenMap:^RACStream *(id value) {
        return [value rac_remote_image];
    }];
    
    [self whenTapped:^{
        @strongify(self);
        [self contentTaped];
    }];
}

#pragma mark - Delegate
#pragma mark - XPAlertController Delegate
- (void)alertController:(XPAlertController *)alertController didSelectRow:(NSInteger)row
{
    [self pickImageIfTakeNew:0 == row ? YES : NO];
}

#pragma mark UIImagePicker Delegate
- (void)pickImageIfTakeNew:(BOOL)takeNew
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = takeNew ? UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [[self belongViewController] presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info
{
    UIImage *editedImage = (UIImage *)[info valueForKey:UIImagePickerControllerEditedImage];
    if(!editedImage) {
        editedImage = (UIImage *)[info valueForKey:UIImagePickerControllerOriginalImage];
    }
    
    [self processAddedImage:editedImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)processAddedImage:(UIImage *)image
{
    self.avatarImageView.image = image;
    self.viewModel.avatarImage = image;
}

#pragma mark - Event Responds
- (void)contentTaped
{
    self.alertController = [[XPAlertController alloc] initWithActivity:@[@"拍照", @"从手机相册选择"] title:nil];
    self.alertController.delegate = self;
    [self.alertController show];
}

#pragma mark - Public Interface
- (void)bindViewModel:(XPProfileViewModel *)viewModel
{
    NSParameterAssert([viewModel isKindOfClass:[XPProfileViewModel class]]);
    self.viewModel = viewModel;
}

#pragma mark - Private Methods

#pragma mark - Getter & Setter

@end
