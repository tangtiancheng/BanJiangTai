//
//  XPPlainScoreExchangeView.m
//  XPApp
//
//  Created by xinpinghuang on 1/25/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import "XPPlainScoreExchangeView.h"

@implementation XPPlainScoreExchangeView

+ (instancetype)loadFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"PlainScoreExchange" owner:self options:nil] lastObject];
}

@end
