//
//  XPProfilePhoneTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 12/29/15.
//  Copyright 2015 ShareMerge. All rights reserved.
//

#import "XPLoginModel.h"
#import "XPProfilePhoneTableViewCell.h"

@interface XPProfilePhoneTableViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *phoneLabel;

@end

@implementation XPProfilePhoneTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    RAC(self, phoneLabel.text) = [[RACObserve([XPLoginModel singleton], userPhone) ignore:nil] map:^id (id value) {
        return [@"手机号码：" stringByAppendingString:value];
    }];
}

#pragma mark - Delegate

#pragma mark - Event Responds

#pragma mark - Public Interface

#pragma mark - Private Methods

#pragma mark - Getter & Setter

@end
