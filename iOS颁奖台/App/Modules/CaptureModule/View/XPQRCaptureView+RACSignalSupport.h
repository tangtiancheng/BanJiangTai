//
//  XPQRCaptureView+RACSignalSupport.h
//  XPApp
//
//  Created by huangxinping on 15/5/15.
//  Copyright (c) 2015年 iiseeuu.com. All rights reserved.
//

#import "XPQRCaptureView.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface XPQRCaptureView (RACSignalSupport) <XPQRCaptureViewDelegate>

/**
 *  开始捕获（sendNext为获取到的数据）
 *
 *  @return 信号
 */
- (RACSignal *)rac_startCapture;

@end
