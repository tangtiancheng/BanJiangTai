//
//  XPSettingViewController.m
//  XPApp
//
//  Created by xinpinghuang on 12/28/15.
//  Copyright 2015 ShareMerge. All rights reserved.
//

#import "XPBaseNavigationViewController.h"
#import "XPBaseTabBarViewController.h"
#import "XPLoginModel.h"
#import "XPSettingViewController.h"
#import "XPSettingViewModel.h"
#import <JZNavigationExtension/JZNavigationExtension.h>
#import <XPAlertController/XPAlertController.h>
#import <XPKit/XPKit.h>
#import <SDWebImage/SDImageCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface XPSettingViewController ()<UITableViewDelegate, UITableViewDataSource, XPAlertControllerDelegate>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (strong, nonatomic) IBOutlet XPSettingViewModel *viewModel;
#pragma clang diagnostic pop
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIButton *logoutButton;
@property (nonatomic, strong) XPAlertController *alertController;

@end

@implementation XPSettingViewController

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
        [self popAndPresentLogin];
    }];
    
    RAC(self.logoutButton, hidden) = [RACObserve([XPLoginModel singleton], signIn) not];
    
    [[self.logoutButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self logoutTaped];
    }];
    
    
}

#pragma mark - Delegate
#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Cell_%ld", (long)indexPath.row] forIndexPath:indexPath];
    if(indexPath.row==2){
         float tmpSize = [[SDImageCache sharedImageCache] getSize];
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%.2fM",tmpSize/1024/1024];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==2){
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            float tmpSize = [[SDImageCache sharedImageCache] getSize];
            UITableViewCell* cell=[tableView cellForRowAtIndexPath:indexPath];
            cell.detailTextLabel.text=[NSString stringWithFormat:@"%.0fM",tmpSize/1024/1024];
            
            UIImageView* clearTipView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"clearImageSuccess"]];
            clearTipView.center=self.view.center;
            [self.view addSubview:clearTipView];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [clearTipView removeFromSuperview];
            });
            
        }];
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - XPAlertController Delegate
- (UIColor *)alertController:(XPAlertController *)alertController colorWithRow:(NSInteger)row
{
    return [UIColor redColor];
}

- (void)alertController:(XPAlertController *)alertController didSelectRow:(NSInteger)row
{
    [self.viewModel.logoutCommand execute:nil];
}

#pragma mark - Event Responds
- (void)logoutTaped
{
    self.alertController = [[XPAlertController alloc] initWithActivity:@[@"退出登录"] title:@"退出后不会删除任何历史数据，下次登录依然可以使用本账号。"];
    self.alertController.delegate = self;
    [self.alertController show];
}

#pragma mark - Private Methods
- (void)popAndPresentLogin
{
    [self.navigationController popViewControllerAnimated:YES completion:^(BOOL finished) {
        XPBaseTabBarViewController *tabBarViewController = (XPBaseTabBarViewController *)[UIApplication sharedApplication].windows[0].rootViewController;
        [tabBarViewController setSelectedIndex:0];
        XPBaseNavigationViewController *navigationViewController = [tabBarViewController viewControllers][0];
        [(XPBaseViewController *)navigationViewController.topViewController presentLogin];
    }];
}

#pragma mark - Getter & Setter

@end
