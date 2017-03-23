//
//  XPAwardAcquireViewController.m
//  XPApp
//
//  Created by xinpinghuang on 1/22/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPAddressViewModel.h"
#import "XPAwardAcquireViewController.h"
#import "XPBaseTableViewCell.h"
#import <XPKit/XPKit.h>

@interface XPAwardAcquireViewController ()<UITableViewDelegate, UITableViewDataSource>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (nonatomic, strong) IBOutlet XPAddressViewModel *viewModel;
#pragma clang diagnostic pop
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation XPAwardAcquireViewController

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
        [self performSegueWithIdentifier:@"embed_delivery" sender:self];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"embed_delivery"]) {
        [(XPBaseViewController *)segue.destinationViewController setModel:self.model];
    }
}

#pragma mark - Delegate
#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(4 > indexPath.row) {
        return 50;
    } else if(4 == indexPath.row) {
        return 100;
    } else if(5 == indexPath.row) {
        return 80;
    }
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XPBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Cell_%ld", (long)indexPath.row] forIndexPath:indexPath];
    if(4 > indexPath.row) {
        [cell bindViewModel:self.viewModel];
    } else if(4 == indexPath.row) {// 保存按钮
        [cell bindViewModel:self.viewModel];
    } else if(5 == indexPath.row) { // 奖品详情
        [cell bindModel:self.model];
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

#pragma mark - Getter & Setter

@end
