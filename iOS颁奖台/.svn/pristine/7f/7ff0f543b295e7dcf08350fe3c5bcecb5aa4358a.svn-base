//
//  XPAddressAddDefaultTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 1/11/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPAddressAddDefaultTableViewCell.h"
#import "XPAddressModel.h"
#import "XPAddressViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XPKit/XPKit.h>

@interface XPAddressAddDefaultTableViewCell ()

@property (nonatomic, strong) XPAddressModel *model;
@property (nonatomic, strong) XPAddressViewModel *viewModel;
@property (nonatomic, weak) IBOutlet UISwitch *defaultSwitch;

@end

@implementation XPAddressAddDefaultTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    RAC(self, viewModel.defaultAddress) = [[self.defaultSwitch rac_signalForControlEvents:UIControlEventValueChanged] map:^id (UISwitch *value) {
        return @([value isOn]);
    }];
    RAC(self.defaultSwitch, on) = [RACObserve(self, model.isDefault) map:^id (NSNumber *value) {
        return [value boolValue] ? @(YES) : @(NO);
    }];
    
    RAC(self.defaultSwitch, enabled) = [RACObserve(self, model.isDefault) map:^id (NSNumber *value) {
        return [value boolValue] ? @(NO) : @(YES);
    }];
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
