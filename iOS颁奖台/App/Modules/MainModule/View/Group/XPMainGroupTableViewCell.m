//
//  XPMainGroupTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 1/23/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "NSString+XPRemoteImage.h"
#import "UILabel+XPAttribute.h"
#import "XPMainGroupModel.h"
#import "XPMainGroupTableViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XPKit/XPKit.h>

@interface XPMainGroupTableViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *logoImageView;;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *prizeNameLabel;;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;;
@property (nonatomic, strong) XPMainGroupItemModel *model;

@end

@implementation XPMainGroupTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    RAC(self.logoImageView, image) = [[RACObserve(self, model.imageUrl) flattenMap:^RACStream *(id value) {
        return value ? [value rac_remote_image] : [RACSignal return :nil];
    }] deliverOn:[RACScheduler mainThreadScheduler]];
    
    @weakify(self);
    [[[RACObserve(self, model.groupName) ignore:nil] zipWith:[RACObserve(self, model.activityName) ignore:nil]] subscribeNext:^(RACTuple *x) {
        @strongify(self);
        RACTupleUnpack(NSString *groupName, NSString *activityName) = x;
        [self.titleLabel xp_attributed:@[[groupName stringByAppendingString:@"  "], activityName] colorArray:@[[UIColor colorWithRed:0.627 green:0.176 blue:0.169 alpha:1.000], [UIColor blackColor]] fontArray:@[[UIFont systemFontOfSize:12], [UIFont systemFontOfSize:12]]];
    }];
    
    RAC(self.prizeNameLabel, text) = [[RACObserve(self, model.prizeName) ignore:nil] map:^id (id value) {
        return [@"奖品名称：" stringByAppendingString:value];
    }];
    RAC(self.dateLabel, text) = [[RACObserve(self, model) ignore:nil] map:^id (XPMainGroupItemModel *groupModel) {
        if([groupModel.startDate isEqualToString:groupModel.endDate]) {
            return [NSString stringWithFormat:@"活动时间：%@ %@-%@", groupModel.startDate, groupModel.startTime, groupModel.endTime];
        } else {
            return [NSString stringWithFormat:@"活动时间：%@ %@-%@ %@", groupModel.startDate, groupModel.startTime, groupModel.endDate, groupModel.endTime];
        }
    }];
}

#pragma mark - Delegate

#pragma mark - Event Responds

#pragma mark - Public Interface
- (void)bindModel:(XPMainGroupItemModel *)model
{
    NSParameterAssert([model isKindOfClass:[XPMainGroupItemModel class]]);
    self.model = model;
}

#pragma mark - Private Methods

#pragma mark - Getter & Setter

@end
