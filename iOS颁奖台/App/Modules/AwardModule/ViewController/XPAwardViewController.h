//
//  XPAwardViewController.h
//  XPApp
//
//  Created by xinpinghuang on 12/31/15.
//  Copyright 2015 ShareMerge. All rights reserved.
//

#import "XPBaseViewController.h"

@interface XPAwardViewController : XPBaseViewController
//如果是YES,就返回时直接popRoot,no的话就正常
@property(nonatomic,assign)BOOL isAutomaticShake;
@end
