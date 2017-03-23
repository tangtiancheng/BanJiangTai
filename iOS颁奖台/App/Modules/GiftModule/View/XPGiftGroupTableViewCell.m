//
//  XPGiftGroupTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 1/23/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPGiftGroupModel.h"
#import "XPGiftGroupTableViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XPKit/XPKit.h>

@interface XPGiftGroupTableViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) XPGiftGroupModel *model;

@end

@implementation XPGiftGroupTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    RAC(self.nameLabel, text) = [RACSignal combineLatest:@[RACObserve(self, model.groupName), RACObserve(self, model.count)] reduce:^id (NSString *groupName, NSNumber *count){
        return [NSString stringWithFormat:@"%@（%@人）", groupName, count];
    }];
}

#pragma mark - Delegate

#pragma mark - Event Responds

#pragma mark - Public Interface
- (void)bindModel:(XPGiftGroupModel *)model
{
    NSParameterAssert([model isKindOfClass:[XPGiftGroupModel class]]);
    self.model = model;
}

#pragma mark - Private Methods

#pragma mark - Getter & Setter

@end
