//
//  XPAwardTableViewCell.h
//  XPApp
//
//  Created by xinpinghuang on 12/31/15.
//  Copyright 2015 ShareMerge. All rights reserved.
//

#import "XPBaseTableViewCell.h"

/** 定义操作类型 */
typedef NS_ENUM (NSInteger, XPAwardType) {
    Award_Default = 0,/**< 默认（不显示任何按钮） */
    Award_Get,/**< 领取 */
    Award_Todo_Receive, /**< 未配送 */
    Award_Receive, /**< 配送中 */
    Award_Use /**< 使用 */
};

@interface XPAwardTableViewCell : XPBaseTableViewCell

@property (nonatomic, assign) XPAwardType type;/**< 设置操作类型 */

@end
