//
//  XPAwardUseTicketTableViewCell.m
//  XPApp
//
//  Created by 唐天成 on 16/3/28.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "XPAwardUseTicketTableViewCell.h"

#import "NSString+XPRemoteImage.h"
#import "XPAwardModel.h"
#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XPKit/XPKit.h>

@interface XPAwardUseTicketTableViewCell()
@property (nonatomic, strong) XPAwardItemModel *model;

//商家logo和商家名
@property (weak, nonatomic) IBOutlet UILabel *businessName;
@property (weak, nonatomic) IBOutlet UIImageView *businessImage;
//奖品图片
@property (weak, nonatomic) IBOutlet UIImageView *prizeImageView;
//优惠券编码
@property (weak, nonatomic) IBOutlet UILabel *codeingLabel;
//活动名称
@property (weak, nonatomic) IBOutlet UILabel *activityNameLabel;
//有效期
@property (weak, nonatomic) IBOutlet UILabel *startTimeAndStopTimeLabel;


@end 

@implementation XPAwardUseTicketTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    [self setType:Award_Default];
    self.prizeImageView.layer.borderWidth=2;
    self.prizeImageView.layer.borderColor=[UIColor colorWithRed:237.0/255 green:237.0/255 blue:237.0 alpha:1.0].CGColor;
    @weakify(self)
    [[RACObserve(self, model.sponsor) ignore:nil]subscribeNext:^(NSString* x) {
        [self.businessName setText:[NSString stringWithFormat:@"奖品由%@提供",x]];
    }];
    [[[[RACObserve(self,  model.businessUrl) ignore:nil]flattenMap:^RACStream *(NSString* value) {
        return value ? [value rac_remote_image] : [RACSignal return :nil];
    }] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(UIImage* x) {
        [self.businessImage setImage:x];
    }];
    
    RAC(self.prizeImageView, image) = [[[RACObserve(self, model.imageUrl)ignore:nil] flattenMap:^RACStream *(id value) {
        return value ? [value rac_remote_image] : [RACSignal return :nil];
    }] deliverOn:[RACScheduler mainThreadScheduler]];
    [[RACObserve(self, model.lotteryId)ignore:nil]subscribeNext:^(id x) {
        
        self.codeingLabel.lineBreakMode = NSLineBreakByCharWrapping;
        self.codeingLabel.numberOfLines = 0;
        self.codeingLabel.text = [NSString stringWithFormat:@"优惠券编码:%@",x];
    }];
    
    RAC(self.activityNameLabel, text) = [RACObserve(self, model.title)ignore:nil];

    RAC(self.startTimeAndStopTimeLabel,text)=[RACSignal combineLatest:@[RACObserve(self, model.effectiveDateBegin), RACObserve(self, model.effectiveDateEnd)]  reduce:^id (NSString *startString, NSString *endString){
        @strongify(self);
        if (!self.model.effectiveDateEnd) {
            return [NSString stringWithFormat:@"永久有效"];
        }else{
            return [NSString stringWithFormat:@"%@至%@",startString,endString];
        }
    }] ;
}

#pragma mark - Delegate

#pragma mark - Event Responds

#pragma mark - Public Interface

#pragma mark - Private Methods
- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)bindModel:(XPAwardItemModel *)model
{
    NSParameterAssert([model isKindOfClass:[XPAwardItemModel class]]);
    self.model = model;
}


@end
