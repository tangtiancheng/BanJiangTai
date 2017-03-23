//
//  XPMainPlainShakeViewModel.h
//  XPApp
//
//  Created by xinpinghuang on 1/25/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPBaseViewModel.h"
#import "XPMainPlainShakeModel.h"

@interface XPMainPlainShakeViewModel : XPBaseViewModel
//活动ID
@property (nonatomic, strong) NSString *podiumId;
//此次活动已经参加的次数
@property(nonatomic,assign) NSInteger joinNumber;

// 摇奖次数
@property (nonatomic, strong, readonly) XPMainPlainShakeNumberModel *shakeNumerModel;
@property (nonatomic, strong, readonly) RACCommand *shakeNumberCommand;

// 积分兑换
@property (nonatomic, strong) NSString *activeTitle;
@property (nonatomic, strong, readonly) RACCommand *scoreExchangeCommand;

// 摇奖
@property (nonatomic, strong, readonly) XPMainPlainShakeModel *shakeModel;
@property (nonatomic, strong, readonly) RACCommand *shakeCommand;

// 摇奖结果
@property (nonatomic, assign, readonly) BOOL isWinning;/**< 是否中奖 */
@property (nonatomic, strong, readonly) NSString *prizeRule;/**< 奖品领取规则 */
@property (nonatomic, strong, readonly) NSString *adImageURL;/**< 广告图片URL */
@property (nonatomic, strong, readonly) NSString *prizeImageURL;/**< 奖品图片URL */
@property (nonatomic, strong, readonly) NSString *prizeTitle;/**< 奖品名称 */
@property (nonatomic, strong, readonly) NSString *prizeGetTime;/**< 奖品领取时间 */
@property (nonatomic, strong, readonly) NSArray *resultList;
@property (nonatomic, strong, readonly) RACCommand *shakeResultReloadCommand;
@property (nonatomic, strong, readonly) RACCommand *shakeResultMoreCommand;

@property (nonatomic, assign, readonly) BOOL finished;

@end
