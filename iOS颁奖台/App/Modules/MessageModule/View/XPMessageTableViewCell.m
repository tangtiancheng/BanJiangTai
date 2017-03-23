//
//  XPMessageTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 12/30/15.
//  Copyright 2015 ShareMerge. All rights reserved.
//

#import "XPMessageModel.h"
#import "XPMessageTableViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XPBadgeView/UIView+XPBadgeView.h>
#import <XPKit/XPKit.h>

@interface XPMessageTableViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *logoImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *contentLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) XPMessageModel *model;

@end

@implementation XPMessageTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    self.logoImageView.badge.frame = ccr(0, 0, 8, 8);
    self.logoImageView.badge.cornerRadius = 4;
    self.logoImageView.badge.horizontalAlignment = M13BadgeViewHorizontalAlignmentRight;
    self.logoImageView.badge.text = @"";
    self.logoImageView.badge.minimumWidth = 4;
    self.logoImageView.badge.maximumWidth = 4;
    
    self.logoImageView.backgroundColor = [UIColor clearColor];
    RAC(self.logoImageView, badge.hidden) = [RACObserve(self, model.messageRead) map:^id (id value) {
        return @([value boolValue]);
    }];
    RAC(self.titleLabel, text) = RACObserve(self, model.messageTitle);
    RAC(self.contentLabel, text) = RACObserve(self, model.messageContent);
    RAC(self.dateLabel, text) = RACObserve(self, model.time);
}

#pragma mark - Delegate

#pragma mark - Event Responds

#pragma mark - Public Interface
- (void)bindModel:(XPMessageModel *)model
{
    NSParameterAssert([model isKindOfClass:[XPMessageModel class]]);
    self.model = model;
}

#pragma mark - Private Methods

#pragma mark - Getter & Setter

@end
