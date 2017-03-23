
//
//  UITableViewCell+XPKit.m
//  XPKitDemo
//
//  Created by xinpinghuang on 12/21/15.
//  Copyright © 2015 Fabrizio Brancati. All rights reserved.
//

#import "UITableViewCell+XPKit.h"

@implementation UITableViewCell (XPKit)

- (UIView *)suitableSuperView
{
    UITableView *tableView;
    float Version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if(Version >= 7.0) {
        tableView = (UITableView *)self.superview.superview;
    } else {
        tableView = (UITableView *)self.superview;
    }
    
    return tableView;
}

@end
