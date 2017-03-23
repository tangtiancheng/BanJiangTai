//
//  XPAwardAcquireTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 1/22/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPAwardAcquireTableViewCell.h"
#import "XPAwardDateViewController.h"
#import "XPAwardViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XPKit/XPKit.h>

@interface XPAwardAcquireTableViewCell ()<XPAwardDateViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) XPAwardDateViewController *dateChoicePickViewController;
@property (nonatomic, strong) NSString *dateBuffer;

@property (nonatomic, strong) XPAwardViewModel *viewModel;

@end

@implementation XPAwardAcquireTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    RAC(self.dateLabel, text) = RACObserve(self, dateBuffer);
    @weakify(self);
    [self whenTapped:^{
        @strongify(self);
        [self conentTaped];
    }];
}

#pragma mark - Delegate
#pragma mark - XPAwardDateViewController Delegate
- (void)dateChoicePickView:(XPAwardDateViewController *)dateChoicePickView date:(NSString *)date timeRange:(NSString *)timeRange
{
    self.dateBuffer = [NSString stringWithFormat:@"%@ %@", date, timeRange];
    self.viewModel.deliveryDate = [date substringToIndex:10];
    self.viewModel.deliveryTime = timeRange;
    if([timeRange isEqualToString:@"不限"]) {
        self.viewModel.deliveryTime = @"00:00-24:00";
    }
}

#pragma mark - Event Responds

#pragma mark - Public Interface
- (void)bindViewModel:(XPAwardViewModel *)viewModel
{
    NSParameterAssert([viewModel isKindOfClass:[XPAwardViewModel class]]);
    self.viewModel = viewModel;
}

#pragma mark - Private Methods
- (void)conentTaped
{
    self.dateChoicePickViewController = [[XPAwardDateViewController alloc] initWithDelegate:self];
    [self.dateChoicePickViewController show];
}

#pragma mark - Getter & Setter

@end
