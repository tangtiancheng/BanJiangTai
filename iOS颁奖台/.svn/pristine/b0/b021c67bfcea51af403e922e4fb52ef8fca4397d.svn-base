//
//  XPMainGroupShakeViewModel.h
//  XPApp
//
//  Created by xinpinghuang on 1/24/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPBaseViewModel.h"

@interface XPMainGroupShakeViewModel : XPBaseViewModel

@property (nonatomic, assign, readonly) BOOL finished;
@property (nonatomic, strong) NSString *groupId;
@property (nonatomic, strong) NSString *groupActivityId;
@property (nonatomic, strong, readonly) NSArray *list;
@property (nonatomic, strong, readonly) RACCommand *reloadCommand;
@property (nonatomic, strong, readonly) RACCommand *moreCommand;

@property (nonatomic, strong, readonly) NSString *groupActivityOwnerName;
@property (nonatomic, strong, readonly) NSString *groupActivityName;
@property (nonatomic, assign, readonly) NSInteger shakedCount;
@property (nonatomic, assign, readonly) NSInteger joinableCount;
@property (nonatomic, assign, readonly) BOOL joinable;

@property (nonatomic, strong, readonly) RACCommand *shakeCommand;
@property (nonatomic, assign, readonly) BOOL win;/**< 是否中奖*/

@end
