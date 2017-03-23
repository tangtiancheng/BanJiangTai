/**
 *  XPTextView.h
 *  ShareMerge
 *
 *  Created by huangxp on 12-1-10.
 *
 *  扩展textview，使其支持placeholder
 *
 *  Copyright (c) www.sharemerge.com. All rights reserved.
 */

/** @file */    // Doxygen marker

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface XPTextView : UITextView

@property (nonatomic, copy)IBInspectable NSString *placeholder;/**< placeholder文字信息 */
@property (nonatomic, strong)IBInspectable UIColor *placeholderColor; /**< placeholder文字颜色 */
@property (nonatomic, assign)IBInspectable NSInteger maxInputLength; /**< 最大输入文字数量 */
@property (nonatomic, assign)IBInspectable BOOL showInputting; /**< 是否右下角显示输入提醒，默认为NO */

/**
 *  设置光标到结尾
 */
- (void)setCursorToEnd;

@end
