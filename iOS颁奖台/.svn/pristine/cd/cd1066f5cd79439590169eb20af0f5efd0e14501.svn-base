//
//  XPAwardAcquireSaveTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 1/22/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPAddressViewModel.h"
#import "XPAwardAcquireSaveTableViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XPKit/XPKit.h>

@interface XPAwardAcquireSaveTableViewCell ()

@property (nonatomic, weak) IBOutlet UIButton *saveButton;
@property (nonatomic, strong) XPAddressViewModel *viewModel;

@end

@implementation XPAwardAcquireSaveTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
}

#pragma mark - Delegate

#pragma mark - Event Responds

#pragma mark - Public Interface
- (void)bindViewModel:(XPAddressViewModel *)viewModel
{
    NSParameterAssert([viewModel isKindOfClass:[XPAddressViewModel class]]);
    self.viewModel = viewModel;
    self.saveButton.rac_command = viewModel.createCommand;
}

#pragma mark - Private Methods

#pragma mark - Getter & Setter

@end
