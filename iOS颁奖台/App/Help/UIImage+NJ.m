//
//  UIImage+IWAdapter6Or7.m
//  传智WB
//
//  Created by tarena on 15/10/19.
//  Copyright (c) 2015年 唐天成. All rights reserved.
//

#import "UIImage+NJ.h"

@implementation UIImage (IWAdapter6Or7)
+(instancetype)resizableImageNamed:(NSString*)name{
    UIImage *image = [UIImage imageNamed:name];
    CGFloat left = image.size.width * 0.5;
    CGFloat top = image.size.height * 0.5;
    CGFloat bottom=image.size.height * 0.5;
    CGFloat right=image.size.height * 0.5;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right)];
}
+ (instancetype)resizableImageNamed:(NSString *)name left:(CGFloat)leftRatio top:(CGFloat)topRatio botton:(CGFloat)bottomRatio right:(CGFloat)rightRatio
{
    UIImage *image = [UIImage imageNamed:name];
    CGFloat left = image.size.width * leftRatio;
    CGFloat top = image.size.height * topRatio;
    CGFloat bottom=image.size.height * bottomRatio;
     CGFloat right=image.size.height * rightRatio;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right)];
}
@end
