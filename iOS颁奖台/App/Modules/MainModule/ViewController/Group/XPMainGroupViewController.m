//
//  XPMainGroupViewController.m
//  XPApp
//
//  Created by xinpinghuang on 1/23/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPBaseTableViewCell.h"
#import "XPMainGroupModel.h"
#import "XPMainGroupViewController.h"
#import "XPMainGroupViewModel.h"
#import <MJRefresh/MJRefresh.h>
#import <XPKit/XPKit.h>

@interface XPMainGroupViewController ()

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (strong, nonatomic) IBOutlet XPMainGroupViewModel *viewModel;
#pragma clang diagnostic pop
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation XPMainGroupViewController

#pragma mark - Life Circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView hideEmptySeparators];
    [self rac_liftSelector:@selector(cleverLoader:) withSignals:RACObserve(self.viewModel, executing), nil];
    [self rac_liftSelector:@selector(showToastWithNSError:) withSignals:[[RACObserve(self.viewModel, error) ignore:nil] map:^id (id value) {
        return value;
    }], nil];
    
    @weakify(self);
    [[RACObserve(self.viewModel, finished) ignore:@(NO)] subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }];
    [[RACObserve(self.viewModel, list) ignore:nil] subscribeNext:^(id x) {
        @strongify(self);
        self.title = [NSString stringWithFormat:@"%@(%ld人)", self.viewModel.groupName, (long)self.viewModel.groupCount];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    }];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self.viewModel.reloadCommand execute:nil];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self.viewModel.moreCommand execute:nil];
    }];
    self.viewModel.groupId = self.model.identifier;
    [self.tableView.mj_header beginRefreshing];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"embed_shake"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:[self.tableView selectedCell]];
        @weakify(self);
        [(XPBaseViewController *)segue.destinationViewController setModel:[[[XPBaseModel alloc] init] tap:^(XPBaseModel *x) {
            @strongify(self);
            x.identifier = self.viewModel.groupId;
            x.baseTransfer = [(XPMainGroupItemModel *)self.viewModel.list[indexPath.row] groupActivityId];
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
    [cell bindModel:self.viewModel.list[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Event Responds

#pragma mark - Private Methods

#pragma mark - Public Interface

#pragma mark - Getter & Setter

@end
