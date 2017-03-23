//
//  XPPlainResultNotWinView.m
//  XPApp
//
//  Created by xinpinghuang on 1/25/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import "XPPlainResultNotWinView.h"

@implementation XPPlainResultNotWinView

+ (instancetype)loadFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"PlainResultNotWin" owner:self options:nil] lastObject];
}

@end
