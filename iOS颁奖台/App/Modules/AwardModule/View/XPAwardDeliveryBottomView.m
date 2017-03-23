//
//  XPAwardDeliveryBottomView.m
//  XPApp
//
//  Created by xinpinghuang on 1/22/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import "XPAwardDeliveryBottomView.h"
#import "XPAwardViewModel.h"

@interface XPAwardDeliveryBottomView ()

@property (nonatomic, weak) IBOutlet UIButton *submitButton;
@property (nonatomic, weak) IBOutlet UIImageView *checkmarkImageView;
@property (nonatomic, weak) IBOutlet UILabel *checkmarkLabel;
@property (nonatomic, strong) XPAwardViewModel *viewModel;
@end

@implementation XPAwardDeliveryBottomView

#pragma mark - Life Circle
- (void)awakeFromNib
{
}

#pragma mark - Public Interface
- (void)bindViewModel:(XPAwardViewModel *)viewModel
{
    NSParameterAssert([viewModel isKindOfClass:[XPAwardViewModel class]]);
    self.viewModel = viewModel;
    
    RAC(self.checkmarkLabel, hidden) = [self.viewModel.deliveryValidSignal not];
    RAC(self.checkmarkImageView, hidden) = [self.viewModel.deliveryValidSignal not];
    self.submitButton.rac_command = self.viewModel.deliveryCommand;
}

@end
