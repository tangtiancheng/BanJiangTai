//
//  ZGUIControlBinding.h
//  HelloZhuge
//
//  Created by Amanda Canyon on 8/4/14.
//  Copyright (c) 2014 Zhuge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZGEventBinding.h"

@interface ZGUIControlBinding : ZGEventBinding

@property (nonatomic, readonly) UIControlEvents controlEvent;
@property (nonatomic, readonly) UIControlEvents verifyEvent;

- (instancetype)init __unavailable;
- (instancetype)initWithEventName:(NSString *)eventName
                           onPath:(NSString *)path
                 withControlEvent:(UIControlEvents)controlEvent
                   andVerifyEvent:(UIControlEvents)verifyEvent;

@end
