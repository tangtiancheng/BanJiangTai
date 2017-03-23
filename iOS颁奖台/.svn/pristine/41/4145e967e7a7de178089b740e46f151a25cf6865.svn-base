//
//  XPAddressAddRecipientTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 1/11/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPAddressAddRecipientTableViewCell.h"
#import "XPAddressModel.h"
#import "XPAddressViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XPKit/XPKit.h>

@interface XPAddressAddRecipientTableViewCell ()

@property (nonatomic, strong) XPAddressModel *model;
@property (nonatomic, strong) XPAddressViewModel *viewModel;
@property (nonatomic, weak) IBOutlet UITextField *recipientTextField;

@end

@implementation XPAddressAddRecipientTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    RAC(self, viewModel.recipient) = self.recipientTextField.rac_textSignal;
    RAC(self.recipientTextField, text) = RACObserve(self, model.name);
}

#pragma mark - Delegate

#pragma mark - Event Responds

#pragma mark - Public Interface
- (void)bindViewModel:(XPAddressViewModel *)viewModel
{
    NSParameterAssert([viewModel isKindOfClass:[XPAddressViewModel class]]);
    self.viewModel = viewModel;
}

- (void)bindModel:(XPAddressModel *)model
{
    NSParameterAssert([model isKindOfClass:[XPAddressModel class]]);
    self.model = model;
}

#pragma mark - Private Methods

#pragma mark - Getter & Setter

@end
