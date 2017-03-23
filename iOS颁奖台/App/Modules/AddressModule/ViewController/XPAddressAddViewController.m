//
//  XPAddressAddViewController.m
//  XPApp
//
//  Created by xinpinghuang on 12/29/15.
//  Copyright 2015 ShareMerge. All rights reserved.
//

#import "XPAddressAddViewController.h"
#import "XPAddressModel.h"
#import "XPAddressViewModel.h"
#import "XPBaseTableViewCell.h"
#import "XPRegionEntity.h"
#import <XPKit/XPKit.h>

@interface XPAddressAddViewController ()

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (nonatomic, strong) IBOutlet XPAddressViewModel *viewModel;
#pragma clang diagnostic pop
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIButton *saveButton;

@end

@implementation XPAddressAddViewController

#pragma mark - Life Circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView hideEmptySeparators];
    if([self.model.identifier isEqualToString:@"1"]) {
        self.title = @"编辑收货地址";
        XPAddressModel *model = self.model.baseTransfer;
        self.viewModel.addressId = model.addressId;
        self.viewModel.recipient = model.name;
        self.viewModel.phone = model.phone;
        self.viewModel.region_0 = [[[XPRegionEntity alloc] init] tap:^(XPRegionEntity *x) {
            x.id = [model.province integerValue];
        }];
        self.viewModel.region_1 = [[[XPRegionEntity alloc] init] tap:^(XPRegionEntity *x) {
            x.id = [model.city integerValue];
        }];
        self.viewModel.region_2 = [[[XPRegionEntity alloc] init] tap:^(XPRegionEntity *x) {
            x.id = [model.area integerValue];
        }];
        self.viewModel.addressDetail = model.addressInfo;
        self.viewModel.defaultAddress = model.isDefault;
        
        self.saveButton.rac_command = self.viewModel.updateCommand;
        if(model.isDefault) {
            self.navigationItem.rightBarButtonItem = nil;
        } else {
            self.navigationItem.rightBarButtonItem.rac_command = self.viewModel.deleteCommand;
        }
    } else {
        self.title = @"新增收货地址";
        self.navigationItem.rightBarButtonItem = nil;
        self.saveButton.rac_command = self.viewModel.createCommand;
    }
    
    [self rac_liftSelector:@selector(cleverLoader:) withSignals:RACObserve(self.viewModel, executing), nil];
    [self rac_liftSelector:@selector(showToastWithNSError:) withSignals:[[RACObserve(self.viewModel, error) ignore:nil] map:^id (id value) {
        return value;
    }], nil];
    
    @weakify(self);
    [[RACObserve(self.viewModel, finished) ignore:@(NO)] subscribeNext:^(id x) {
        @strongify(self);
        [self pop];
    }];
}

#pragma mark - Delegate
#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XPBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Cell_%ld", (long)indexPath.row] forIndexPath:indexPath];
    [cell bindViewModel:self.viewModel];
    if([self.model.identifier isEqualToString:@"1"]) { // 如果是编辑的话，则需要讲默认的值带进去
        [cell bindModel:self.model.baseTransfer];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Event Responds

#pragma mark - Private Methods

#pragma mark - Public Interface
- (void)bindViewModel:(XPAddressViewModel *)viewModel
{
    NSParameterAssert([viewModel isKindOfClass:[XPAddressViewModel class]]);
    self.viewModel = viewModel;
}

#pragma mark - Getter & Setter

@end
