//
//  XPPlainShareableAndStartedScrapeView.m
//  XPApp
//
//  Created by 唐天成 on 16/4/3.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "XPPlainShareableAndStartedScrapeView.h"

@implementation XPPlainShareableAndStartedScrapeView
+ (instancetype)loadFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"PlainShareableAndStartedScrape" owner:self options:nil] lastObject];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
