//
//  XPMessageViewModel.h
//  XPApp
//
//  Created by xinpinghuang on 1/23/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPBaseViewModel.h"

@interface XPMessageViewModel : XPBaseViewModel

#pragma mark - 列表
@property (nonatomic, assign, readonly) BOOL finished;
@property (nonatomic, strong, readonly) NSArray *list;
@property (nonatomic, strong, readonly) RACCommand *reloadCommand;
@property (nonatomic, strong, readonly) RACCommand *moreCommand;

#pragma mark - 设置已读
@property (nonatomic, strong) NSString *messageId;
@property (nonatomic, assign, readonly) BOOL readedFinished;
@property (nonatomic, strong, readonly) RACCommand *readedCommand;
@end
