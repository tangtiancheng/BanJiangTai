//
//  XPNoticeViewController.m
//  XPApp
//
//  Created by xinpinghuang on 12/21/15.
//  Copyright 2015 ShareMerge. All rights reserved.
//

#import "NSString+XPCaptureAnalyse.h"
#import "UIView+XPEmptyData.h"
#import "XPBaseTableViewCell.h"
#import "XPCaptureViewController.h"
#import "XPLoginModel.h"
#import "XPNoticeHeadTableViewCell.h"
#import "XPNoticeModel.h"
#import "XPNoticeViewController.h"
#import "XPNoticeViewModel.h"
#import <MJRefresh/MJRefresh.h>
#import <XPKit/XPKit.h>

@interface XPNoticeViewController ()

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (nonatomic, strong) IBOutlet XPNoticeViewModel *viewModel;
#pragma clang diagnostic pop
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) XPCaptureViewController *captureViewController;

@end

@implementation XPNoticeViewController

#pragma mark - Life Circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView hideEmptySeparators];
    
    @weakify(self);
    self.navigationItem.leftBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [[RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
            @strongify(self);
            if([XPLoginModel singleton].signIn) {
                self.captureViewController = (XPCaptureViewController *)[self instantiateInitialViewControllerWithStoryboardName:@"Capture"];
                [[self.captureViewController rac_captureOutput] subscribeNext:^(id x) {
                    NSArray *buffer = [x xp_captureAnalyse];
                    if(buffer && 2 == buffer.count) {
                        self.viewModel.fromUserId = buffer[0];
                        self.viewModel.groupId = buffer[1];
                        [self.viewModel.groupJoinCommand execute:nil];
                    }
                }];
                
                [self pushViewController:self.captureViewController];
            } else {
                [self presentLogin];
            }
            
            [subscriber sendNext:@YES];
            [subscriber sendCompleted];
            return nil;
        }] then:^RACSignal *{
            @strongify(self);
            return [[self rac_signalForSelector:@selector(viewDidAppear:)] take:1];
        }];
    }];
    self.navigationItem.rightBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [[RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
            @strongify(self);
            if([XPLoginModel singleton].signIn) {
                [self pushViewController:[self instantiateInitialViewControllerWithStoryboardName:@"Message"]];
            } else {
                [self presentLogin];
            }
            
            [subscriber sendNext:@YES];
            [subscriber sendCompleted];
            return nil;
        }] then:^RACSignal *{
            @strongify(self);
            return [[self rac_signalForSelector:@selector(viewDidAppear:)] take:1];
        }];
    }];
    
    [self rac_liftSelector:@selector(cleverLoader:) withSignals:RACObserve(self.viewModel, executing), nil];
    [self rac_liftSelector:@selector(showToastWithNSError:) withSignals:[[RACObserve(self.viewModel, error) ignore:nil] map:^id (id value) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        return value;
    }], nil];
    
    [[RACObserve(self.viewModel, groupJoinFinished) ignore:@(NO)] subscribeNext:^(id x) {
        @strongify(self);
        XPBaseViewController *viewController = (XPBaseViewController *)[self instantiateViewControllerWithStoryboardName:@"Main" identifier:@"GroupList"];
        [viewController setModel:[[[XPBaseModel alloc] init] tap:^(XPBaseModel *x) {
            @strongify(self);
            x.identifier = self.viewModel.groupId;
        }]];
        [self pushViewController:viewController];
    }];
    
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
    [self.tableView.mj_header beginRefreshing];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"embed_detail"]) {
        @weakify(self);
        [(XPBaseViewController *)segue.destinationViewController setModel:[[[XPBaseModel alloc] init] tap:^(XPBaseModel *x) {
            @strongify(self);
            NSIndexPath *indexPath = [self.tableView indexPathForCell:[self.tableView selectedCell]];
            XPNoticeModel *model = self.viewModel.list[indexPath.row-1];
            x.identifier = model.prizeNoticeId;
        }]];
    }
}

#pragma mark - Delegate
#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(0 == indexPath.row) {
        return tableView.width/2;
    }
    
    return 130;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.list.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XPBaseTableViewCell *cell = nil;
    if(0 == indexPath.row) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Head" forIndexPath:indexPath];
        [(XPNoticeHeadTableViewCell *)cell configWithBanners:self.viewModel.banners];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        [cell bindModel:self.viewModel.list[indexPath.row-1]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Event Responds

#pragma mark - Private Methods

#pragma mark - Getter & Setter

@end
