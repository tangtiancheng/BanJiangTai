//
//  UIWebView+RACSignal.h
//  XPApp
//
//  Created by huangxinping on 15/11/13.
//  Copyright © 2015年 ShareMerge. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RACSignal;
@interface UIWebView (RACSignal)

@property (nonatomic, weak) id<UIWebViewDelegate> proxyDelegate;
@property (nonatomic, readonly, retain) RACSignal *rac_canGoBack;
@property (nonatomic, readonly, retain) RACSignal *rac_canGoForward;
@property (nonatomic, readonly, retain) RACSignal *rac_didStartLoad;
@property (nonatomic, readonly, retain) RACSignal *rac_didFinishLoad;
@property (nonatomic, readonly, retain) RACSignal *rac_error;

@end
