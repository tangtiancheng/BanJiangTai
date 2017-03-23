//
//  XPLoginViewModel.h
//  XPApp
//
//  Created by huangxinping on 15/9/23.
//  Copyright © 2015年 iiseeuu.com. All rights reserved.
//

#import "XPBaseViewModel.h"

@class XPLoginModel;
@interface XPLoginViewModel : XPBaseViewModel

@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *captcha;
@property (nonatomic, assign) BOOL agreement;

//是否成功
@property(nonatomic,assign) BOOL changePhoneSuccess;


@property (nonatomic, strong, readonly) RACCommand *signInCommand;
@property (nonatomic, strong, readonly) RACCommand *captchaCommand;
@property (nonatomic, strong, readonly) RACSignal *phoneValidSignal;


@property(nonatomic,strong,readonly) RACCommand* changePhoneNumCommand;

@property (nonatomic, strong, readonly) XPLoginModel *model;

@end
