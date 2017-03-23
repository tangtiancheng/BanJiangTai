//
//  XPGiftGroupViewController.m
//  XPApp
//
//  Created by xinpinghuang on 1/23/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPBaseTableViewCell.h"
#import "XPGiftGroupModel.h"
#import "XPGiftGroupTableViewCell.h"
#import "XPGiftGroupViewController.h"
#import "XPGiftViewModel.h"
#import <JZNavigationExtension/UINavigationController+JZExtension.h>
#import <MJRefresh/MJRefresh.h>
#import <XPKit/XPKit.h>

@interface XPGiftGroupViewController ()<UITableViewDelegate, UITableViewDataSource>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (nonatomic, strong) XPGiftViewModel *viewModel;
#pragma clang diagnostic pop
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UISearchDisplayController *searchDisplayController;
@property (nonatomic, strong) NSArray *searchList;

@end

@implementation XPGiftGroupViewController

#pragma mark - Life Circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView hideEmptySeparators];
    [self.searchDisplayController.searchResultsTableView registerNib:[UINib nibWithNibName:@"Group" bundle:[NSBundle mainBundle]]
                                              forCellReuseIdentifier:@"Cell"];
    
    [self rac_liftSelector:@selector(cleverLoader:) withSignals:RACObserve(self.viewModel, executing), nil];
    [self rac_liftSelector:@selector(showToastWithNSError:) withSignals:[[RACObserve(self.viewModel, error) ignore:nil] map:^id (id value) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        return value;
    }], nil];
    
    @weakify(self);
    [[RACObserve(self.viewModel, createFinished) ignore:@(NO)] subscribeNext:^(id x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES completion:^(BOOL finished) {
            [[NSNotificationCenter defaultCenter] postNotificationName:XPGiftCreateFinishedNotification object:nil];
        }];
    }];
    
    [[RACObserve(self.viewModel, groupListFinished) ignore:@(NO)] subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }];
    [[RACObserve(self.viewModel, groupList) ignore:nil] subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    }];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self.viewModel.groupReloadCommand execute:nil];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self.viewModel.groupMoreCommand execute:nil];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"embed_group_create"]) {
        [(XPBaseViewController *)segue.destinationViewController bindViewModel:self.viewModel];
    }
}

#pragma mark - Delegate
#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == self.tableView) {
        return 2;
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.tableView) {
        if(0 == section) {
            return 1;
        }
        
        return self.viewModel.groupList.count;
    }
    
    // 谓词搜索
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@", self.searchDisplayController.searchBar.text];
    NSArray *buffer = [[[self.viewModel.groupList rac_sequence] map:^id (XPGiftGroupModel *value) {
        return value.groupName;
    }] array];
    NSArray *filterBuffer = [[NSArray alloc] initWithArray:[buffer filteredArrayUsingPredicate:predicate]];
    NSMutableArray *filterList = [NSMutableArray array];
    for(NSInteger i = 0; i < self.viewModel.groupList.count; i++) {
        XPGiftGroupModel *groupModel = self.viewModel.groupList[i];
        for(NSInteger j = 0; j < filterBuffer.count; j++) {
            NSString *filterGroupName = filterBuffer[j];
            if([filterGroupName isEqualToString:groupModel.groupName]) {
                [filterList addObject:groupModel];
                break;
            }
        }
    }
    self.searchList = filterList;
    return self.searchList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView == self.tableView) {
        if(0 == section) {
            return CGFLOAT_MIN;
        }
        
        return 25;
    }
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(tableView == self.tableView) {
        if(0 == section) {
            return @"";
        }
        
        return @"已有群组";
    }
    
    return @"";
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView == self.tableView) {
        if(0 == section) {
            return nil;
        }
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(15, 0, 100, 25);
        label.font = [UIFont boldSystemFontOfSize:15];
        label.textColor = [UIColor colorWithWhite:0.514 alpha:1.000];
        label.text = [self tableView:tableView titleForHeaderInSection:section];
        UIView *headerView = [[UIView alloc] init];
        [headerView addSubview:label];
        headerView.backgroundColor = [UIColor colorWithWhite:0.969 alpha:1.000];
        return headerView;
    }
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XPBaseTableViewCell *cell = nil;
    if(tableView == self.tableView) {
        if(0 == indexPath.section) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell_create" forIndexPath:indexPath];
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
            [cell bindModel:self.viewModel.groupList[indexPath.row]];
        }
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        [cell bindModel:self.searchList[indexPath.row]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(tableView == self.tableView) {
        if(0 == indexPath.section && 0 == indexPath.row) {  // 第一行是[创建群组]
            return;
        }
        
        XPGiftGroupModel *model = self.viewModel.groupList[indexPath.row];
        self.viewModel.groupId = model.groupId;
        self.viewModel.groupName = model.groupName;
        [self.viewModel.createCommand execute:nil];
    } else {
        XPGiftGroupModel *model = self.searchList[indexPath.row];
        self.viewModel.groupId = model.groupId;
        self.viewModel.groupName = model.groupName;
        [self.viewModel.createCommand execute:nil];
    }
}

#pragma mark - Event Responds

#pragma mark - Private Methods

#pragma mark - Public Interface
- (void)bindViewModel:(XPGiftViewModel *)viewModel
{
    NSParameterAssert([viewModel isKindOfClass:[XPGiftViewModel class]]);
    self.viewModel = viewModel;
}

#pragma mark - Getter & Setter

@end