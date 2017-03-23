//
//  UIApplication+RACSignal.h
//  XPApp
//
//  Created by huangxinping on 15/11/14.
//  Copyright © 2015年 ShareMerge. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RACSignal;
@interface UIApplication (RACSignal)

- (RACSignal *)rac_active;

@end
