//
//  XPGiftCreateNickTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 1/23/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "NSString+XPPrivacyPhone.h"
#import "XPGiftCreateNickTableViewCell.h"
#import "XPGiftViewModel.h"
#import "XPLoginModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XPKit/XPKit.h>

@interface XPGiftCreateNickTableViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *nickLabel;
@property (nonatomic, strong) XPGiftViewModel *viewModel;

@end

@implementation XPGiftCreateNickTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    self.nickLabel.text = [NSString stringWithFormat:@"%@", [XPLoginModel singleton].userName ? : [[XPLoginModel singleton].userPhone privacyPhone]];
}

#pragma mark - Delegate

#pragma mark - Event Responds

#pragma mark - Public Interface
- (void)bindViewModel:(XPGiftViewModel *)viewModel
{
    NSParameterAssert([viewModel isKindOfClass:[XPGiftViewModel class]]);
    self.viewModel = viewModel;
    self.viewModel.createUserNick = self.nickLabel.text;
}

#pragma mark - Private Methods

#pragma mark - Getter & Setter

@end
