//
//  XPMainViewController+XPAutoLogin.m
//  XPApp
//
//  Created by xinpinghuang on 1/19/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import "XPLoginModel.h"
#import "XPLoginStorage.h"
#import "XPMainViewController+XPAutoLogin.h"
#import "XPMainViewModel.h"

@implementation XPMainViewController (XPAutoLogin)

- (void)autoLogin
{
    if(![XPLoginStorage cached]) {
        XPLogError(@"没有缓存过登录信息！");
        //        [XPLoginStorage storageWithUser:[[[XPUser alloc] init] tap:^(XPUser *x) {
        //            x.phone = @"15295521752";
        //            x.accessToken = @"U2BeBVqLkXmz5l4L3E";
        //            x.userId = @"e7d3a4407bb74b568c79151864649b00";
        //        }]];
        return;
    }
    
    XPUser *user = [XPLoginStorage userWithRowLogin];
    [XPLoginModel singleton].userPhone = user.phone;
    [XPLoginModel singleton].accessToken = user.accessToken;
    [XPLoginModel singleton].userId = user.userId;
    [[(XPMainViewModel *)self.viewModel userInfoCommand] execute:nil];
}

@end
