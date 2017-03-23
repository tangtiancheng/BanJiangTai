//
//  XPMainGroupShakeViewController.m
//  XPApp
//
//  Created by xinpinghuang on 1/24/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPBaseTableViewCell.h"
#import "XPGroupNotShakeView.h"
#import "XPGroupNotWinningView.h"
#import "XPGroupWinningView.h"
#import "XPMainGroupShakeViewController.h"
#import "XPMainGroupShakeViewModel.h"
#import "XPMotionManager.h"
#import <JZNavigationExtension/UINavigationController+JZExtension.h>
#import <MJRefresh/MJRefresh.h>
#import <XPKit/XPKit.h>

@interface XPMainGroupShakeViewController ()

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (strong, nonatomic) IBOutlet XPMainGroupShakeViewModel *viewModel;
#pragma clang diagnostic pop
@property (nonatomic, weak) IBOutlet UILabel *shakedLabel;
@property (nonatomic, weak) IBOutlet UILabel *ownerLabel;
@property (nonatomic, weak) IBOutlet UIButton *watchMineActivityButton;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation XPMainGroupShakeViewController

#pragma mark - Life Circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView hideEmptySeparators];
    @weakify(self);
    [[self.watchMineActivityButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self watchMineActivityButtonTaped];
    }];
    RAC(self.shakedLabel, text) = [[[RACObserve(self, viewModel.shakedCount) ignore:nil] zipWith:RACObserve(self, viewModel.joinableCount)] map:^id (RACTuple *x) {
        RACTupleUnpack(NSNumber *shakedCount, NSNumber *joinableCount) = x;
        return [NSString stringWithFormat:@" %@ / %@ 个", shakedCount, joinableCount];
    }];
    RAC(self.ownerLabel, text) = [RACObserve(self, viewModel.groupActivityOwnerName) map:^id (id value) {
        return value ? [value stringByAppendingString:@"发起的活动"] : @"";
    }];
    RAC(self.navigationItem, title) = RACObserve(self, viewModel.groupActivityName);
    [self rac_liftSelector:@selector(cleverLoader:) withSignals:RACObserve(self.viewModel, executing), nil];
    [self rac_liftSelector:@selector(showToastWithNSError:) withSignals:[[RACObserve(self.viewModel, error) ignore:nil] map:^id (id value) {
        return value;
    }], nil];
    
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
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self.viewModel.reloadCommand execute:nil];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self.viewModel.moreCommand execute:nil];
    }];
    self.viewModel.groupId = self.model.identifier;
    self.viewModel.groupActivityId = self.model.baseTransfer;
    [self.tableView.mj_header beginRefreshing];
    
    [[RACObserve([XPMotionManager sharedInstance], shaking) ignore:@(NO)] subscribeNext:^(id x) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if(![window viewWithTag:9999]) {
            [[UIApplication sharedApplication] sendSock];
            @strongify(self);
            if(!self.viewModel.joinable) {
                [self showNotShakeTip];
            } else {
                [self.viewModel.shakeCommand execute:nil];
            }
        }
    }];
    [[RACObserve(self, viewModel.win) skip:1] subscribeNext:^(NSNumber *x) {
        @strongify(self);
        [self.tableView.mj_header beginRefreshing];
        if([x boolValue]) {
            [self showWinnningTip];
        } else {
            [self showNotWinnningTip];
        }
    }];
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
- (void)watchMineActivityButtonTaped
{
    [self checkLoginAndPushViewControllerWithStoryboardName:@"Activity"];
}

- (void)popRootButtonTaped
{
    [self popToRoot];
}

#pragma mark - Private Methods
- (void)showNotShakeTip
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    XPGroupNotShakeView *notShakeView = [XPGroupNotShakeView loadFromNib];
    notShakeView.tag = 9999;
    [notShakeView setFrame:window.bounds];
    [window addSubview:notShakeView];
    [notShakeView shakeView];
    
    @weakify(self);
    [[notShakeView.popRootButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [notShakeView removeFromSuperview];
        @strongify(self);
        [self popRootButtonTaped];
    }];
    [notShakeView whenTapped:^{
        [notShakeView removeFromSuperview];
    }];
}

- (void)showNotWinnningTip
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    XPGroupNotWinningView *notWinningView = [XPGroupNotWinningView loadFromNib];
    notWinningView.tag = 9999;
    [notWinningView setFrame:window.bounds];
    [window addSubview:notWinningView];
    [notWinningView shakeView];
    
    @weakify(self);
    [[notWinningView.popRootButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [notWinningView removeFromSuperview];
        @strongify(self);
        [self popRootButtonTaped];
    }];
    [[notWinningView.watchMinePrizeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [notWinningView removeFromSuperview];
        @strongify(self);
        [self checkLoginAndPushViewControllerWithStoryboardName:@"Award"];
    }];
    [notWinningView whenTapped:^{
        [notWinningView removeFromSuperview];
    }];
}

- (void)showWinnningTip
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    XPGroupWinningView *winningView = [XPGroupWinningView loadFromNib];
    winningView.tag = 9999;
    [winningView setFrame:window.bounds];
    [window addSubview:winningView];
    winningView.ownerNameLabel.text = [NSString stringWithFormat:@"恭喜您中奖喽~，快去找[%@]领奖吧。", self.viewModel.groupActivityOwnerName];
    [winningView shakeView];
    
    @weakify(self);
    [[winningView.popRootButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [winningView removeFromSuperview];
        @strongify(self);
        [self popRootButtonTaped];
    }];
    [[winningView.watchMinePrizeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [winningView removeFromSuperview];
        @strongify(self);
        [self checkLoginAndPushViewControllerWithStoryboardName:@"Award"];
    }];
    [winningView whenTapped:^{
        [winningView removeFromSuperview];
    }];
}

#pragma mark - Public Interface

#pragma mark - Getter & Setter

@end
