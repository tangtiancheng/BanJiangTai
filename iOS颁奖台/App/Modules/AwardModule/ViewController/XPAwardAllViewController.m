//
//  XPAwardAllViewController.m
//  XPApp
//
//  Created by xinpinghuang on 1/21/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "UIView+XPEmptyData.h"
#import "XPAwardAllViewController.h"
#import "XPAwardModel.h"
#import "XPAwardViewModel.h"
#import "XPBaseTableViewCell.h"
#import "XPLoginModel.h"
#import <MJRefresh/MJRefresh.h>
#import <XPKit/XPKit.h>

@interface XPAwardAllViewController ()
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (nonatomic, strong) IBOutlet XPAwardViewModel *viewModel;
#pragma clang diagnostic pop
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation XPAwardAllViewController

#pragma mark - Life Circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"AwardCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell"];
    
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
    self.viewModel.type = 0;
    [self.tableView.mj_header beginRefreshing];
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
    [cell bindModel:self.viewModel.list[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XPAwardItemModel *model = self.viewModel.list[indexPath.row];
    if([model.prizeStatus isEqualToString:@"P"]) {
        [self pushViewController:[[self instantiateInitialViewControllerWithStoryboardName:@"Web"] tap:^(XPBaseViewController *x) {
            x.model = [[[XPBaseModel alloc] init] tap:^(XPBaseModel *x) {
                x.identifier = [NSString stringWithFormat:@"%@?type=%@&postid=%@", self.viewModel.kuaidi100, model.expressCode, model.expressNumbers];
                x.baseTransfer = @"物流查询";
            }];
        }]];
    } else if([model.prizeStatus isEqualToString:@"N"]) {
        if([[XPLoginModel singleton].isAddress boolValue]) { // 有默认地址
            [self pushViewController:[[self instantiateViewControllerWithStoryboardName:@"Award" identifier:@"Delivery"] tap:^(XPBaseViewController *x) {
                x.model = model;
            }]];
        } else { // 没有默认地址
            [self pushViewController:[[self instantiateViewControllerWithStoryboardName:@"Award" identifier:@"Acquire"] tap:^(XPBaseViewController *x) {
                x.model = model;
            }]];
        }
    }
}

#pragma mark - Event Responds

#pragma mark - Private Methods

#pragma mark - Public Interface

#pragma mark - Getter & Setter

@end
