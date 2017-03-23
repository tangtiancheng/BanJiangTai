//
//  XPNoticeTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 12/28/15.
//  Copyright © 2015 ShareMerge. All rights reserved.
//

#import "NSString+XPRemoteImage.h"
#import "XPNoticeModel.h"
#import "XPNoticeTableViewCell.h"
#import "UILabel+XPAttribute.h"

@interface XPNoticeTableViewCell ()

@property (nonatomic, strong) XPNoticeModel *model;
@property (nonatomic, weak) IBOutlet UIImageView *logoImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *sponsorLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@end

@implementation XPNoticeTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    
    RAC(self.logoImageView, image) = [[RACObserve(self, model.imageUrl) flattenMap:^RACStream *(id value) {
        return value ? [value rac_remote_image] : [RACSignal return :nil];
    }] deliverOn:[RACScheduler mainThreadScheduler]];
    RAC(self.titleLabel,text) = RACObserve(self, model.title);
//    [[[RACObserve(self, model.title) ignore:nil] zipWith:[RACObserve(self, model.title) ignore:nil]] subscribeNext:^(RACTuple *x) {
//        RACTupleUnpack(NSString *title, NSString *content) = x;
//        [self.titleLabel xp_attributed:@[[title stringByAppendingString:@"  "], content] colorArray:@[[UIColor colorWithRed:0.627 green:0.176 blue:0.169 alpha:1.000], [UIColor blackColor]] fontArray:@[[UIFont systemFontOfSize:12], [UIFont systemFontOfSize:12]]];
//    }];
    RAC(self.typeLabel,text) = [[RACObserve(self,model.lotteryType)ignore:nil]map:^id(id value) {
        return [@""stringByAppendingString:value];
    }];
    RAC(self.sponsorLabel, text) = [[RACObserve(self, model.sponsor) ignore:nil] map:^id(id value) {
        return [@"主办方：" stringByAppendingString:value];
    }];
    RAC(self.dateLabel, text) = [[RACObserve(self, model) ignore:nil] flattenMap:^RACStream *(XPNoticeModel *noticeModel) {
        NSString *changeEndStr = [[NSString alloc]init];
        changeEndStr = [noticeModel.endDate substringFromIndex:5];
        NSString *dateStarStr = [[NSString alloc]init];
        dateStarStr = [noticeModel.startTime substringToIndex:5];
        NSString *dateEndStr = [[NSString alloc]init];
        dateEndStr = [noticeModel.endTime substringToIndex:5];
        return [RACSignal if:[RACSignal return:@(noticeModel.noticeTag)] then:[[RACSignal return:@"group"] map:^id(id value) {
            if ([noticeModel.startDate isEqualToString:noticeModel.endDate]) {
                return [NSString stringWithFormat:@"活动时间：%@ %@-%@",noticeModel.startDate,noticeModel.startTime,noticeModel.endTime];
            } else {
                return [NSString stringWithFormat:@"活动时间：%@-%@ %@-%@",noticeModel.startDate,changeEndStr,dateStarStr,dateEndStr];
            }
        }] else:[[RACSignal return:@"plain"] map:^id(id value) {
            if ([noticeModel.startDate isEqualToString:noticeModel.endDate]) {
                return [NSString stringWithFormat:@"活动时间：%@ %@-%@",noticeModel.startDate,dateStarStr,dateEndStr];
            } else {
                return [NSString stringWithFormat:@"活动时间：%@-%@ %@-%@",noticeModel.startDate,changeEndStr,dateStarStr,dateEndStr];
            }
        }]];
    }];
}

#pragma mark - Delegate

#pragma mark - Event Responds

#pragma mark - Public Interface
- (void)bindModel:(XPNoticeModel *)model
{
    NSParameterAssert([model isKindOfClass:[XPNoticeModel class]]);
    self.model = model;
}

#pragma mark - Private Methods

#pragma mark - Getter & Setter

@end
