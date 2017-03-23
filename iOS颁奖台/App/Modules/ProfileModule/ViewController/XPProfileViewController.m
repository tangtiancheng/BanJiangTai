//
//  XPProfileViewController.m
//  XPApp
//
//  Created by xinpinghuang on 12/29/15.
//  Copyright 2015 ShareMerge. All rights reserved.
//

#import "XPBaseNavigationViewController.h"
#import "XPBaseTabBarViewController.h"
#import "XPBaseTableViewCell.h"
#import "XPProfileViewController.h"
#import "XPProfileViewModel.h"
#import <JZNavigationExtension/JZNavigationExtension.h>
#import <XPAlertController/XPAlertController.h>
#import <XPShouldPop/UINavigationController+XPShouldPop.h>
#import "XPChangePhoneViewController.h"

@interface XPProfileViewController ()<UITableViewDelegate, UITableViewDataSource, UINavigationControllerShouldPop, XPAlertControllerDelegate>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (strong, nonatomic) IBOutlet XPProfileViewModel *viewModel;
#pragma clang diagnostic pop
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) XPAlertController *alertController;

@end

@implementation XPProfileViewController

#pragma mark - Life Circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self rac_liftSelector:@selector(cleverLoader:) withSignals:RACObserve(self.viewModel, executing), nil];
    [self rac_liftSelector:@selector(showToastWithNSError:) withSignals:[[RACObserve(self.viewModel, error) ignore:nil] map:^id (id value) {
        return value;
    }], nil];
    
    self.navigationItem.rightBarButtonItem.rac_command = self.viewModel.submitCommand;
    @weakify(self);
    [[self.viewModel.submitCommand executing] subscribeNext:^(id x) {
        @strongify(self);
        [self.view endEditing:YES];
    }];
    
    [[RACObserve(self.viewModel, finished) ignore:@(NO)] subscribeNext:^(id x) {
        @strongify(self);
        [self popAndPresentLogin];
    }];
}

#pragma mark - Delegate
#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(0 == section) {
        return CGFLOAT_MIN;
    }
    
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(0 == section) {
        return 5;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XPBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Cell_%ld_%ld", (long)indexPath.section, (long)indexPath.row] forIndexPath:indexPath];
    if(0 == indexPath.section) {
        switch(indexPath.row) {
            case 0: { // 头像
                [cell bindViewModel:self.viewModel];
            }
                break;
                
            case 1: { // 昵称
                [cell bindViewModel:self.viewModel];
            }
                break;
                
            case 2: { // 手机号
            }
                break;
                
                //            case 3: { // 用户ID
                //            }
                //                break;
                
            case 3: { // 性别
                [cell bindViewModel:self.viewModel];
            }
                break;
                
            case 4: { // 出生日期
                [cell bindViewModel:self.viewModel];
            }
                break;
                
            default: {
            }
                break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(1 == indexPath.section && 0 == indexPath.row) {
        [self pushViewController:[self instantiateInitialViewControllerWithStoryboardName:@"Address"]];
    } else if(2 == indexPath.section && 0 == indexPath.row) {
        [self logoutTaped];
    
    }else if(0 == indexPath.section && 2 == indexPath.row){
         @weakify(self)
        XPChangePhoneViewController* changePhoneViewController=[[[XPChangePhoneViewController alloc]init]tap:^(XPBaseViewController *x) {
            @strongify(self)
            x.model = [[[XPBaseModel alloc] init] tap:^(XPBaseModel *x) {
                @strongify(self);
                //                x.identifier = self.viewModel.ruleURL;
                
                RAC(x,identifier)=[RACObserve([XPLoginModel singleton], userPhone) ignore:nil];
//                x.baseTransfer = @"奖金币规则";
            }];
        }];
;
        [self pushViewController:changePhoneViewController];
    }
}

#pragma mark - UINavigationControllerShouldPop Delegate
- (BOOL)navigationControllerShouldPop:(UINavigationController *)navigationController
{
    return YES;
}

- (BOOL)navigationControllerShouldStartInteractivePopGestureRecognizer:(UINavigationController *)navigationController
{
    return YES;
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
