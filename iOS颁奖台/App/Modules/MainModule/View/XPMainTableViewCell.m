//
//  XPMainTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 12/28/15.
//  Copyright © 2015 ShareMerge. All rights reserved.
//

#import "XPMainModel.h"
#import "XPMainTableViewCell.h"
#import "NSString+XPRemoteImage.h"
#import "UILabel+XPAttribute.h"

@interface XPMainTableViewCell ()

@property (nonatomic, strong) XPMainModel *model;
@property (nonatomic, weak) IBOutlet UIImageView *logoImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *sponsorLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@end

@implementation XPMainTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    RAC(self.logoImageView, image) = [[RACObserve(self, model.imageUrl) flattenMap:^RACStream *(id value) {
        return value ? [value rac_remote_image] : [RACSignal return :nil];
    }] deliverOn:[RACScheduler mainThreadScheduler]];
        RAC(self.titleLabel,text) = RACObserve(self, model.title);
//    [[[RACObserve(self, model.sponsor) ignore:nil] zipWith:[RACObserve(self, model.title) ignore:nil]] subscribeNext:^(RACTuple *x) {
//        RACTupleUnpack(NSString *sponsor, NSString *title) = x;
//        [self.titleLabel xp_attributed:@[[sponsor stringByAppendingString:@"  "], title] colorArray:@[[UIColor colorWithRed:0.627 green:0.176 blue:0.169 alpha:1.000], [UIColor blackColor]] fontArray:@[[UIFont systemFontOfSize:12], [UIFont systemFontOfSize:12]]];
//    }];
    
    RAC(self.typeLabel,text) = [[RACObserve(self,model.lotteryType)ignore:nil]map:^id(id value) {
        return [@""stringByAppendingString:value];
    }];
    RAC(self.sponsorLabel, text) = [[RACObserve(self, model.sponsor) ignore:nil] map:^id(id value) {
        return [@"主办方：" stringByAppendingString:value];
    }];
    RAC(self.dateLabel, text) = [[RACObserve(self, model) ignore:nil] flattenMap:^RACStream *(XPMainModel *podiumModel) {
        NSString *changeEndStr = [[NSString alloc]init];
        changeEndStr = [podiumModel.endDate substringFromIndex:5];
        return [RACSignal if:[RACSignal return:@(podiumModel.noticeTag)] then:[[RACSignal return:@"group"] map:^id(id value) {
            if ([podiumModel.startDate isEqualToString:podiumModel.endDate]) {
                return [NSString stringWithFormat:@"活动时间：%@ %@-%@",podiumModel.startDate,podiumModel.startTime,podiumModel.endTime];
            } else {
                return [NSString stringWithFormat:@"活动时间：%@-%@ %@-%@",podiumModel.startDate,changeEndStr,podiumModel.startTime,podiumModel.endTime];
            }
        }] else:[[RACSignal return:@"plain"] map:^id(id value) {
            if ([podiumModel.startDate isEqualToString:podiumModel.endDate]) {
                return [NSString stringWithFormat:@"活动时间：%@ %@-%@",podiumModel.startDate,podiumModel.startTime,podiumModel.endTime];
            } else {
                return [NSString stringWithFormat:@"活动时间：%@-%@ %@-%@",podiumModel.startDate,changeEndStr,podiumModel.startTime,podiumModel.endTime];
            }
        }]];
    }];
}

#pragma mark - Public Interface
- (void)bindModel:(XPMainModel *)model
{
    NSParameterAssert([model isKindOfClass:[XPMainModel class]]);
    self.model = model;
}

#pragma mark - Getter && Setter

@end
