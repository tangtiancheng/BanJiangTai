//
//  XPAwardTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 12/31/15.
//  Copyright 2015 ShareMerge. All rights reserved.
//

#import "NSString+XPRemoteImage.h"
#import "XPAwardModel.h"
#import "XPAwardTableViewCell.h"
#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XPKit/XPKit.h>

@interface XPAwardTableViewCell ()

@property (nonatomic, strong) XPAwardItemModel *model;
@property (nonatomic, weak) IBOutlet UIImageView *logoImageView;
@property (nonatomic, weak) IBOutlet UILabel *sponsorLabel;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UIButton *getButton;/**< 领取 */
@property (nonatomic, weak) IBOutlet UIButton *receiveingButton;/**< 配送中 */
@property (nonatomic, weak) IBOutlet UIButton *doReceiveButton;/**< 未配送 */
@property (nonatomic, weak) IBOutlet UIButton *donationButton;/**< 转增 */
@property (nonatomic, weak) IBOutlet UIButton *useButton;/**< 使用 */

@end

@implementation XPAwardTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    [self setType:Award_Default];
    
    RAC(self.logoImageView, image) = [[RACObserve(self, model.imageUrl) flattenMap:^RACStream *(id value) {
        return value ? [value rac_remote_image] : [RACSignal return :nil];
    }] deliverOn:[RACScheduler mainThreadScheduler]];
    RAC(self.sponsorLabel, text) = RACObserve(self, model.sponsor);
    RAC(self.titleLabel, text) = RACObserve(self, model.title);
    RAC(self.nameLabel, text) = [[RACObserve(self, model.prizeName) ignore:nil] map:^id (id value) {
        return [@"奖品名称：" stringByAppendingString:value];
    }];
    RAC(self.dateLabel, text) = [[RACObserve(self, model.obtainTime) ignore:nil]
    map:^id(id value) {
        return [@"中奖时间：" stringByAppendingString:value];
    }];
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
    if(1 == self.model.isGroup) {  // 群组活动
        [self setType:Award_Default];
    } else {
        if([self.model.prizeStatus isEqualToString:@"N"]) { // 待领取
            [self setType:Award_Get];
        } else if([self.model.prizeStatus isEqualToString:@"W"]) { // 待配送
            [self setType:Award_Todo_Receive];
        } else if([self.model.prizeStatus isEqualToString:@"P"]) { // 配送中
            [self setType:Award_Receive];
        } else if([self.model.prizeStatus isEqualToString:@"S"]) { // 待使用
            [self setType:Award_Use];
        } else {
            [self setType:Award_Default];
        }
    }
}

#pragma mark - Getter & Setter
- (void)setType:(XPAwardType)type
{
    switch(type) {
        case Award_Get: {
            [self.receiveingButton setHidden:YES];
            [self.doReceiveButton setHidden:YES];
            [self.donationButton setHidden:YES];
            [self.useButton setHidden:YES];
            
            [self.getButton setHidden:NO];
            self.getButton.enabled = NO;
            
            @weakify(self);
            [self.getButton mas_remakeConstraints:^(MASConstraintMaker *make){
                @strongify(self);
                make.right.equalTo(self.mas_right).mas_offset(-19);
                make.bottom.equalTo(self.mas_bottom).mas_offset(-5);
                make.width.mas_equalTo(52);
                make.height.mas_equalTo(21);
            }];
        }
            break;
            
        case Award_Todo_Receive: {
            [self.getButton setHidden:YES];
            [self.receiveingButton setHidden:YES];
            [self.donationButton setHidden:YES];
            [self.useButton setHidden:YES];
            
            [self.doReceiveButton setHidden:NO];
            [self.doReceiveButton mas_remakeConstraints:^(MASConstraintMaker *make){
                make.right.equalTo(self.mas_right).mas_offset(-19);
                make.bottom.equalTo(self.mas_bottom).mas_offset(-5);
                make.width.mas_equalTo(52);
                make.height.mas_equalTo(21);
            }];
        }
            break;
            
        case Award_Receive: {
            [self.getButton setHidden:YES];
            [self.doReceiveButton setHidden:YES];
            [self.donationButton setHidden:YES];
            [self.useButton setHidden:YES];
            
            [self.receiveingButton setHidden:NO];
            [self.receiveingButton mas_remakeConstraints:^(MASConstraintMaker *make){
                make.right.equalTo(self.mas_right).mas_offset(-19);
                make.bottom.equalTo(self.mas_bottom).mas_offset(-5);
                make.width.mas_equalTo(52);
                make.height.mas_equalTo(21);
            }];
        }
            break;
            
        case Award_Use: {
            [self.getButton setHidden:YES];
            [self.doReceiveButton setHidden:YES];
            [self.receiveingButton setHidden:YES];
            
            [self.useButton setHidden:YES];
            [self.useButton mas_remakeConstraints:^(MASConstraintMaker *make){
                make.right.equalTo(self.mas_right).mas_offset(-19);
                make.bottom.equalTo(self.mas_bottom).mas_offset(-5);
                make.width.mas_equalTo(52);
                make.height.mas_equalTo(21);
            }];
            
            [self.donationButton setHidden:YES];
            [self.donationButton mas_remakeConstraints:^(MASConstraintMaker *make){
                make.right.equalTo(self.mas_right).mas_offset(-85);
                make.bottom.equalTo(self.mas_bottom).mas_offset(-5);
                make.width.mas_equalTo(52);
                make.height.mas_equalTo(21);
            }];
        }
            break;
            
        case Award_Default:
        default: {
            [self.getButton setHidden:YES];
            [self.receiveingButton setHidden:YES];
            [self.doReceiveButton setHidden:YES];
            [self.donationButton setHidden:YES];
            [self.useButton setHidden:YES];
        }
            break;
    }
}

@end
