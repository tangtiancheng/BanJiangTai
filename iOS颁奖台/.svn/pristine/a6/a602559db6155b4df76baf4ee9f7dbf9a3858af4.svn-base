//
//  XPAwardDeliveryViewController.m
//  XPApp
//
//  Created by xinpinghuang on 1/22/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "UIView+XPEmptyData.h"
#import "XPAddressModel.h"
#import "XPAddressViewController.h"
#import "XPAddressViewModel.h"
#import "XPAwardDeliveryBottomView.h"
#import "XPAwardDeliveryViewController.h"
#import "XPAwardModel.h"
#import "XPAwardViewModel.h"
#import "XPBaseTableViewCell.h"
#import <XPKit/XPKit.h>

@interface XPAwardDeliveryViewController ()

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (nonatomic, strong) IBOutlet XPAwardViewModel *viewModel;
#pragma clang diagnostic pop
@property (nonatomic, strong) IBOutlet XPAddressViewModel *addressViewModel;
@property (nonatomic, strong) XPAddressModel *selectedAddressModel;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet XPAwardDeliveryBottomView *deliveryBottomView;

@end

@implementation XPAwardDeliveryViewController

#pragma mark - Life Circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView hideEmptySeparators];
    [self rac_liftSelector:@selector(cleverLoader:) withSignals:RACObserve(self.addressViewModel, executing), nil];
    [self rac_liftSelector:@selector(showToastWithNSError:) withSignals:[[RACObserve(self.addressViewModel, error) ignore:nil] map:^id (id value) {
        return value;
    }], nil];
    [self rac_liftSelector:@selector(cleverLoader:) withSignals:RACObserve(self.viewModel, executing), nil];
    [self rac_liftSelector:@selector(showToastWithNSError:) withSignals:[[RACObserve(self.viewModel, error) ignore:nil] map:^id (id value) {
        return value;
    }], nil];
    
    @weakify(self);
    [[RACObserve(self.addressViewModel, list) ignore:nil] subscribeNext:^(NSArray *x) {
        @strongify(self);
        self.selectedAddressModel = x[0];
        self.viewModel.addressId = self.selectedAddressModel.addressId;
        [self.tableView reloadData];
    }];
    [self.addressViewModel.reloadCommand execute:nil];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:XPAddressSelectedNotification object:nil] subscribeNext:^(NSNotification *x) {
        @strongify(self);
        self.selectedAddressModel = x.object;
        self.viewModel.addressId = self.selectedAddressModel.addressId;
        [self.tableView reloadData];
    }];
    
    self.viewModel.awardId = [(XPAwardItemModel *)[self model] prizeId];
    [self.deliveryBottomView bindViewModel:self.viewModel];
    
    [[RACObserve(self, viewModel.finished) ignore:@(NO)] subscribeNext:^(id x) {
        @strongify(self);
        [self performSegueWithIdentifier:@"embed_finished" sender:self];
    }];
    
    [[RACSignal combineLatest:@[[RACObserve(self.viewModel, list) ignore:@(NO)], [RACObserve(self.viewModel, finished) ignore:nil]] reduce:^id (NSArray *list, NSNumber *finishd){
        return @([finishd boolValue] && list.count == 0);
    }] subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if([x boolValue]) {
            [self.tableView showEmptyData];
        } else {
            [self.tableView destoryEmptyData];
        }
    }];
}

#pragma mark - Delegate
#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.addressViewModel.list.count ? 3 : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(0 == indexPath.row) {
        return 114;
    } else if(1 == indexPath.row) {
        return 80;
    }
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XPBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Cell_%ld", (long)indexPath.row] forIndexPath:indexPath];
    if(0 == indexPath.row) {
        [cell bindModel:self.selectedAddressModel];
    } else if(1 == indexPath.row) {
        [cell bindModel:self.model];
    } else {
        [cell bindViewModel:self.viewModel];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(0 == indexPath.row) {
        [self pushViewController:[(XPBaseViewController *)[self instantiateInitialViewControllerWithStoryboardName:@"Address"] tap:^(XPBaseViewController *x) {
            x.model = [[[XPBaseModel alloc] init] tap:^(XPBaseModel *x) {
                x.identifier = @"able_selected";
            }];
        }]];
    }
}

#pragma mark - Event Responds

#pragma mark - Private Methods

#pragma mark - Public Interface

#pragma mark - Getter & Setter

@end
