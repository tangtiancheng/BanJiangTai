//
//  XPGiftViewController.m
//  XPApp
//
//  Created by xinpinghuang on 12/30/15.
//  Copyright 2015 ShareMerge. All rights reserved.
//

#import "XPGiftViewController.h"
#import "XPGiftViewModel.h"
#import <XPKit/XPKit.h>
#import <XPViewPager/XPViewPager.h>

@interface XPGiftViewController ()

@property (nonatomic, strong) XPViewPager *viewPager;

@end

@implementation XPGiftViewController

#pragma mark - Life Circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.viewPager];
    [self.viewPager didSelectedBlock:^(XPViewPager *viewPager, NSInteger index) {
    }];
    
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:XPGiftCreateFinishedNotification object:nil] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewPager setSelectIndex:1];
    }];
}

#pragma mark - Delegate

#pragma mark - Event Responds

#pragma mark - Private Methods

#pragma mark - Public Interface

#pragma mark - Getter & Setter
- (XPViewPager *)viewPager
{
    if(_viewPager == nil) {
        UIViewController *create = [self instantiateViewControllerWithStoryboardName:@"Gift" identifier:@"Create"];
        UIViewController *done = [self instantiateViewControllerWithStoryboardName:@"Gift" identifier:@"Done"];
        _viewPager = [[XPViewPager alloc] initWithFrame:ccr(0, 20+44, self.view.width, self.view.height-20-44) titles:@[@"我要发奖", @"已发奖"] icons:nil selectedIcons:nil views:@[create, done]];
        _viewPager.showVLine = NO;
        _viewPager.tabTitleColor = [UIColor blackColor];
        _viewPager.tabSelectedTitleColor = [UIColor colorWithRed:0.627 green:0.176 blue:0.169 alpha:1.000];
        _viewPager.tabSelectedArrowBgColor = [UIColor colorWithRed:0.784 green:0.259 blue:0.251 alpha:1.000];
        _viewPager.tabArrowBgColor = [UIColor colorWithWhite:0.929 alpha:1.000];
    }
    
    return _viewPager;
}

@end
