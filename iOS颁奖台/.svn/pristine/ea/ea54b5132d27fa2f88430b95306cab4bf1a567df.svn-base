//
//  XPRegionChoicePickViewController.m
//  XPApp
//
//  Created by xinpinghuang on 1/6/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import "XPRegionChoicePickViewController.h"
#import "XPRegionCommand.h"

@interface XPRegionChoicePickViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) id<XPRegionChoicePickViewDelegate> delegate;
@property (strong, nonatomic) UIPickerView *pickView;
@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, copy) NSString *region_0_id; // 第一列被选中ID
@property (nonatomic, copy) NSString *region_1_id; // 第二列被选中ID
@property (nonatomic, copy) NSString *region_2_id; // 第三列被选中ID
@property (nonatomic, copy) NSString *region_3_id; // 第四列被选中ID

@property (nonatomic, assign) NSInteger maxCompenent; // 最大的列（最大4列，分别为省、市、县、镇）

@end

@implementation XPRegionChoicePickViewController

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

- (nonnull instancetype)initWithDelegate:(id<XPRegionChoicePickViewDelegate>)delegate regionChoiceStyle:(XPRegionChoiceStyle)regionChoiceStyle
{
    if(self = [self initWithFrame:[UIScreen mainScreen].bounds]) {
        self.region_0_id = @"1";
        self.delegate = delegate;
        self.maxCompenent = regionChoiceStyle;
        [self configAllValues];
        [self configAllUI];
    }
    
    return self;
}

#pragma mark - Private Method
- (void)configAllValues
{
    {
        RLMResults *results = [XPRegionCommand regionWithParentId:self.region_0_id];
        if([results count]) {
            XPRegionEntity *entity0 = [results objectAtIndex:0];
            self.region_1_id = [NSString stringWithFormat:@"%ld", (long)entity0.id];
            if(self.delegate && [self.delegate respondsToSelector:@selector(regionChoicePickView:component:row:didSelectRegion:)]) {
                [self.delegate regionChoicePickView:self component:0 row:0 didSelectRegion:entity0];
            }
        }
    }
    
    {
        RLMResults *results = [XPRegionCommand regionWithParentId:self.region_1_id];
        if([results count]) {
            XPRegionEntity *entity1 = [results objectAtIndex:0];
            self.region_2_id = [NSString stringWithFormat:@"%ld", (long)entity1.id];
            if(self.delegate && [self.delegate respondsToSelector:@selector(regionChoicePickView:component:row:didSelectRegion:)]) {
                [self.delegate regionChoicePickView:self component:1 row:0 didSelectRegion:entity1];
            }
        }
    }
    
    {
        RLMResults *results = [XPRegionCommand regionWithParentId:self.region_2_id];
        if([results count]) {
            XPRegionEntity *entity2 = [results objectAtIndex:0];
            self.region_3_id = [NSString stringWithFormat:@"%ld", (long)entity2.id];
            if(self.delegate && [self.delegate respondsToSelector:@selector(regionChoicePickView:component:row:didSelectRegion:)]) {
                [self.delegate regionChoicePickView:self component:2 row:0 didSelectRegion:entity2];
            }
        }
    }
    
    {
        RLMResults *results = [XPRegionCommand regionWithParentId:self.region_3_id];
        if([results count]) {
            XPRegionEntity *entity3 = [results objectAtIndex:0];
            if(self.delegate && [self.delegate respondsToSelector:@selector(regionChoicePickView:component:row:didSelectRegion:)]) {
                [self.delegate regionChoicePickView:self component:3 row:0 didSelectRegion:entity3];
            }
        }
    }
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
                         self.region_1_id = nil;
                         self.region_2_id = nil;
                         self.region_3_id = nil;
                         [self resignKeyWindow];
                         [self setHidden:YES];
                         [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
                     }];
}

- (void)cancelButtonClick:(id)sender
{
    [self dismissWithAnimation];
    if(self.delegate && [self.delegate respondsToSelector:@selector(regionChoiceDidCanceled:)]) {
        [self.delegate regionChoiceDidCanceled:self];
    }
}

