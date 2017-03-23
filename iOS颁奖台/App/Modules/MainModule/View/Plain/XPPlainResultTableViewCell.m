//
//  XPPlainResultTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 1/25/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPMainPlainShakeModel.h"
#import "XPPlainResultTableViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XPKit/XPKit.h>

@interface XPPlainResultTableViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UILabel *phoneLabel;
@property (nonatomic, strong) XPMainPlainShakeResultPeopleModel *model;

@end

@implementation XPPlainResultTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    RAC(self.dateLabel, text) = RACObserve(self, model.winningDate);
    RAC(self.phoneLabel, text) = RACObserve(self, model.winners);
}

#pragma mark - Delegate

#pragma mark - Event Responds

#pragma mark - Public Interface
- (void)bindModel:(XPMainPlainShakeResultPeopleModel *)model
{
    NSParameterAssert([model isKindOfClass:[XPMainPlainShakeResultPeopleModel class]]);
    self.model = model;
}

#pragma mark - Private Methods

#pragma mark - Getter & Setter

@end
