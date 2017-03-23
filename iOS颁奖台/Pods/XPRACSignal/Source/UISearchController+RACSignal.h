//
//  UISearchController+RACSignal.h
//  XPApp
//
//  Created by huangxinping on 15/10/24.
//  Copyright © 2015年 iiseeuu.com. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <UIKit/UIKit.h>

@interface UISearchController (RACSignal)

- (RACSignal *)rac_textSignal NS_AVAILABLE_IOS(8_0);

- (RACSignal *)rac_isActiveSignal NS_AVAILABLE_IOS(8_0);

@end
