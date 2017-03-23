//
//  XPGiftCreateTitleTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 1/23/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "UITextField+LimitLength.h"
#import "XPGiftCreateTitleTableViewCell.h"
#import "XPGiftViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XPKit/XPKit.h>

@interface XPGiftCreateTitleTableViewCell ()

@property (nonatomic, weak) IBOutlet UITextField *titleTextField;
@property (nonatomic, strong) XPGiftViewModel *viewModel;

@end

@implementation XPGiftCreateTitleTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    //    RAC(self, viewModel.giftName) = [self.titleTextField rac_textSignalWithLimitLength:12];
    @weakify(self);
    [self.titleTextField xp_limitTextLength:12 block:^(NSString *text) {
        @strongify(self);
        self.viewModel.giftName = text;
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:XPGiftCreateFinishedNotification object:nil] subscribeNext:^(id x) {
        @strongify(self);
        [self.titleTextField setText:@""];
        [self.titleTextField sendActionsForControlEvents:UIControlEventEditingDidEnd];
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
