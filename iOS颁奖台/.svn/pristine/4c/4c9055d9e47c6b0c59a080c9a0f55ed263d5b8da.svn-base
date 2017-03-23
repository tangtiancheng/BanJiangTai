//
//  XPAwardUseTicketTableViewCell.h
//  XPApp
//
//  Created by 唐天成 on 16/3/28.
//  Copyright © 2016年 ShareMerge. All rights reserved.
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
@interface XPAwardUseTicketTableViewCell : XPBaseTableViewCell
@property (nonatomic, assign) XPAwardType type;/**< 设置操作类型 */
@end
