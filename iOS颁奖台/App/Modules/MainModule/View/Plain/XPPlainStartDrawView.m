//
//  XPPlainStartDrawView.m
//  XPApp
//
//  Created by 唐天成 on 16/3/24.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "XPPlainStartDrawView.h"

@implementation XPPlainStartDrawView


+ (instancetype)loadFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"PlainStartDraw" owner:self options:nil] lastObject];
}

@end
