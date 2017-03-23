//
//  XPAwardDateViewController.h
//  XPApp
//
//  Created by xinpinghuang on 1/22/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XPAwardDateViewController;
@protocol XPAwardDateViewControllerDelegate <NSObject>

@optional
- (void)dateChoiceDidCanceled:(nullable XPAwardDateViewController *)dateChoicePickView;

- (void)dateChoicePickView:(nullable XPAwardDateViewController *)dateChoicePickView date:(nonnull NSString *)date timeRange:(nonnull NSString *)timeRange;

@end

@interface XPAwardDateViewController : UIWindow

- (nonnull instancetype)initWithDelegate:(nullable id<XPAwardDateViewControllerDelegate>)delegate;

- (void)show;

@end
