//
//  XPPlainWinningView.m
//  XPApp
//
//  Created by xinpinghuang on 1/25/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import "XPPlainWinningView.h"

@implementation XPPlainWinningView

+ (instancetype)loadFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"PlainWinning" owner:self options:nil] lastObject];
}

@end
