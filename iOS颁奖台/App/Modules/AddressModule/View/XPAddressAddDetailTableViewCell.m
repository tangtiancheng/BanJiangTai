//
//  XPAddressAddDetailTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 1/11/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPAddressAddDetailTableViewCell.h"
#import "XPAddressModel.h"
#import "XPAddressViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XPKit/XPKit.h>

@interface XPAddressAddDetailTableViewCell ()

@property (nonatomic, strong) XPAddressModel *model;
@property (nonatomic, strong) XPAddressViewModel *viewModel;
@property (nonatomic, weak) IBOutlet UITextField *detailTextField;

@end

@implementation XPAddressAddDetailTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    RAC(self, viewModel.addressDetail) = self.detailTextField.rac_textSignal;
    
    RAC(self, detailTextField.text) = RACObserve(self, model.addressInfo);
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
