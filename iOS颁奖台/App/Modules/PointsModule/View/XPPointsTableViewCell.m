//
//  XPPointsTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 12/29/15.
//  Copyright © 2015 ShareMerge. All rights reserved.
//

#import "XPPointsModel.h"
#import "XPPointsTableViewCell.h"

@interface XPPointsTableViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel *pointLabel;

@property (nonatomic, strong) XPPointItemModel *model;
@end

@implementation XPPointsTableViewCell

- (void)awakeFromNib
{
    RAC(self.timeLabel, text) = [RACObserve(self, model.time) ignore:nil];
    RAC(self.nameLabel, text) = [RACObserve(self, model.name) ignore:nil];
    RAC(self.pointLabel, text) = [[[RACObserve(self, model.points) ignore:nil] zipWith:[RACObserve(self, model.pointsStatus) ignore:nil]] map:^id (RACTuple *value) {
        RACTupleUnpack(NSNumber *points, NSNumber *pointsStatus) = value;
        return ![pointsStatus boolValue] ? [@"+" stringByAppendingString:[points stringValue]] : [@"-" stringByAppendingString:[points stringValue]];
    }];
    RAC(self.pointLabel, textColor) = [RACObserve(self, pointLabel.text) map:^id (NSString *value) {
        return [value hasPrefix:@"+"] ? [UIColor colorWithRed:1.000 green:0.573 blue:0.235 alpha:1.000] : [UIColor colorWithRed:0.518 green:0.808 blue:0.718 alpha:1.000];
    }];
}

- (void)bindModel:(XPPointItemModel *)model
{
    NSParameterAssert([model isKindOfClass:[XPPointItemModel class]]);
    self.model = model;
}

@end
