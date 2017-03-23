//
//  XPProfileBirthdayTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 12/29/15.
//  Copyright 2015 ShareMerge. All rights reserved.
//

#import "XPProfileBirthdayTableViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XPKit/XPKit.h>
#define MCANIMATE_SHORTHAND
#import "XPLoginModel.h"
#import "XPProfileViewModel.h"
#import <DateTools/DateTools.h>
#import <POP+MCAnimate/POP+MCAnimate.h>

@interface XPProfileBirthdayTableViewCell ()

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) XPProfileViewModel *viewModel;

@end

@implementation XPProfileBirthdayTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    @weakify(self);
    RAC(self.dateLabel, text) = [[RACObserve([XPLoginModel singleton], birthday) ignore:nil] map:^id (id value) {
        return [@"出生日期：" stringByAppendingString:value];
    }];
    
    [self whenTapped:^{
        @strongify(self);
        [self contentTaped];
    }];
    
    [[[self.datePicker rac_signalForControlEvents:UIControlEventValueChanged] map:^id (UIDatePicker *value) {
        NSDate *date = value.date;
        return [NSString stringWithFormat:@"出生日期：%@", date ? [date formattedDateWithFormat:@"YYYY-MM-dd"] : @""];
    }] subscribeNext:^(id x) {
        @strongify(self);
        self.dateLabel.text = x;
    }];
    
    RAC(self, viewModel.birthday) = [[RACObserve(self, dateLabel.text) ignore:nil] map:^id (id value) {
        return [value stringByReplacingOccurrencesOfString:@"出生日期：" withString:@""];
    }];
}

#pragma mark - Delegate

#pragma mark - Event Responds
- (void)contentTaped
{
    self.datePicker.left = 0;
    self.datePicker.top = self.containerView.height;
    self.datePicker.width = self.containerView.width;
    [self animationDatePickerShow];
}

#pragma mark - Public Interface
- (void)bindViewModel:(XPProfileViewModel *)viewModel
{
    NSParameterAssert([viewModel isKindOfClass:[XPProfileViewModel class]]);
    self.viewModel = viewModel;
}

#pragma mark - Private Methods
- (void)animationDatePickerShow
{
    self.datePicker.layer.anchorPoint = ccp(0.5, 0);
    self.datePicker.layer.pop_duration = 0.3f;
    self.datePicker.layer.easeInEaseOut.pop_positionY = self.containerView.height-self.datePicker.height;
    [self.containerView setHidden:NO];
}

- (void)animationDatePickerHidden
{
    self.datePicker.layer.anchorPoint = ccp(0.5, 0);
    self.datePicker.layer.pop_duration = 0.3f;
    @weakify(self);
    [NSObject animate:^{
        @strongify(self);
        self.datePicker.layer.easeInEaseOut.pop_positionY = self.containerView.height;
    }
           completion:^(BOOL finished) {
               @strongify(self);
//               [self.containerView removeFromSuperview];
//               self.containerView = nil;
//               self.datePicker = nil;
               [self.containerView setHidden:YES];
           }];
}

#pragma mark - Getter & Setter
- (UIDatePicker *)datePicker
{
    if(_datePicker == nil) {
        _datePicker = [[UIDatePicker alloc] init];
        [_datePicker setMinimumDate:[NSDate dateWithTimeIntervalSince1970:-1893484800]];
        [_datePicker setMaximumDate:[NSDate date]];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.backgroundColor = [UIColor whiteColor];
        [self.containerView addSubview:_datePicker];
    }
    
    return _datePicker;
}

- (UIView *)containerView
{
    if(_containerView == nil) {
        _containerView = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        _containerView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.500];
        [[UIApplication sharedApplication].keyWindow addSubview:_containerView];
        [_containerView setHidden:YES];
        
        [_containerView whenTapped:^{
            [self animationDatePickerHidden];
        }];
    }
    
    return _containerView;
}

@end
