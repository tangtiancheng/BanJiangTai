//
//  UIView+XPEmptyData.m
//  XPApp
//
//  Created by xinpinghuang on 2/26/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import "UIView+XPEmptyData.h"
#import "XPEmptyDataView.h"

@interface UIView (_XPEmptyData)

@property (nonatomic, readonly) XPEmptyDataView *emptyDataView;

@end

@implementation UIView (_XPEmptyData)

- (XPEmptyDataView *)emptyDataView
{
    UIView *existingView = [self viewWithTag:80000];
    if(existingView) {
        if(![existingView isKindOfClass:[XPEmptyDataView class]]) {
            NSLog(@"Unexpected view of class %@ found with badge tag.", existingView);
            return nil;
        } else {
            return (XPEmptyDataView *)existingView;
        }
    }
    
    XPEmptyDataView *_emptyDataView = [[[NSBundle mainBundle] loadNibNamed:@"EmptyData" owner:nil options:nil] lastObject];
    _emptyDataView.tag = 80000;
    _emptyDataView.frame = self.bounds;
    return _emptyDataView;
}

@end

@implementation UIView (XPEmptyData)

- (void)showEmptyData
{
    self.emptyDataView.hidden = NO;
    [self addSubview:self.emptyDataView];
    if([self isKindOfClass:[UITableView class]]) {
        self.userInteractionEnabled = NO;
    }
}

- (void)destoryEmptyData
{
    self.emptyDataView.hidden = YES;
    if([self isKindOfClass:[UITableView class]] &&
       !self.userInteractionEnabled) {
        self.userInteractionEnabled = YES;
    }
}

@end
