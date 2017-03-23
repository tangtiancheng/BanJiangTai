//
//  XPGroupNotWinningView.m
//  XPApp
//
//  Created by xinpinghuang on 1/24/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import "XPGroupNotWinningView.h"

@implementation XPGroupNotWinningView

+ (instancetype)loadFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"GroupNotWinning" owner:self options:nil] lastObject];
}

@end
