//
//  UIButton+QREncode.m
//  XPQRCode
//
//  Created by huangxinping on 15/10/4.
//  Copyright © 2015年 ShareMerge. All rights reserved.
//

#import "UIButton+QREncode.h"
#import "NSString+QREncode.h"

@implementation UIButton (QREncode)

- (UIImage *)qr_encode {
    return [self.currentTitle qr_encode];
}

@end
