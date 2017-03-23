//
//  XPGiftTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 1/21/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "NSObject+XPShareSDK.h"
#import "NSString+XPRemoteImage.h"
#import "UILabel+XPAttribute.h"
#import "XPGiftModel.h"
#import "XPGiftTableViewCell.h"
#import "XPLoginModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XPKit/XPKit.h>
#import "XPToast.h"

@interface XPGiftTableViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *logoImageView;
@property (nonatomic, weak) IBOutlet UIImageView *activityEndImageView;
@property (nonatomic, weak) IBOutlet UILabel *activityTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;



@end

@implementation XPGiftTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    RAC(self.logoImageView, image) = [[RACObserve(self, model.prizesImage) flattenMap:^RACStream *(id value) {
        return value ? [value rac_remote_image] : [RACSignal return :nil];
    }] deliverOn:[RACScheduler mainThreadScheduler]];
    
    RAC(self.activityEndImageView, hidden) = [RACObserve(self, model.isEnd) map:^id (NSNumber *value) {
        return [value boolValue] ? @NO : @YES;
    }];
    
    @weakify(self);
    [[[RACObserve(self, model.groupName) ignore:nil] zipWith:[RACObserve(self, model.activeTitle) ignore:nil]] subscribeNext:^(RACTuple *x) {
        @strongify(self);
        RACTupleUnpack(NSString *groupName, NSString *activeName) = x;
        [self.activityTitleLabel xp_attributed:@[[groupName stringByAppendingString:@"  "], activeName] colorArray:@[[UIColor colorWithRed:0.627 green:0.176 blue:0.169 alpha:1.000], [UIColor blackColor]] fontArray:@[[UIFont systemFontOfSize:12], [UIFont systemFontOfSize:12]]];
    }];
    
    RAC(self.nameLabel, text) = [[RACObserve(self, model.prizesName) ignore:nil] map:^id (id value) {
        return [@"奖品名称：" stringByAppendingString:value];
    }];
    RAC(self.dateLabel, text) = [[RACObserve(self, model.sendPrizesTime) ignore:nil] map:^id (id value) {
        return [@"发起时间：" stringByAppendingString:value];
    }];
    
  }

#pragma mark - Delegate

#pragma mark - Event Responds

#pragma mark - Public Interface
- (void)bindModel:(XPGiftModel *)model
{
    NSParameterAssert([model isKindOfClass:[XPGiftModel class]]);
    //    self.logoImageView.image = nil;
    self.model = model;
}



#pragma mark - Getter & Setter

@end
