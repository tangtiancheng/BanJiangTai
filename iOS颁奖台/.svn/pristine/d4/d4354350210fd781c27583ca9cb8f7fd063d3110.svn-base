//
//  XPProfileNickTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 1/20/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "UITextField+LimitLength.h"
#import "XPLoginModel.h"
#import "XPProfileNickTableViewCell.h"
#import "XPProfileViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XPKit/XPKit.h>

@interface XPProfileNickTableViewCell ()

@property (nonatomic, weak) IBOutlet UITextField *nickTextField;
@property (nonatomic, strong) XPProfileViewModel *viewModel;

@end

@implementation XPProfileNickTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    RAC(self.nickTextField, text) = [[RACObserve([XPLoginModel singleton], userName) map:^id (id value) {
        return value;
    }] take:1];
    @weakify(self);
    [self.nickTextField xp_limitTextLength:10 block:^(NSString *text) {
        @strongify(self);
        self.viewModel.nick = text;
    }];
    
    //    RAC(self, viewModel.nick) = [self.nickTextField xp_rac_textSignalWithLimitLength:10];
}

#pragma mark - Delegate

#pragma mark - Event Responds

#pragma mark - Public Interface
- (void)bindViewModel:(XPProfileViewModel *)viewModel
{
    NSParameterAssert([viewModel isKindOfClass:[XPProfileViewModel class]]);
    self.viewModel = viewModel;
}

#pragma mark - Private Methods

#pragma mark - Getter & Setter

@end
