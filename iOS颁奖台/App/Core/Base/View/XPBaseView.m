//
//  XPBaseView.m
//  Huaban
//
//  Created by huangxinping on 4/21/15.
//  Copyright (c) 2015 iiseeuu.com. All rights reserved.
//

#import "XPBaseView.h"

@interface XPBaseView ()

@end

@implementation XPBaseView

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0 ? YES : NO;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = [borderColor copy];
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

- (void)bindViewModel:(XPBaseViewModel *)viewModel
{
    XPLogError(@"Opps，you must implement sub class.");
}

- (void)bindModel:(XPBaseModel *)model
{
    XPLogError(@"Opps，you must implement sub class.");
}

@end
