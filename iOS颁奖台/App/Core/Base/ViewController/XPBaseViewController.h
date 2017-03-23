//
//  XPBaseViewController.h
//  Huaban
//
//  Created by huangxinping on 4/21/15.
//  Copyright (c) 2015 iiseeuu.com. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <UIKit/UIKit.h>

#import "XPBaseModel.h"
#import "XPBaseReactiveView.h"
#import "XPBaseStorage.h"
#import "XPBaseViewModel.h"

@interface XPBaseViewController : UIViewController<XPBaseReactiveView>

/**
 *  模型
 */
@property (nonatomic, strong) XPBaseModel *model;

/**
 *  ViewModel
 */
@property (nonatomic, strong) XPBaseViewModel *viewModel;

/**
 *  初始化Entry ViewController
 *
 *  @param storyboardName 名称
 *
 *  @return 视图控制器
 */
- (UIViewController *)instantiateInitialViewControllerWithStoryboardName:(NSString *)storyboardName;

/**
 *  初始化ViewController根据标示符
 *
 *  @param storyboardName 名称
 *  @param identifier     标示符
 *
 *  @return 视图控制器
 */
- (UIViewController *)instantiateViewControllerWithStoryboardName:(NSString *)storyboardName identifier:(NSString *)identifier;

/**
 *  导航视图控制器push
 *
 *  @param viewController 目标视图控制器
 */
- (void)pushViewController:(UIViewController *)viewController;

/**
 *  导航视图控制器pop
 */
- (void)pop;

/**
 *  导航视图控制器pop到root
 */
- (void)popToRoot;

/**
 *  导航视图控制器pop到指定viewController
 *
 *  @param viewController 目标视图控制器
 *
 *  @return 被pop的视图控制器组
 */
- (NSArray *)popToViewController:(UIViewController *)viewController;

@end

@interface XPBaseViewController (Login)

/**
 *  弹出Login视图控制器
 */
- (UIViewController *)presentLogin;

/**
 *  push视图控制器，但是先检测是否已经登录，如果未登录则弹出登录界面
 */
- (void)checkLoginAndPushViewControllerWithStoryboardName:(NSString *)storyboardName;

/**
 *  present视图控制器，但是先检测是否已经登录，如果未登录则弹出登录界面
 */
- (void)checkLoginAndPresentViewControllerWithStoryboardName:(NSString *)storyboardName;

@end

@interface XPBaseViewController (Loader)

/**
 *  显示载入器
 */
- (void)showLoader;

/**
 *  显示载入器
 *
 *  @param text 显示的文字
 */
- (void)showLoaderWithText:(NSString *)text;

/**
 *  显示模态载入器
 */
- (void)showModalLoader;

/**
 *  移除载入器
 */
- (void)hideLoader;

/**
 *  聪慧的载入器
 */
- (void)cleverLoader:(NSNumber *)state;

@end

@interface XPBaseViewController (Toast)

/**
 *  显示Toast！0.5秒自动消失
 */
- (void)showToast:(NSString *)text;

/**
 *  从NSError实例中抽取错误信息，然后显示Toast
 */
- (void)showToastWithNSError:(NSError *)error;

@end

@interface XPBaseViewController (RACSignal)

/**
 *  viewDidAppear被触发时返回@YES信号，viewWillDisappear被触发时返回@NO信号
 *
 *  @return 信号
 */
- (RACSignal *)rac_Appear;

@end