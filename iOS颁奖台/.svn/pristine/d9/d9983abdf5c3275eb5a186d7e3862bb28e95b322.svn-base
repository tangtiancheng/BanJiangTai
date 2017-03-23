//
//  XPActivityTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 12/30/15.
//  Copyright 2015 ShareMerge. All rights reserved.
//

#import "NSString+XPRemoteImage.h"
#import "XPActivityModel.h"
#import "XPActivityTableViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XPKit/XPKit.h>

@interface XPActivityTableViewCell ()

@property (nonatomic, strong) XPActivityModel *model;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation XPActivityTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    RAC(self.typeLabel, text) = [[RACObserve(self, model.type) ignore:nil] map:^id (id value) {
//        return [value isEqualToString:@"E"] ? @"摇奖" : @"未识别";
        NSString *type = [[NSString alloc]init];
         if ([value isEqualToString:@"E" ]) {
            type= @"摇奖";
        }else if ([value isEqualToString:@"G"]){
            type=  @"刮刮乐";
        }else if ([value isEqualToString:@"L"]){
            type= @"抽奖";
        }
        return type;
    }];
    RAC(self.statusLabel, text) = [[RACObserve(self, model.activeStatus) ignore:nil] map:^id (id value) {
        return [value boolValue] ? @"已结束" : @"正在进行中";
    }];
    RAC(self.statusLabel, textColor) = [[RACObserve(self, model.activeStatus) ignore:nil] map:^id (id value) {
        return [value boolValue] ? [UIColor colorWithWhite:0.376 alpha:1.000] : [UIColor colorWithRed:0.784 green:0.259 blue:0.251 alpha:1.000];
    }];
    RAC(self.titleLabel, text) = [RACObserve(self, model.title) ignore:nil];
    RAC(self.timeLabel, text) = [RACObserve(self, model.joinTime) ignore:nil];
    RAC(self.logoImageView, image) = [[RACObserve(self, model.imageUrl) flattenMap:^RACStream *(id value) {
        return value ? [value rac_remote_image] : [RACSignal return :nil];
    }] deliverOn:[RACScheduler mainThreadScheduler]];
}

#pragma mark - Delegate

#pragma mark - Event Responds

#pragma mark - Public Interface
- (void)bindModel:(XPActivityModel *)model
{
    NSParameterAssert([model isKindOfClass:[XPActivityModel class]]);
    self.model = model;
}

#pragma mark - Private Methods

#pragma mark - Getter & Setter

@end
