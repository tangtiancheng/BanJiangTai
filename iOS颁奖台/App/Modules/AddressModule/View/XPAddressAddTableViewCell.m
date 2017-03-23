//
//  XPAddressAddTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 1/11/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPAddressAddTableViewCell.h"
#import "XPAddressModel.h"
#import "XPAddressViewModel.h"
#import "XPRegionChoicePickViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XPKit/XPKit.h>

@interface XPAddressAddTableViewCell ()<XPRegionChoicePickViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel *addressLabel;
@property (nonatomic, strong) NSString *addressInfo;
@property (nonatomic, strong) XPAddressModel *model;
@property (nonatomic, strong) XPRegionChoicePickViewController *regionChoicePickViewController;
@property (nonatomic, strong) XPAddressViewModel *viewModel;

@end

@implementation XPAddressAddTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    RACSignal *startSignal = [RACSignal combineLatest:@[[RACObserve(self, model.provinceName) ignore:nil], [RACObserve(self, model.cityName) ignore:nil], [RACObserve(self, model.areaName) ignore:nil]] reduce:^id (NSString *provinceName, NSString *cityName, NSString *areaName){
        return [NSString stringWithFormat:@"所在地址：%@-%@-%@", provinceName, cityName, areaName];
    }];
    RACSignal *dynamicSignal = [[[RACObserve(self, addressInfo) ignore:nil] skip:1] map:^id (id value) {
        return [@"所在地址：" stringByAppendingString:value];
    }];
    
    RAC(self.addressLabel, text) = [RACSignal merge:@[startSignal, dynamicSignal]];
    
    @weakify(self);
    [self whenTapped:^{
        @strongify(self);
        [[self belongViewController].view endEditing:YES];
        [self conentTaped];
    }];
}

#pragma mark - Delegate
#pragma mark - XPRegionChoicePickViewController Delegate
- (void)regionChoicePickView:(nullable XPRegionChoicePickViewController *)regionChoicePickView component:(NSInteger)component row:(NSInteger)row didSelectRegion:(nullable XPRegionEntity *)region
{
    switch(component) {
        case 0: {
            self.viewModel.region_0 = region;
        }
            break;
            
        case 1: {
            self.viewModel.region_1 = region;
        }
            break;
            
        case 2: {
            self.viewModel.region_2 = region;
            self.addressInfo = [NSString stringWithFormat:@"%@-%@-%@", self.viewModel.region_0.name, self.viewModel.region_1.name, self.viewModel.region_2.name];
        }
            break;
            
        case 3: {
            self.viewModel.region_3 = region;
        }
            break;
            
        default: {
        }
            break;
    }
}

#pragma mark - Event Responds

#pragma mark - Public Interface
- (void)bindViewModel:(XPAddressViewModel *)viewModel
{
    NSParameterAssert([viewModel isKindOfClass:[XPAddressViewModel class]]);
    self.viewModel = viewModel;
}

- (void)bindModel:(XPAddressModel *)model
{
    NSParameterAssert([model isKindOfClass:[XPAddressModel class]]);
    self.model = model;
}

#pragma mark - Private Methods
- (void)conentTaped
{
    self.regionChoicePickViewController = [[XPRegionChoicePickViewController alloc] initWithDelegate:self regionChoiceStyle:XPRegionChoiceStyle_Province_City_District];
    [self.regionChoicePickViewController show];
}

#pragma mark - Getter & Setter

@end
