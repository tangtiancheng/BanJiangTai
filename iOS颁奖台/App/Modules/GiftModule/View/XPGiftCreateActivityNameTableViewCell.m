//
//  XPGiftCreateActivityNameTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 1/23/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "NSString+XPPrivacyPhone.h"
#import "UITextField+LimitLength.h"
#import "XPGiftCreateActivityNameTableViewCell.h"
#import "XPGiftViewModel.h"
#import "XPLoginModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XPKit/XPKit.h>
#import <XPRACSignal/UITextField+XPLimitLength.h>

@interface XPGiftCreateActivityNameTableViewCell ()

@property (nonatomic, weak) IBOutlet UITextField *nameTextField;
@property (nonatomic, strong) XPGiftViewModel *viewModel;

@end

@implementation XPGiftCreateActivityNameTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    self.nameTextField.placeholder = [NSString stringWithFormat:@"[%@]发奖啦，快来颁奖台领奖~", [XPLoginModel singleton].userName ? : [[XPLoginModel singleton].userPhone privacyPhone]];
    //    RAC(self, viewModel.activityName) = [self.nameTextField rac_textSignalWithLimitLength:18];
    @weakify(self);
    [self.nameTextField xp_limitTextLength:19 block:^(NSString *text) {
        @strongify(self);
        self.viewModel.activityName = text;
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:XPGiftCreateFinishedNotification object:nil] subscribeNext:^(id x) {
        @strongify(self);
        [self.nameTextField setText:@""];
        [self.nameTextField sendActionsForControlEvents:UIControlEventEditingDidEnd];
    }];
}

#pragma mark - Delegate

#pragma mark - Event Responds

#pragma mark - Public Interface
- (void)bindViewModel:(XPGiftViewModel *)viewModel
{
    NSParameterAssert([viewModel isKindOfClass:[XPGiftViewModel class]]);
    self.viewModel = viewModel;
}

#pragma mark - Private Methods

#pragma mark - Getter & Setter

@end
