//
//  UINavigationController+XPShouldPop.h
//  XPApp
//
//  Created by huangxinping on 5/5/15.
//  Copyright (c) 2015 iiseeuu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UINavigationControllerShouldPop <NSObject>

/**
 *  即将点击回退
 *
 *  @param navigationController 导航控制器
 *
 *  @return 是否能返回
 */
- (BOOL)navigationControllerShouldPop:(UINavigationController *)navigationController;

/**
 *  即将手势回退
 *
 *  @param navigationController 导航控制器
 *
 *  @return 是否能返回
 */
- (BOOL)navigationControllerShouldStartInteractivePopGestureRecognizer:(UINavigationController *)navigationController;

@end

@interface UINavigationController (XPShouldPop) <UIGestureRecognizerDelegate>

@end
