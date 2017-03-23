//
//  XPMainGroupShakeTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 1/24/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "NSString+XPRemoteImage.h"
#import "XPMainGroupShakeModel.h"
#import "XPMainGroupShakeTableViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XPKit/XPKit.h>

@interface XPMainGroupShakeTableViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *logoImageView;
@property (nonatomic, weak) IBOutlet UILabel *nickLabel;
@property (nonatomic, weak) IBOutlet UILabel *prizeNameLabel;
@property (nonatomic, strong) XPMainGroupShakePeopleModel *model;

@end

@implementation XPMainGroupShakeTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    RAC(self.logoImageView, image) = [[RACObserve(self, model.imageUrl) flattenMap:^RACStream *(id value) {
        return value ? [value rac_remote_image] : [RACSignal return :nil];
    }] deliverOn:[RACScheduler mainThreadScheduler]];
    
    RAC(self.nickLabel, text) = RACObserve(self, model.userName);
    RAC(self.prizeNameLabel, text) = RACObserve(self, model.prizesName);
}

#pragma mark - Delegate

#pragma mark - Event Responds

#pragma mark - Public Interface
- (void)bindModel:(XPMainGroupShakePeopleModel *)model
{
    NSParameterAssert([model isKindOfClass:[XPMainGroupShakePeopleModel class]]);
    self.model = model;
}

#pragma mark - Private Methods

#pragma mark - Getter & Setter

@end
