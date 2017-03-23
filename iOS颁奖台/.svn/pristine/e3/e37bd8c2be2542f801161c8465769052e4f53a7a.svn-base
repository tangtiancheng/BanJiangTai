//
//  XPGiftDoneViewController.m
//  XPApp
//
//  Created by xinpinghuang on 12/30/15.
//  Copyright 2015 ShareMerge. All rights reserved.
//

#import "UIView+XPEmptyData.h"
#import "XPBaseTableViewCell.h"
#import "XPGiftDoneViewController.h"
#import "XPGiftViewModel.h"
#import <MJRefresh/MJRefresh.h>
#import <XPKit/XPKit.h>
#import "XPGiftTableViewCell.h"
#import "XPToast.h"
#import "XPGiftModel.h"
#import "XPLoginModel.h"
#import "NSObject+XPShareSDK.h"
#import "XPInviteModel.h"
#import "NSString+XPPrivacyPhone.h"

@interface XPGiftDoneViewController ()

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (nonatomic, strong) IBOutlet XPGiftViewModel *viewModel;
#pragma clang diagnostic pop
@property (nonatomic, weak) IBOutlet UITableView *tableView;


@property (nonatomic, strong)NSString* inviteId;

@end

@implementation XPGiftDoneViewController

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
    [self.tableView.mj_header beginRefreshing];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:XPGiftCreateFinishedNotification object:nil] subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView.mj_header beginRefreshing];
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
    XPGiftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [cell bindModel:self.viewModel.list[indexPath.row]];
//    XPGiftTableViewCell* giftCell=(XPGiftTableViewCell*)cell;
    @weakify(self)
    [[cell.shareButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self shareButtonTaped: cell];
    }];
    return cell;
}
#pragma mark - Private Methods
- (void)shareButtonTaped:(XPGiftTableViewCell*)giftTableViewCell
{
    XPGiftModel* giftModel= giftTableViewCell.model;
    
    if(! giftModel.prizesImage || !giftModel ) {
        [XPToast showWithText:@"没有图片，无法分享."];
        return;
    }
    [self.viewModel.inviteCommand execute:nil];
    @weakify(self)
   
    [[[RACObserve(self.viewModel, inviteModel.inviteId)ignore:nil] take:1] subscribeNext:^(NSString* x) {
        @strongify(self)
        NSLog(@"nihaoshabi%@",x);
        [[self shareWithTitle:giftModel.activeTitle content:giftModel.shareContent images:@[giftModel.prizesImage] url:[[giftModel.shareUrl removeWhitespaceAndNewline] stringByAppendingFormat:@"?fromUserid=%@&groupid=%@&activityTime=%@&activityId=%@&fromUserPhone=%@&id=%@", [XPLoginModel singleton].userId, giftModel.groupId, [giftModel.sendPrizesTime urlEncode], giftTableViewCell.model.sendPrizesId,  [giftModel.sendPersonalPhone      privacyPhone],x] platformType:SSDKPlatformSubTypeWechatSession] subscribeNext:^(id x) {
        }];
        self.viewModel.inviteModel=nil;
        
    }];
    
    
    
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
