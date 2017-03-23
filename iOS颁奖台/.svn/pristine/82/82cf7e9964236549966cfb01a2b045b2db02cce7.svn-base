//
//  XPGiftCreateBottomView.m
//  XPApp
//
//  Created by xinpinghuang on 1/23/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import "NSString+XPPrivacyPhone.h"
#import "XPBaseViewController.h"
#import "XPGiftCreateBottomView.h"
#import "XPGiftViewModel.h"
#import "XPLoginModel.h"

@interface XPGiftCreateBottomView ()

@property (nonatomic, weak) IBOutlet UIButton *submitButton;
@property (nonatomic, weak) IBOutlet UIImageView *checkmarkImageView;
@property (nonatomic, weak) IBOutlet UILabel *checkmarkLabel;
@property (nonatomic, strong) XPGiftViewModel *viewModel;

@end

@implementation XPGiftCreateBottomView

#pragma mark - LifeCircle
- (void)awakeFromNib
{
    @weakify(self);
    [[self.submitButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [(XPBaseViewController *)[self.superview belongViewController] pushViewController:[[(XPBaseViewController *)[self belongViewController] instantiateViewControllerWithStoryboardName:@"Gift" identifier:@"GroupList"] tap:^(XPBaseViewController *x) {
            @strongify(self);
            [x bindViewModel:self.viewModel];
        }]];
    }];
}

#pragma mark - Public Interface
- (void)bindViewModel:(XPGiftViewModel *)viewModel
{
    NSParameterAssert([viewModel isKindOfClass:[XPGiftViewModel class]]);
    self.viewModel = viewModel;
    
    RAC(self.checkmarkLabel, hidden) = [self.viewModel.createNextValidSignal not];
    RAC(self.checkmarkImageView, hidden) = [self.viewModel.createNextValidSignal not];
    self.viewModel.createUserNick = [NSString stringWithFormat:@"%@", [XPLoginModel singleton].userName ? : [[XPLoginModel singleton].userPhone privacyPhone]];
    RAC(self.submitButton, enabled) = self.viewModel.createNextValidSignal;
}

@end
