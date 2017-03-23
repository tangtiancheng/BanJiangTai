//
//  XPInviteViewModel.h
//  XPApp
//
//  Created by xinpinghuang on 1/19/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPBaseViewModel.h"
#import "XPInviteModel.h"

@interface XPInviteViewModel : XPBaseViewModel

@property (nonatomic, strong, readonly) XPInviteModel *model;
@property (nonatomic, strong, readonly) RACCommand *inviteCommand;

@end
