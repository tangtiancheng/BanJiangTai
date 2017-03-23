//
//  UISearchController+RACSignal.m
//  XPApp
//
//  Created by huangxinping on 15/10/24.
//  Copyright © 2015年 iiseeuu.com. All rights reserved.
//

#import "UISearchController+RACSignal.h"
#import <objc/runtime.h>

@interface UISearchController ()
<UISearchResultsUpdating, UISearchControllerDelegate>

@end

@implementation UISearchController (RACSignal)

- (RACSignal *)rac_textSignal
{
    self.searchResultsUpdater = self;
    RACSignal *signal = objc_getAssociatedObject(self, _cmd);
    if(signal != nil) {
        return signal;
    }
    
    signal = [[[self rac_signalForSelector:@selector(updateSearchResultsForSearchController:) fromProtocol:@protocol(UISearchResultsUpdating)] map:^id (RACTuple *tuple) {
        UISearchController *searchController = tuple.first;
        return searchController.searchBar.text;
    }] setNameWithFormat:@"%@ - rac_textSignal", self];
    
    objc_setAssociatedObject(self, _cmd, signal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return signal;
}

- (RACSignal *)rac_isActiveSignal
{
    self.delegate = self;
    RACSignal *signal = objc_getAssociatedObject(self, _cmd);
    if(signal != nil) {
        return signal;
    }
    
    RACSignal *willPresentSearching = [[self rac_signalForSelector:@selector(willPresentSearchController:) fromProtocol:@protocol(UISearchControllerDelegate)] mapReplace:@YES];
    RACSignal *willDismissSearching = [[self rac_signalForSelector:@selector(willDismissSearchController:) fromProtocol:@protocol(UISearchControllerDelegate)] mapReplace:@NO];
    signal = [[RACSignal merge:@[willPresentSearching, willDismissSearching]] setNameWithFormat:@"%@ - rac_isActiveSignal", self];
    objc_setAssociatedObject(self, _cmd, signal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return signal;
}

@end
