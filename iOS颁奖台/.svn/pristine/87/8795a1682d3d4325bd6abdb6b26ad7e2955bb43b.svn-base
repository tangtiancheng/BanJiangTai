//
//  UITextField+LimitLength.h
//  JRFProject
//
//  Created by feng jia on 15-2-6.
//  Copyright (c) 2015年 company. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^xp_EditEndBlock)(NSString *text
                                );

@interface UITextField (LimitLength)
/**
 *  使用时只要调用此方法，加上一个长度(int)，就可以实现了字数限制, block是编辑结束后的厚点
 *
 *  @param length
 *  @param block
 */
- (void)xp_limitTextLength:(int)length block:(xp_EditEndBlock)block;
/**
 *  uitextField 抖动效果
 */
- (void)xp_shake;
@end
