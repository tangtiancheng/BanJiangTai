//
//  XPAddressViewController.m
//  XPApp
//
//  Created by xinpinghuang on 12/29/15.
//  Copyright 2015 ShareMerge. All rights reserved.
//

#import "UIView+XPEmptyData.h"
#import "XPAddressViewController.h"
#import "XPAddressViewModel.h"
#import "XPBaseTableViewCell.h"
#import <MJRefresh/MJRefresh.h>
#import <XPKit/XPKit.h>

NSString *const XPAddressSelectedNotification = @"XPAddressSelectedNotification";

@interface XPAddressViewController ()

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (nonatomic, strong) IBOutlet XPAddressViewModel *viewModel;
#pragma clang diagnostic pop
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation XPAddressViewController

#pragma mark - Life Circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView hideEmptySeparators];
    [self rac_liftSelector:@selector(cleverLoader:) withSignals:RACObserve(self.viewModel, executing), nil];
    [self rac_liftSelector:@selector(showToastWithNSError:) withSignals:[[RACObserve(self.viewModel, error) ignore:nil] map:^id (id value) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        return value;
    }], nil];
    
    @weakify(self);
    [[RACObserve(self.viewModel, finished) ignore:@(NO)] subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }];
    [[RACObserve(self.viewModel, list) ignore:nil] subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
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
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self.viewModel.reloadCommand execute:nil];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self.viewModel.moreCommand execute:nil];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"embed_edit"]) {
        [(XPBaseViewController *)segue.destinationViewController setModel:[[[XPBaseModel alloc] init] tap:^(XPBaseModel *x) {
            x.identifier = @"1";
            NSString *currentButtonTile = [(UIButton *)sender titleForState:UIControlStateNormal];
            NSInteger row = [currentButtonTile integerValue];
            x.baseTransfer = self.viewModel.list[row];
        }]];
    }
}

#pragma mark - Delegate
#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XPBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [(UIButton *)[cell viewWithTag:100] setTitle:[NSString stringWithFormat:@"%ld", indexPath.row] forState:UIControlStateNormal]; // 通过当前的标题，后续点击编辑按钮时才知道是哪一行
    [cell bindModel:self.viewModel.list[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if([self.model.identifier isEqualToString:@"able_selected"]) { // 当前为可选择地址
        [[NSNotificationCenter defaultCenter] postNotificationName:XPAddressSelectedNotification object:self.viewModel.list[indexPath.row]];
        
        [self pop];
    }
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//    }
//    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
//        [cell setPreservesSuperviewLayoutMargins:NO];
//    }
//    if([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
//}

#pragma mark - Event Responds

#pragma mark - Private Methods

#pragma mark - Public Interface

#pragma mark - Getter & Setter

@end
