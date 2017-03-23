//
//  XPMeViewModel.h
//  XPApp
//
//  Created by xinpinghuang on 2/16/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPBaseViewModel.h"
#import "XPMainModel.h"
#import "XPMainViewModel.h"
@interface XPMeViewModel : XPBaseViewModel

//用户是否签到
@property (nonatomic, assign)NSInteger isSignIn;
//此次签到获得的金币数
@property(nonatomic,assign)NSInteger signCoinNum;

@property (nonatomic, strong) UIImage *avatarImage;

@property (nonatomic, strong, readonly) RACCommand *submitCommand;



#pragma mark - 用户签到
@property (nonatomic, strong, readonly) RACCommand *signInCommand;
//这个model是我点击签到后获得的数据模型
@property (nonatomic, strong)XPMainSignInModel* signInModel;

@end
