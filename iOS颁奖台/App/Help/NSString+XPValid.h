//
//  NSString+XPValid.h
//  XPApp
//
//  Created by huangxinping on 15/9/25.
//  Copyright © 2015年 iiseeuu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XPValid)

/**
 *  是否有效手机号
 */
- (BOOL)isPhone;

/**
 *  是否有效QQ
 */
- (BOOL)isQQ;

/**
 *  是否有效生日
 */
- (BOOL)isBirthday;

@end
