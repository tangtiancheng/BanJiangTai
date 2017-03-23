//
//  XPCaptureViewController.h
//  XPApp
//
//  Created by huangxinping on 15/10/20.
//  Copyright © 2015年 iiseeuu.com. All rights reserved.
//

#import "XPBaseViewController.h"

@interface XPCaptureViewController : XPBaseViewController

- (RACSignal *)rac_captureOutput;

@end
