//
//  XPAwardDeliveryAddressTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 1/22/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPAddressModel.h"
#import "XPAwardDeliveryAddressTableViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XPKit/XPKit.h>

@interface XPAwardDeliveryAddressTableViewCell ()

@property (nonatomic, strong) XPAddressModel *model;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *phoneLabel;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;

@end

@implementation XPAwardDeliveryAddressTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    RAC(self.nameLabel, text) = RACObserve(self, model.name);
    RAC(self.phoneLabel, text) = RACObserve(self, model.phone);
    RAC(self.addressLabel, text) = RACObserve(self, model.addressInfo);
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
