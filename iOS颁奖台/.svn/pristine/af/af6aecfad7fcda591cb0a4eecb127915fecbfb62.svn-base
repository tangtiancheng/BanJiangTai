//
//  XPAddressTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 1/21/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPAddressModel.h"
#import "XPAddressTableViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XPKit/XPKit.h>

@interface XPAddressTableViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *selectedImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *phoneLabel;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;
@property (nonatomic, strong) XPAddressModel *model;

@end

@implementation XPAddressTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    RAC(self.nameLabel, text) = RACObserve(self, model.name);
    RAC(self.phoneLabel, text) = RACObserve(self, model.phone);
    RAC(self.addressLabel, text) = RACObserve(self, model.addressInfo);
    RAC(self.selectedImageView, highlighted) = [RACObserve(self, model.isDefault) map:^id (NSNumber *value) {
        return [value boolValue] ? @(YES) : @(NO);
    }];
}

#pragma mark - Delegate

#pragma mark - Event Responds

#pragma mark - Public Interface
- (void)bindModel:(XPAddressModel *)model
{
    NSParameterAssert([model isKindOfClass:[XPAddressModel class]]);
    self.model = model;
}

#pragma mark - Private Methods

#pragma mark - Getter & Setter

@end
