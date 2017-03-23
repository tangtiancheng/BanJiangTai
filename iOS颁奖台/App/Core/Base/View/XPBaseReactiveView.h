//
//  XPBaseReactiveView.h
//  XPApp
//
//  Created by huangxinping on 15/11/13.
//  Copyright © 2015年 ShareMerge. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XPBaseViewModel;
@class XPBaseModel;

/// A protocol which is adopted by views which are backed by view models.
@protocol XPBaseReactiveView <NSObject>

/// Binds the given view model to the view
- (void)bindViewModel:(XPBaseViewModel *)viewModel;
- (void)bindModel:(XPBaseModel *)model;

@end
