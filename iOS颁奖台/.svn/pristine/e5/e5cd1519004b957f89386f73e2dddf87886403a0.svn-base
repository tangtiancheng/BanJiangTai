//
//  XPProfileSexTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 12/29/15.
//  Copyright 2015 ShareMerge. All rights reserved.
//

#import "XPLoginModel.h"
#import "XPProfileSexTableViewCell.h"
#import "XPProfileViewModel.h"
#import <Masonry/Masonry.h>
#import <XPSwitch/XPSwitch.h>

@interface XPProfileSexTableViewCell ()

@property (nonatomic, strong) XPSwitch *sexSwitch;
@property (nonatomic, strong) UILabel *sexBoyLabel;
@property (nonatomic, strong) UILabel *sexGirlLabel;
@property (nonatomic, strong) XPProfileViewModel *viewModel;

@end

@implementation XPProfileSexTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    @weakify(self);
    [RACObserve([XPLoginModel singleton], userSex) subscribeNext:^(id x) {
        @strongify(self);
        switch([x integerValue]) {
            case 1: { // 女
                self.viewModel.sex = 1;
                [self.sexSwitch selectIndex:1 animated:NO];
            }
                break;
                
            case 0:
            default: { // 未设置或男
                self.viewModel.sex = 0;
                [self.sexSwitch selectIndex:0 animated:NO];
            }
                break;
        }
    }];
    [self.sexSwitch setPressedHandler:^(NSUInteger index) {
        @strongify(self);
        self.viewModel.sex = index;
        NSLog(@"Did switch to index: %lu", (unsigned long)index);
    }];
    [self addSubview:self.sexSwitch];
    [self addSubview:self.sexBoyLabel];
    [self addSubview:self.sexGirlLabel];
}

#pragma mark - Delegate

#pragma mark - Event Responds

#pragma mark - Public Interface
- (void)bindViewModel:(XPProfileViewModel *)viewModel
{
    NSParameterAssert([viewModel isKindOfClass:[XPProfileViewModel class]]);
    self.viewModel = viewModel;
}

#pragma mark - Private Methods

#pragma mark - Getter & Setter
- (XPSwitch *)sexSwitch
{
    if(!_sexSwitch) {
        _sexSwitch = [[XPSwitch alloc] initWithStringsArray:@[@"", @""]];
        _sexSwitch.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-81-23, 13, 81, 27);
        _sexSwitch.sliderColor = [UIColor colorWithRed:1.000 green:0.925 blue:0.929 alpha:1.000];
        _sexSwitch.backgroundColor = [UIColor colorWithRed:0.776 green:0.208 blue:0.227 alpha:1.000];
        _sexSwitch.labelTextColorInsideSlider = [UIColor clearColor];
        _sexSwitch.labelTextColorOutsideSlider = [UIColor clearColor];
    }
    
    return _sexSwitch;
}

- (UILabel *)sexBoyLabel
{
    if(!_sexBoyLabel) {
        _sexBoyLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-81-40, 13, 20, 27)];
        _sexBoyLabel.font = [UIFont systemFontOfSize:12];
        _sexBoyLabel.textColor = [UIColor colorWithWhite:0.298 alpha:1.000];
        _sexBoyLabel.text = @"男";
    }
    
    return _sexBoyLabel;
}

- (UILabel *)sexGirlLabel
{
    if(!_sexGirlLabel) {
        _sexGirlLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-19, 13, 20, 27)];
        _sexGirlLabel.font = [UIFont systemFontOfSize:12];
        _sexGirlLabel.textColor = [UIColor colorWithWhite:0.298 alpha:1.000];
        _sexGirlLabel.text = @"女";
    }
    
    return _sexGirlLabel;
}

@end
