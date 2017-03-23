//
//  XPGiftCreateUserTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 1/23/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPGiftCreateUserTableViewCell.h"
#import "XPGiftViewModel.h"
#import "XPLoginModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XPKit/XPKit.h>

@interface XPGiftCreateUserTableViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *phoneLabel;
@property (nonatomic, strong) XPGiftViewModel *viewModel;

@end

@implementation XPGiftCreateUserTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    RAC(self.phoneLabel, text) = RACObserve([XPLoginModel singleton], userPhone);
}

#pragma mark - Delegate

#pragma mark - Event Responds

#pragma mark - Public Interface
- (void)bindViewModel:(XPGiftViewModel *)viewModel
{
    NSParameterAssert([viewModel isKindOfClass:[XPGiftViewModel class]]);
    self.viewModel = viewModel;
    self.viewModel.createUserPhone = self.phoneLabel.text;
}

#pragma mark - Private Methods

#pragma mark - Getter & Setter

@end
