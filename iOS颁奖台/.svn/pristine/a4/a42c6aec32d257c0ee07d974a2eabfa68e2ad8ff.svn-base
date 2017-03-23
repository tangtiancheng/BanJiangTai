//
//  XPNoticeViewModel.h
//  XPApp
//
//  Created by xinpinghuang on 12/21/15.
//  Copyright 2015 ShareMerge. All rights reserved.
//

#import "XPBaseViewModel.h"

@interface XPNoticeViewModel : XPBaseViewModel

@property (nonatomic, assign, readonly) BOOL finished;

#pragma mark - 列表
@property (nonatomic, strong, readonly) NSArray *banners;
@property (nonatomic, strong, readonly) NSArray *list;
@property (nonatomic, strong, readonly) RACCommand *reloadCommand;
@property (nonatomic, strong, readonly) RACCommand *moreCommand;

#pragma mark - 详情
@property (nonatomic, strong, readonly) NSString *detailImageURL;
@property (nonatomic, strong, readonly) NSString *prizeRuleURL;
@property (nonatomic, strong, readonly) NSArray *detailList;
@property (nonatomic, strong) NSString *noticeId;
@property (nonatomic, strong, readonly) RACCommand *detailReloadCommand;
@property (nonatomic, strong, readonly) RACCommand *detailMoreCommand;

#pragma mark - 加入群组
@property (nonatomic, strong) NSString *fromUserId;
@property (nonatomic, strong) NSString *groupId;
@property (nonatomic, assign, readonly) BOOL groupJoinFinished;
@property (nonatomic, strong, readonly) RACCommand *groupJoinCommand;

@end
