//
//  XPAwardViewModel.h
//  XPApp
//
//  Created by xinpinghuang on 1/20/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPBaseViewModel.h"

@interface XPAwardViewModel : XPBaseViewModel

#pragma mark - 奖品列表
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign, readonly) BOOL finished;
@property (nonatomic, strong) NSString *kuaidi100;
@property (nonatomic, strong, readonly) NSArray *list;
@property (nonatomic, strong, readonly) RACCommand *reloadCommand;
@property (nonatomic, strong, readonly) RACCommand *moreCommand;

#pragma mark - 奖品领取
@property (nonatomic, strong) NSString *awardId;
@property (nonatomic, strong) NSString *addressId;
@property (nonatomic, strong) NSString *deliveryDate;
@property (nonatomic, strong) NSString *deliveryTime;
@property (nonatomic, strong, readonly) RACSignal *deliveryValidSignal;
@property (nonatomic, strong, readonly) RACCommand *deliveryCommand;

@end
