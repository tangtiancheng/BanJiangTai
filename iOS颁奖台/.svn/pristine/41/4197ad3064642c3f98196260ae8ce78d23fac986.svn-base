//
//  XPMainPlainScrapeViewModel.h
//  XPApp
//
//  Created by 唐天成 on 16/4/3.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "XPBaseViewModel.h"
#import "XPMainPlainScrapeModel.h"

@interface XPMainPlainScrapeViewModel : XPBaseViewModel
//活动ID
@property (nonatomic, strong) NSString *podiumId;
//此次活动已经参加的次数
@property(nonatomic,assign) NSInteger joinNumber;
@property (nonatomic, strong)NSArray* prizeList;


// 摇奖次数
@property (nonatomic, strong, readonly) XPMainPlainScrapeNumberModel *scrapeNumerModel;
@property (nonatomic, strong, readonly) RACCommand *scrapeNumberCommand;
// 摇奖
@property (nonatomic, strong, readonly) XPMainPlainScrapeModel *scrapeModel;
@property (nonatomic, strong, readonly) RACCommand *scrapeCommand;



//// 摇奖结果
//@property (nonatomic, assign, readonly) BOOL isWinning;/**< 是否中奖 */
//@property (nonatomic, strong, readonly) NSString *prizeRule;/**< 奖品领取规则 */
//@property (nonatomic, strong, readonly) NSString *adImageURL;/**< 广告图片URL */
//@property (nonatomic, strong, readonly) NSString *prizeImageURL;/**< 奖品图片URL */
//@property (nonatomic, strong, readonly) NSString *prizeTitle;/**< 奖品名称 */
//@property (nonatomic, strong, readonly) NSString *prizeGetTime;/**< 奖品领取时间 */
//@property (nonatomic, strong, readonly) NSArray *resultList;
////主办方
//@property (nonatomic, strong)NSString* sponsor;
//
//
//@property (nonatomic, assign, readonly) BOOL finished;
//@property (nonatomic, strong, readonly) RACCommand *scrapeResultReloadCommand;

@end
