//
//  XPMainPlainShakeResultViewController.m
//  XPApp
//
//  Created by xinpinghuang on 1/25/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "NSString+XPRemoteImage.h"
#import "XPBaseTableViewCell.h"
#import "XPMainPlainShakeResultViewController.h"
#import "XPMainPlainShakeViewModel.h"
#import "XPPlainResultNotWinView.h"
#import "XPPlainResultWinView.h"
#import <MJRefresh/MJRefresh.h>
#import <XPKit/XPKit.h>
#import <XPShouldPop/UINavigationController+XPShouldPop.h>

@interface XPMainPlainShakeResultViewController ()<UINavigationControllerShouldPop>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (strong, nonatomic) XPMainPlainShakeViewModel *viewModel;
#pragma clang diagnostic pop

@property (nonatomic, weak) IBOutlet UIButton *watchPrizeRuleButton;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) XPPlainResultWinView *resultWinView;
@property (nonatomic, weak) XPPlainResultNotWinView *resultNotWinView;
@property (nonatomic, weak) IBOutlet UIImageView *adImageView;
@property (nonatomic, weak) IBOutlet UIView *resultContentView;

@end

@implementation XPMainPlainShakeResultViewController

#pragma mark - Life Circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    @weakify(self)
    self.navigationItem.title = self.model.identifier;
    //    UILabel *titleView = [[UILabel alloc] initWithFrame:ccr(0, 28, self.view.width, 22)];
    //    titleView.text = self.model.identifier;
    //    titleView.textColor = [UIColor whiteColor];
    //    titleView.font = [UIFont systemFontOfSize:17];
    //    titleView.textAlignment = NSTextAlignmentCenter;
    //    [self.view addSubview:titleView];
    
    
    NSArray *viewControllerArray = [self.navigationController viewControllers];
    long previousViewControllerIndex = [viewControllerArray indexOfObject:self] - 1;
    UIViewController *previous;
    if (previousViewControllerIndex >= 0) {
        previous = [viewControllerArray objectAtIndex:previousViewControllerIndex];
        previous.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                                     initWithTitle:@""
                                                     style:UIBarButtonItemStylePlain
                                                     target:self
                                                     action:nil];
    }

    [self.tableView hideEmptySeparators];
    [self rac_liftSelector:@selector(cleverLoader:) withSignals:RACObserve(self.viewModel, executing), nil];
    [self rac_liftSelector:@selector(showToastWithNSError:) withSignals:[[RACObserve(self.viewModel, error) ignore:nil] map:^id (id value) {
        @strongify(self)
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        return value;
    }], nil];
    
   
    [[RACObserve(self.viewModel, finished) ignore:@(NO)] subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }];
    [[RACObserve(self.viewModel, resultList) ignore:nil] subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    }];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self.viewModel.shakeResultReloadCommand execute:nil];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self.viewModel.shakeResultMoreCommand execute:nil];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    [[self.watchPrizeRuleButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self pushViewController:[[self instantiateInitialViewControllerWithStoryboardName:@"Web"] tap:^(XPBaseViewController *x) {
            x.model = [[[XPBaseModel alloc] init] tap:^(XPBaseModel *x) {
                @strongify(self);
                x.identifier = [self.viewModel.prizeRule stringByAppendingFormat:@"?activityId=%@", self.viewModel.podiumId];
                x.baseTransfer = @"奖品领取规则";
            }];
        }]];
    }];
    
    [[RACObserve(self, viewModel.isWinning) skip:1] subscribeNext:^(id x) {
        @strongify(self);
        [self updateUI];
    }];
    RAC(self.adImageView, image) = [[RACObserve(self, viewModel.adImageURL) flattenMap:^RACStream *(id value) {
        return value ? [value rac_remote_image] : [RACSignal return :nil];
    }] deliverOn:[RACScheduler mainThreadScheduler]];
}


#pragma mark - Delegate
- (BOOL)navigationControllerShouldPop:(UINavigationController *)navigationController
{
    @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self);
        [self pop];
    });
    
    return NO;
}

- (BOOL)navigationControllerShouldStartInteractivePopGestureRecognizer:(UINavigationController *)navigationController
{
    @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self);
        [self pop];
    });
    return NO;
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.resultList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XPBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [cell bindModel:self.viewModel.resultList[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Event Responds

#pragma mark - Private Methods
- (void)updateUI
{
    if(self.viewModel.isWinning) {
        if(!self.resultWinView) {
            self.resultWinView = [XPPlainResultWinView loadFromNib];
            self.resultWinView.frame = ccr(0, 0, self.view.width, 253);
            [self.resultContentView addSubview:self.resultWinView];
            @weakify(self);
            [[self.resultWinView.popRootButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                @strongify(self);
                [self popToRoot];
            }];
            [[self.resultWinView.getButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                @strongify(self);
                [self pushViewController:[self instantiateInitialViewControllerWithStoryboardName:@"Award"]];
            }];
            self.resultWinView.prizeLabel.text = self.viewModel.prizeTitle;
            NSLog(@"%@  %@  %@",self.resultWinView.prizeLabel.text,NSStringFromCGRect(self.resultWinView.prizeLabel.frame),self.viewModel.prizeTitle);
            self.resultWinView.timeLabel.text = self.viewModel.prizeGetTime;
            RAC(self.resultWinView.logoImageView, image) = [[RACObserve(self, viewModel.prizeImageURL) flattenMap:^RACStream *(id value) {
                return value ? [value rac_remote_image] : [RACSignal return :nil];
            }] deliverOn:[RACScheduler mainThreadScheduler]];
        }
    } else {
        if(!self.resultNotWinView) {
            self.resultNotWinView = [XPPlainResultNotWinView loadFromNib];
            self.resultNotWinView.frame = ccr(0, 0, self.view.width, 253);
            [self.resultContentView addSubview:self.resultNotWinView];
            @weakify(self);
            [[self.resultNotWinView.popRootButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                @strongify(self);
                [self popToRoot];
            }];
            [[self.resultNotWinView.watchPrizeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                @strongify(self);
                [self pushViewController:[self instantiateInitialViewControllerWithStoryboardName:@"Award"]];
            }];
            RAC(self.resultNotWinView.logoImageView, image) = [[RACObserve(self, viewModel.prizeImageURL) flattenMap:^RACStream *(id value) {
                return value ? [value rac_remote_image] : [RACSignal return :nil];
            }] deliverOn:[RACScheduler mainThreadScheduler]];
        }
    }
}

#pragma mark - Public Interface
- (void)bindViewModel:(XPMainPlainShakeViewModel *)viewModel
{
    NSParameterAssert([viewModel isKindOfClass:[XPMainPlainShakeViewModel class]]);
    self.viewModel = viewModel;
}

#pragma mark - Getter & Setter
-(void)dealloc{
    NSLog(@"xiaohui");
}
@end
