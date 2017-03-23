//
//  UILabel+QREncode.m
//  XPQRCode
//
//  Created by huangxinping on 15/10/4.
//  Copyright © 2015年 ShareMerge. All rights reserved.
//

#import "UILabel+QREncode.h"
#import "NSString+QREncode.h"

@implementation UILabel (QREncode)

- (UIImage *)qr_encode {
    return [self.text qr_encode];
}

@end
