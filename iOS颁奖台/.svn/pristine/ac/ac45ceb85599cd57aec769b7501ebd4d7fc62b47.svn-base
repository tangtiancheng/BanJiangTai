//
//  XPProfileUserInfoTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 12/29/15.
//  Copyright 2015 ShareMerge. All rights reserved.
//

#import "XPLoginModel.h"
#import "XPProfileUserInfoTableViewCell.h"

@interface XPProfileUserInfoTableViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *idLabel;

@end

@implementation XPProfileUserInfoTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    RAC(self, idLabel.text) = [[RACObserve([XPLoginModel singleton], userId) ignore:nil] map:^id (id value) {
        return [@"用户ID：" stringByAppendingString:value];
    }];
}

#pragma mark - Delegate

#pragma mark - Event Responds

#pragma mark - Public Interface

#pragma mark - Private Methods

#pragma mark - Getter & Setter

@end
