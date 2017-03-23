//
//  UIView+XPBadgeView.m
//  XPApp
//
//  Created by xinpinghuang on 12/30/15.
//  Copyright © 2015 ShareMerge. All rights reserved.
//

#import "UIView+XPBadgeView.h"

@implementation UIView (XPBadgeView)

- (M13BadgeView *)badge
{
    UIView *existingView = [self viewWithTag:65535];
    if(existingView) {
        if(![existingView isKindOfClass:[M13BadgeView class]]) {
            NSLog(@"Unexpected view of class %@ found with badge tag.", existingView);
            return nil;
        } else {
            return (M13BadgeView *)existingView;
        }
    }
    
    M13BadgeView *badgeView = [[M13BadgeView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    badgeView.tag = 65535;
    [self addSubview:badgeView];
    return badgeView;
}

@end
