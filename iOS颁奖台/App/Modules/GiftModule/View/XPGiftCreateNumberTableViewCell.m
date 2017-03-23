//
//  XPGiftCreateNumberTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 1/23/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "UITextField+LimitLength.h"
#import "XPGiftCreateNumberTableViewCell.h"
#import "XPGiftViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XPKit/XPKit.h>

@interface XPGiftCreateNumberTableViewCell ()

@property (nonatomic, weak) IBOutlet UITextField *numberTextField;
@property (nonatomic, strong) XPGiftViewModel *viewModel;

@end

@implementation XPGiftCreateNumberTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    @weakify(self);
    [self.numberTextField xp_limitTextLength:3 block:^(NSString *text) {
        @strongify(self);
        self.viewModel.number = [text integerValue];
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:XPGiftCreateFinishedNotification object:nil] subscribeNext:^(id x) {
        @strongify(self);
        [self.numberTextField setText:@""];
        [self.numberTextField sendActionsForControlEvents:UIControlEventEditingDidEnd];
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
