//
//  XPPlainStartView.m
//  XPApp
//
//  Created by 唐天成 on 16/3/24.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "XPPlainStartView.h"

@implementation XPPlainStartView

+ (instancetype)loadFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"PlainStart" owner:self options:nil] lastObject];
}

@end
