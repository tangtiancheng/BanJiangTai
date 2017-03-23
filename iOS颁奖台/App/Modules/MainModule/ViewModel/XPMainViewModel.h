//
//  XPMainViewModel.h
//  XPApp
//
//  Created by huangxinping on 15/10/16.
//  Copyright © 2015年 iiseeuu.com. All rights reserved.
//

#import "XPBaseViewModel.h"
#import "XPMainModel.h"
@interface XPMainViewModel : XPBaseViewModel

@property (nonatomic, assign, readonly) BOOL finished;

#pragma mark - 列表
@property (nonatomic, strong, readonly) NSArray *banners;
@property (nonatomic, strong, readonly) NSArray *list;

//用户是否签到
@property (nonatomic, assign)NSInteger isSignIn;
//此次签到获得的金币数
@property(nonatomic,assign)NSInteger signCoinNum;
//已经连续签到的天数
@property(nonatomic,copy) NSString* continuousDays;
//要求要达到的连续签到天数
@property(nonatomic,copy) NSString* continuousTotalDays;

@property (nonatomic, strong, readonly) RACCommand *reloadCommand;
@property (nonatomic, strong, readonly) RACCommand *moreCommand;

#pragma mark - 获取用户信息
@property (nonatomic, strong, readonly) RACCommand *userInfoCommand;
#pragma mark - 用户签到
@property (nonatomic, strong, readonly) RACCommand *signInCommand;

#pragma mark - 用户参与活动(抽奖)
@property (nonatomic , strong,readonly) RACCommand *UserActivityCommandDraw;
//这个model是我点击签到后获得的数据模型
@property (nonatomic, strong,readonly)XPMainSignInModel* signInModel;


#pragma mark - 加入群组
@property (nonatomic, strong) NSString *fromUserId;
@property (nonatomic, strong) NSString *groupId;
@property (nonatomic, assign, readonly) BOOL groupJoinFinished;
@property (nonatomic, strong, readonly) RACCommand *groupJoinCommand;

@end
