//
//  XPBaseTableViewController.m
//  Huaban
//
//  Created by huangxinping on 4/21/15.
//  Copyright (c) 2015 iiseeuu.com. All rights reserved.
//

#import "XPBaseTableViewController.h"
//
//@interface XPBaseTableViewController ()
//
//@end
//
//@implementation XPBaseTableViewController
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    [self setupTableView];
//}

//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//}
//

//@end








#import "XPAutoNIBColor.h"
#import "XPBaseViewController.h"

#import "XPLoginModel.h"
#import "XPLoginStorage.h"
#import <JZNavigationExtension/UINavigationController+JZExtension.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <XPToast/XPToast.h>

#import <UMengAnalytics-NO-IDFA/MobClick.h>

@interface XPBaseTableViewController ()

@end

@implementation XPBaseTableViewController

#pragma mark - Lifecycle

#pragma mark - View Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTableView];
    self.view.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
    //        self.view.tintColor = [UIColor redColor];
    //    self.navigationController.fullScreenInteractivePopGestureRecognizer = YES;
}
#pragma mark - Setup tableview
- (void)setupTableView
{
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.viewModel.active = YES;
    
    [MobClick beginLogPageView:[self className]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self hideLoader];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.viewModel.active = NO;
    [MobClick endLogPageView:[self className]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Layout

#pragma mark - Public Interface
- (void)bindViewModel:(XPBaseViewModel *)viewModel
{
}

- (void)bindModel:(XPBaseModel *)model
{
}

- (UIViewController *)instantiateInitialViewControllerWithStoryboardName:(NSString *)storyboardName
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle mainBundle]];
    UIViewController *viewController = [storyboard instantiateInitialViewController];
    return viewController;
}

- (UIViewController *)instantiateViewControllerWithStoryboardName:(NSString *)storyboardName identifier:(NSString *)identifier
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle mainBundle]];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:identifier];
    return viewController;
}

- (void)pushViewController:(UIViewController *)viewController
{
    NSAssert(self.navigationController != nil, @"navigationController is nil!");
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)pop
{
    NSAssert(self.navigationController != nil, @"navigationController is nil!");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popToRoot
{
    NSAssert(self.navigationController != nil, @"navigationController is nil!");
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (NSArray *)popToViewController:(UIViewController *)viewController
{
    NSAssert(self.navigationController != nil, @"navigationController is nil!");
    return [self.navigationController popToViewController:viewController animated:YES];
}

#pragma mark - Delegate

#pragma mark - Internal Helpers
@end

@implementation XPBaseTableViewController (Login)

#pragma mark - User Interfaction
- (UIViewController *)presentLogin
{
    [XPLoginStorage clearCached];
    //TODO: Login登录可在任意子类使用
    UIViewController *loginNavigation = [[UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    [self presentViewController:loginNavigation animated:YES completion:^{
    }];
    return loginNavigation;
}

- (void)checkLoginAndPushViewControllerWithStoryboardName:(NSString *)storyboardName
{
    if([XPLoginModel singleton].signIn) {
        [self pushViewController:[self instantiateInitialViewControllerWithStoryboardName:storyboardName]];
    } else {
        [self presentLogin];
    }
}

- (void)checkLoginAndPresentViewControllerWithStoryboardName:(NSString *)storyboardName
{
    if([XPLoginModel singleton].signIn) {
        [self presentViewController:[self instantiateInitialViewControllerWithStoryboardName:storyboardName] animated:YES completion:nil];
    } else {
        [self presentLogin];
    }
}

@end

@implementation XPBaseTableViewController (Loader)

- (void)showLoader
{
    [self showLoaderWithText:@"加载中..."];
}

- (void)showModalLoader
{
    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeGradient];
}

- (void)showLoaderWithText:(NSString *)text
{
    [SVProgressHUD showWithStatus:text];
}

- (void)hideLoader
{
    [SVProgressHUD dismiss];
}

- (void)cleverLoader:(NSNumber *)state
{
    if([state boolValue]) {
        [self showLoader];
    } else {
        [self hideLoader];
    }
}

@end

@implementation XPBaseTableViewController (Toast)

- (void)showToast:(NSString *)text
{
    [XPToast showWithText:text];
}

- (void)showToastWithNSError:(NSError *)error
{
    if(9999 == error.code) {
        [self presentLogin];
        [UIAlertView alertViewWithTitle:nil message:[NSString stringWithFormat:@"你的颁奖台账号于%@在另一个设备登录，如果这不是你的操作，你的账号可能存在被盗取的风险。", [error localizedDescription]] block:^(NSInteger buttonIndex) {
        }
                            buttonTitle:@"确定"];
        return;
    } else if(-1016 == error.code) {
        [UIAlertView alertViewWithTitle:nil message:@"服务器挂掉了或未登陆但请求了需要accessToken的接口!" block:^(NSInteger buttonIndex) {
            exit(0);
        }
                            buttonTitle:@"退出"];
        return;
    } else if(-1004 == error.code || 20310 == error.code) {
        [UIAlertView alertViewWithTitle:nil message:@"服务器挂掉了!" block:^(NSInteger buttonIndex) {
            exit(0);
        }
                            buttonTitle:@"退出"];
        return;
    }
    
    [XPToast showWithText:[error localizedDescription]];
    
}
//获得View的UIViewController
- (UIViewController *)GetviewController {
    UIResponder *responder = self;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]]){
            return (UIViewController *)responder;
        }
    return nil;
}

@end

@implementation XPBaseTableViewController (RACSignal)

- (RACSignal *)rac_Appear
{
    return [[RACSignal
             merge:@[
                     [[self rac_signalForSelector:@selector(viewDidAppear:)] mapReplace:@YES],
                     [[self rac_signalForSelector:@selector(viewWillDisappear:)] mapReplace:@NO]
                     ]]
            setNameWithFormat:@"%@ rac_Appear", self];
}
@end