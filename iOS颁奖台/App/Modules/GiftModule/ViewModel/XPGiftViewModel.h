//
//  XPGiftViewModel.h
//  XPApp
//
//  Created by xinpinghuang on 1/21/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPBaseViewModel.h"
@class XPInviteModel;

UIKIT_EXTERN NSString *const XPGiftCreateFinishedNotification;

@interface XPGiftViewModel : XPBaseViewModel

@property (nonatomic, assign, readonly) BOOL finished;

#pragma mark - 已发奖
@property (nonatomic, strong, readonly) NSArray *list;
@property (nonatomic, strong, readonly) RACCommand *reloadCommand;
@property (nonatomic, strong, readonly) RACCommand *moreCommand;

#pragma makr - 发奖
@property (nonatomic, strong) NSString *activityName;
@property (nonatomic, strong) NSString *giftName;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, strong) NSString *createUserPhone;
@property (nonatomic, strong) NSString *createUserNick; // 可能为手机号
@property (nonatomic, strong) NSString *groupId;
@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, strong, readonly) RACSignal *createNextValidSignal;
@property (nonatomic, assign, readonly) BOOL createFinished;
@property (nonatomic, strong, readonly) RACSignal *createValidSignal;
@property (nonatomic, strong, readonly) RACCommand *createCommand; // 提交发奖

#pragma mark - 群组
@property (nonatomic, strong, readonly) NSArray *groupList;
@property (nonatomic, strong, readonly) RACCommand *groupReloadCommand;
@property (nonatomic, strong, readonly) RACCommand *groupMoreCommand;
@property (nonatomic, assign, readwrite) BOOL groupCreateFinished;
@property (nonatomic, assign, readonly) BOOL groupListFinished;
@property (nonatomic, strong, readonly) RACCommand *groupCreateCommand; // 群组创建


@property (nonatomic, strong) XPInviteModel *inviteModel;
@property (nonatomic, strong, readonly) RACCommand *inviteCommand;
@end
