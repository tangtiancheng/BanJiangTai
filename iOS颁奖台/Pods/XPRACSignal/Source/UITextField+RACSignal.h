//
//  UITextField+RACSignal.h
//  XPApp
//
//  Created by xinpinghuang on 12/7/15.
//  Copyright © 2015 iiseeuu.com. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <UIKit/UIKit.h>

@interface UITextField (RACSignal)

- (RACSignal *)rac_sendSignal;

@end
