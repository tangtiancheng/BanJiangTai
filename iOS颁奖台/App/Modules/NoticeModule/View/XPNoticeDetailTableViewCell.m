//
//  XPNoticeDetailTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 1/22/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPNoticeDetailModel.h"
#import "XPNoticeDetailTableViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XPKit/XPKit.h>

@interface XPNoticeDetailTableViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UILabel *phoneLabel;
@property (nonatomic, strong) XPNoticeDetailItemModel *model;

@end

@implementation XPNoticeDetailTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    RAC(self.dateLabel, text) = RACObserve(self, model.winningDate);
    RAC(self.phoneLabel, text) = RACObserve(self, model.winners);
}

#pragma mark - Delegate

#pragma mark - Event Responds

#pragma mark - Public Interface
- (void)bindModel:(XPNoticeDetailItemModel *)model
{
    NSParameterAssert([model isKindOfClass:[XPNoticeDetailItemModel class]]);
    self.model = model;
}

#pragma mark - Private Methods

#pragma mark - Getter & Setter

@end
