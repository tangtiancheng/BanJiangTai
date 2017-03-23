
//
//  UISearchBar+RACSignal.m
//  XPApp
//
//  Created by xinpinghuang on 12/2/15.
//  Copyright © 2015 iiseeuu.com. All rights reserved.
//

#import "UISearchBar+RACSignal.h"
#import <objc/runtime.h>

@interface UISearchBar ()<UISearchBarDelegate>

@end
@implementation UISearchBar (RACSignal)

- (RACSignal *)rac_textSignal
{
    self.delegate = self;
    RACSignal *signal = objc_getAssociatedObject(self, _cmd);
    if(signal != nil) {
        return signal;
    }
    
    signal = [[self rac_signalForSelector:@selector(searchBar:textDidChange:) fromProtocol:@protocol(UISearchBarDelegate)] map:^id (RACTuple *tuple) {
        return tuple.second;
    }];
    objc_setAssociatedObject(self, _cmd, signal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return signal;
}

- (RACSignal *)rac_searchSignal
{
    self.delegate = self;
    RACSignal *signal = objc_getAssociatedObject(self, _cmd);
    if(signal != nil) {
        return signal;
    }
    
    signal = [[self rac_signalForSelector:@selector(searchBarSearchButtonClicked:) fromProtocol:@protocol(UISearchBarDelegate)] map:^id (id value) {
        return value;
    }];
    objc_setAssociatedObject(self, _cmd, signal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return signal;
}

@end
