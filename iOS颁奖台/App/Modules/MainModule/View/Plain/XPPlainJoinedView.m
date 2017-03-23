//  XPPlainFinished.m
//  XPApp
//
//  Created by xinpinghuang on 1/24/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import "XPPlainJoinedView.h"

@implementation XPPlainJoinedView

+ (instancetype)loadFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"PlainJoined" owner:self options:nil] lastObject];
}

@end
