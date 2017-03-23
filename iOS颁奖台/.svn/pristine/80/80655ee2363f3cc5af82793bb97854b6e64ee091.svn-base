//
//  XPProfileView.m
//  XPApp
//
//  Created by xinpinghuang on 12/28/15.
//  Copyright © 2015 ShareMerge. All rights reserved.
//

#import "NSString+XPRemoteImage.h"
#import "XPBaseViewController.h"
#import "XPLoginModel.h"
#import "XPProfileView.h"
#import <XPKit/XPKit.h>
#import <XPAlertController/XPAlertController.h>
#import "XPMeViewModel.h"

#define FILTER_UNSIGNIN 0
@interface XPProfileView ()<XPAlertControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, weak) IBOutlet UILabel *nickNameLabel;
@property (nonatomic, strong) XPAlertController *alertController;
@property (nonatomic, strong) XPMeViewModel *viewModel;

@end

@implementation XPProfileView

#pragma mark - Life Circle
- (void)awakeFromNib
{
    @weakify(self);
    RAC(self.avatarImageView, image) = [[RACObserve([XPLoginModel singleton], userImage) flattenMap:^RACStream *(NSString *value) {
        return (value&&![value isEqualToString:@""]) ? [value rac_remote_image] : [RACSignal return :[UIImage imageNamed:@"common_default_avatar"]];
    }] deliverOn:[RACScheduler mainThreadScheduler]];
    RAC(self.nickNameLabel, text) = [RACObserve([XPLoginModel singleton], signIn) flattenMap:^RACStream *(id value) {
        return [RACSignal if:[RACSignal return:@([XPLoginModel singleton].signIn)] then:[RACSignal return:[XPLoginModel singleton].userName?[[XPLoginModel singleton].userPhone stringByAppendingFormat:@"\n%@",[XPLoginModel singleton].userName]:[XPLoginModel singleton].userPhone] else:[RACSignal return:@"立即登录"]];
    }];
    
    [self whenTapped:^{
        @strongify(self);
        [self contentTaped];
    }];
    [self.avatarImageView whenTapped:^{
        @strongify(self);
        [self avatarTaped];
    }];
}

#pragma mark - Delegate
#pragma mark - XPAlertController Delegate
- (void)alertController:(XPAlertController *)alertController didSelectRow:(NSInteger)row
{
    [self pickImageIfTakeNew:0 == row ? YES : NO];
}

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

#pragma mark - Public Interface
- (void)bindViewModel:(XPMeViewModel *)viewModel
{
    NSParameterAssert([viewModel isKindOfClass:[XPMeViewModel class]]);
    self.viewModel = viewModel;
}

#pragma mark - Private Methods
- (void)contentTaped
{
#if FILTER_UNSIGNIN
    {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Profile" bundle:nil];
        UIViewController *viewController = [sb instantiateInitialViewController];
        [[self belongViewController].navigationController pushViewController:viewController animated:YES];
        return;
    }
#endif
    if(![XPLoginModel singleton].signIn) { // 未登录
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        UIViewController *viewController = [sb instantiateInitialViewController];
        [[self belongViewController] presentViewController:viewController animated:YES completion:nil];
    } else {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Profile" bundle:nil];
        UIViewController *viewController = [sb instantiateInitialViewController];
        [(XPBaseViewController *)[self belongViewController] pushViewController:viewController];
    }
}

- (void)avatarTaped
{
    if(![XPLoginModel singleton].signIn) { // 未登录
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        UIViewController *viewController = [sb instantiateInitialViewController];
        [[self belongViewController] presentViewController:viewController animated:YES completion:nil];
    } else {
        self.alertController = [[XPAlertController alloc] initWithActivity:@[@"拍照", @"从手机相册选择"] title:nil];
        self.alertController.delegate = self;
        [self.alertController show];
    }
    
}

- (void)processAddedImage:(UIImage *)image
{
    self.avatarImageView.image = image;
    self.viewModel.avatarImage = image;
    [self.viewModel.submitCommand execute:nil];
}


@end
