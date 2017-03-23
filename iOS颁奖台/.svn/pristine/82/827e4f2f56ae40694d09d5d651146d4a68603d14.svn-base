//
//  XPAddressAddPhoneTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 1/11/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPAddressAddPhoneTableViewCell.h"
#import "XPAddressModel.h"
#import "XPAddressViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XPKit/XPKit.h>

@interface XPAddressAddPhoneTableViewCell ()

@property (nonatomic, strong) XPAddressModel *model;
@property (nonatomic, strong) XPAddressViewModel *viewModel;
@property (nonatomic, weak) IBOutlet UITextField *phoneTextField;

@end

@implementation XPAddressAddPhoneTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    RAC(self, viewModel.phone) = self.phoneTextField.rac_textSignal;
    RAC(self, phoneTextField.text) = RACObserve(self, model.phone);
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
