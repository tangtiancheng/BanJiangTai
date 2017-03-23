//
//  RaffleViewModel.h
//  XPApp
//
//  Created by Pua on 16/3/28.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "XPBaseViewModel.h"
#import "RaffleModel.h"
@interface RaffleViewModel : XPBaseViewModel
//活动ID
@property (nonatomic, strong) NSString *podiumId;
//此次活动已经参加的次数
@property(nonatomic,assign) NSInteger joinNumber;
/**
 *  抽奖次数
 */
@property (nonatomic , strong, readonly) RaffleModel * raffleNumModel;
@property (nonatomic , strong, readonly) RACCommand * raffleNumCommand;

/**
 *  抽奖
 */
@property (nonatomic , strong, readonly) RaffleUserModel * raffleModel;
@property (nonatomic , strong, readonly) RACCommand * raffleCommand;

@end
