//
//  XPQRCaptureView.h
//  XPApp
//
//  Created by huangxinping on 15/5/15.
//  Copyright (c) 2015年 iiseeuu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XPQRCaptureView;
@protocol XPQRCaptureViewDelegate <NSObject>

/**
 *  获取到数据
 *
 *  @param qrView         视图
 *  @param obtainedString 结果数据
 */
- (void)qrView:(XPQRCaptureView *)qrView captureOutput:(NSString *)obtainedString;

@end

@interface XPQRCaptureView : UIView

/**
 *  委托
 */
@property (nonatomic, weak) id <XPQRCaptureViewDelegate> delegate;

/**
 *  开始捕获并设置委托
 *
 *  @param delegate 委托
 */
- (void)startCaptureWithDelegate:(id <XPQRCaptureViewDelegate> )delegate;

/**
 *  开始捕获
 */
- (void)startCapture;

/**
 *  停止捕获
 */
- (void)stopCapture;

@end
