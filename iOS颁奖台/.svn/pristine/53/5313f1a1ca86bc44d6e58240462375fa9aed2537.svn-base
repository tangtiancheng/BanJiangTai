//
//  XPAwardDeliverySuccessViewController.m
//  XPApp
//
//  Created by xinpinghuang on 1/22/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPAwardDeliverySuccessViewController.h"
#import "XPBaseTabBarViewController.h"
#import <JZNavigationExtension/JZNavigationExtension.h>
#import <XPKit/XPKit.h>
#import <XPShouldPop/UINavigationController+XPShouldPop.h>
#import "XPAwardViewController.h"
@interface XPAwardDeliverySuccessViewController ()<UINavigationControllerShouldPop>

@property (nonatomic, weak) IBOutlet UIButton *lookAwardListButton;
@property (nonatomic, weak) IBOutlet UIButton *backTopButton;

@end

@implementation XPAwardDeliverySuccessViewController

#pragma mark - Life Circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    @weakify(self);
    [[self.lookAwardListButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self lookAwardListTaped];
    }];
    [[self.backTopButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self backTopTaped];
    }];
}

#pragma mark - Delegate
- (BOOL)navigationControllerShouldPop:(UINavigationController *)navigationController
{
    @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self);
        [self lookAwardListTaped];
    });
    return NO;
}

- (BOOL)navigationControllerShouldStartInteractivePopGestureRecognizer:(UINavigationController *)navigationController
{
    return NO;
}

#pragma mark - Event Responds

#pragma mark - Private Methods
- (void)lookAwardListTaped
{
   
    for(UIViewController* VC in self.navigationController.viewControllers){
        if([VC isKindOfClass:[XPAwardViewController class]]){
            [self.navigationController popToViewController:VC animated:YES completion:^(BOOL finished) {
            }];
            break;
        }
        
    }
//    [self.navigationController popToViewController:self.navigationController.viewControllers[index-3] animated:YES completion:^(BOOL finished) {
//    }];
}

- (void)backTopTaped
{
    [self.navigationController popToRootViewControllerAnimated:YES completion:^(BOOL finished) {
        XPBaseTabBarViewController *tabBarViewController = (XPBaseTabBarViewController *)[UIApplication sharedApplication].windows[0].rootViewController;
        [tabBarViewController setSelectedIndex:0];
    }];
}

#pragma mark - Public Interface

#pragma mark - Getter & Setter

@end