#pragma mark - Delegate
#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.maxCompenent;
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
            return [[XPRegionCommand regionWithParentId:self.region_0_id] count];
        }
            break;
            
        case 1: {
            return [[XPRegionCommand regionWithParentId:self.region_1_id] count];
        }
            break;
            
        case 2: {
            return [[XPRegionCommand regionWithParentId:self.region_2_id] count];
        }
            break;
            
        case 3: {
            return [[XPRegionCommand regionWithParentId:self.region_3_id] count];
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
            return [(XPRegionEntity *)[[XPRegionCommand regionWithParentId:self.region_0_id] objectAtIndex:row] name];
            break;
        }
            
        case 1: {
            return [(XPRegionEntity *)[[XPRegionCommand regionWithParentId:self.region_1_id] objectAtIndex:row] name];
            break;
        }
            
        case 2: {
            return [(XPRegionEntity *)[[XPRegionCommand regionWithParentId:self.region_2_id] objectAtIndex:row] name];
            break;
        }
            
        case 3: {
            return [(XPRegionEntity *)[[XPRegionCommand regionWithParentId:self.region_3_id] objectAtIndex:row] name];
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
            XPRegionEntity *entity = [[XPRegionCommand regionWithParentId:self.region_0_id] objectAtIndex:row];
            if(self.delegate && [self.delegate respondsToSelector:@selector(regionChoicePickView:component:row:didSelectRegion:)]) {
                [self.delegate regionChoicePickView:self component:component row:row didSelectRegion:entity];
            }
            
            self.region_1_id = [NSString stringWithFormat:@"%ld", (long)entity.id];
            if(self.maxCompenent >= 2) {
                [self.pickView reloadComponent:1];
                if([self pickerView:self.pickView numberOfRowsInComponent:1]) {
                    [self pickerView:self.pickView didSelectRow:0 inComponent:1];
                    [self.pickView selectRow:0 inComponent:1 animated:YES];
                } else {
                    self.region_2_id = @"0";
                    self.region_3_id = @"0";
                    if(self.maxCompenent >= 3) {
                        [self.pickView reloadComponent:2];
                    }
                    if(self.maxCompenent >= 4) {
                        [self.pickView reloadComponent:3];
                    }
                }
            }
        }
            break;
            
        case 1: {
            XPRegionEntity *entity = [[XPRegionCommand regionWithParentId:self.region_1_id] objectAtIndex:row];
            if(self.delegate && [self.delegate respondsToSelector:@selector(regionChoicePickView:component:row:didSelectRegion:)]) {
                [self.delegate regionChoicePickView:self component:component row:row didSelectRegion:entity];
            }
            
            self.region_2_id = [NSString stringWithFormat:@"%ld", (long)entity.id];
            if(self.maxCompenent >= 3) {
                [self.pickView reloadComponent:2];
                if([self pickerView:self.pickView numberOfRowsInComponent:2]) {
                    [self pickerView:self.pickView didSelectRow:0 inComponent:2];
                    [self.pickView selectRow:0 inComponent:2 animated:YES];
                } else {
                    self.region_3_id = @"0";
                    if(self.maxCompenent >= 4) {
                        [self.pickView reloadComponent:3];
                    }
                }
            }
        }
            break;
            
        case 2: {
            XPRegionEntity *entity = [[XPRegionCommand regionWithParentId:self.region_2_id] objectAtIndex:row];
            if(self.delegate && [self.delegate respondsToSelector:@selector(regionChoicePickView:component:row:didSelectRegion:)]) {
                [self.delegate regionChoicePickView:self component:component row:row didSelectRegion:entity];
            }
            
            self.region_3_id = [NSString stringWithFormat:@"%ld", (long)entity.id];
            if(self.maxCompenent >= 4) {
                [self.pickView reloadComponent:3];
                if([self pickerView:self.pickView numberOfRowsInComponent:3]) {
                    [self pickerView:self.pickView didSelectRow:0 inComponent:3];
                    [self.pickView selectRow:0 inComponent:3 animated:YES];
                }
            }
        }
            break;
            
        case 3: {
            XPRegionEntity *entity = [[XPRegionCommand regionWithParentId:self.region_3_id] objectAtIndex:row];
            if(self.delegate && [self.delegate respondsToSelector:@selector(regionChoicePickView:component:row:didSelectRegion:)]) {
                [self.delegate regionChoicePickView:self component:component row:row didSelectRegion:entity];
            }
        }
            break;
            
        default: {
        }
            break;
    }
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
