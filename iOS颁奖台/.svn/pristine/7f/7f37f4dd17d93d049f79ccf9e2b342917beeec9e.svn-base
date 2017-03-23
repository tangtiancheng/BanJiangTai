//
//  XPAwardDateViewController.m
//  XPApp
//
//  Created by xinpinghuang on 1/22/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import "NSNumber+XPWeekday.h"
#import "XPAwardDateViewController.h"
#import <DateTools/DateTools.h>

@interface XPAwardDateViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) id<XPAwardDateViewControllerDelegate> delegate;
@property (strong, nonatomic) UIPickerView *pickView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) NSArray *dateArray;
@property (nonatomic, strong) NSArray *timeArray;
@property (nonatomic, assign) NSInteger dateSelectedRow;
@property (nonatomic, assign) NSInteger timeSelectedRow;
@end

@implementation XPAwardDateViewController

#pragma mark - Life Circle
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        self.windowLevel = UIWindowLevelAlert;
        // 这里，不能设置UIWindow的alpha属性，会影响里面的子view的透明度，这里我们用一张透明的图片
        // 设置背影半透明
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (nonnull instancetype)initWithDelegate:(id<XPAwardDateViewControllerDelegate>)delegate
{
    if(self = [self initWithFrame:[UIScreen mainScreen].bounds]) {
        self.delegate = delegate;
        [self configAllValues];
        [self configAllUI];
    }
    
    return self;
}

#pragma mark - Private Method
- (void)configAllValues
{
    self.dateSelectedRow = 0;
    self.timeSelectedRow = 0;
    NSMutableArray *buffer = [NSMutableArray array];
    NSDate *now = [NSDate date];
    for(NSInteger i = 0; i < 365; i++) {
        [buffer addObject:[NSString stringWithFormat:@"%@（%@）", [now formattedDateWithFormat:@"yyyy-MM-dd"], [@(now.weekday)shortWeekday]]];
        now = [now dateByAddingDays:1];
    }
    self.dateArray = buffer;
    self.timeArray = @[
                       @"09:00-15:00",
                       @"15:00-19:00",
                       @"19:00-22:00",
                       @"不限"
                       ];
    [self notifySelected];
}

- (void)configAllUI
{
    [self addSubview:self.containerView];
    [self addSubview:self.pickView];
}

#pragma mark - Public Interface
- (void)show
{
    [self makeKeyAndVisible];
    [self showAnimaiton];
}

#pragma mark - Private Methods
- (void)showAnimaiton
{
    self.hidden = NO;
    self.pickView.frame = (CGRect){0, self.bounds.size.height, self.pickView.bounds.size};
    [UIView animateWithDuration:0.5 delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:1.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.pickView.frame = (CGRect){0, self.bounds.size.height-self.pickView.bounds.size.height, self.pickView.bounds.size};
                     }
                     completion:^(BOOL finished) {
                         self.userInteractionEnabled = YES;
                     }];
}

- (void)dismissWithAnimation
{
    [UIView animateWithDuration:0.3
                          delay:0
         usingSpringWithDamping:0.9
          initialSpringVelocity:0.9
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.pickView.frame = (CGRect){0, self.bounds.size.height, self.pickView.bounds.size};
                         self.containerView.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         self.userInteractionEnabled = YES;
                         [self.pickView removeFromSuperview];
                         [self.containerView removeFromSuperview];
                         [self resignKeyWindow];
                         [self setHidden:YES];
                         [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
                     }];
}

- (void)cancelButtonClick:(id)sender
{
    [self dismissWithAnimation];
    if(self.delegate && [self.delegate respondsToSelector:@selector(dateChoiceDidCanceled:)]) {
        [self.delegate dateChoiceDidCanceled:self];
    }
}

- (void)notifySelected
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(dateChoicePickView:date:timeRange:)]) {
        [self.delegate dateChoicePickView:self date:self.dateArray[self.dateSelectedRow] timeRange:self.timeArray[self.timeSelectedRow]];
    }
}

#pragma mark - Delegate
#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view;
    if(!pickerLabel) {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.minimumScaleFactor = 8.0;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:12]];
    }
    
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch(component) {
        case 0: {
            return self.dateArray.count;
        }
            break;
            
        case 1: {
            return self.timeArray.count;
        }
            break;
            
        default: {
            return 0;
        }
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch(component) {
        case 0: {
            return self.dateArray[row];
            break;
        }
            
        case 1: {
            return self.timeArray[row];
            break;
        }
            
        default: {
            return @"";
        }
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch(component) {
        case 0: {
            self.dateSelectedRow = row;
        }
            break;
            
        case 1: {
            self.timeSelectedRow = row;
        }
            break;
            
        default: {
        }
            break;
    }
    [self notifySelected];
}

#pragma mark - Getter && Setter
- (UIPickerView *)pickView
{
    if(!_pickView) {
        _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 250)];
        _pickView.delegate = self;
        _pickView.dataSource = self;
        _pickView.backgroundColor = [UIColor whiteColor];
    }
    
    return _pickView;
}

- (UIView *)containerView
{
    if(!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:self.bounds];
        [_containerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelButtonClick:)]];
        _containerView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
    }
    
    return _containerView;
}

@end
