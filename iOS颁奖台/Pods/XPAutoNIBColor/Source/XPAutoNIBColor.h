//
//  XPAutoNIBColor.h
//  Yulequan
//
//  Created by huangxinping on 4/26/15.
//  Copyright (c) 2015 iiseeuu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XPAutoNIBColor : NSObject

/**
 *  设置项目使用颜色板
 *
 *  @param primaryColor   主色调
 *  @param secondaryColor 副色调
 *  @param tertiaryColor  次色调
 */
+ (void)setAutoNIBColorWithPrimaryColor:(UIColor *)primaryColor secondaryColor:(UIColor *)secondaryColor tertiaryColor:(UIColor *)tertiaryColor, ...NS_REQUIRES_NIL_TERMINATION;

/**
 *  根据名称得到颜色值
 *
 *  @param name 名称  (格式为：c1/c2/c3...）
 *
 *  @return 颜色值
 */
+ (UIColor *)colorWithName:(NSString *)name;

@end
