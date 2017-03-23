//
//  XPBaseView.h
//  Huaban
//
//  Created by huangxinping on 4/21/15.
//  Copyright (c) 2015 iiseeuu.com. All rights reserved.
//

#import "XPBaseReactiveView.h"
#import "XPBaseViewModel.h"
#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <UIKit/UIKit.h>
#import <XPKit/XPKit.h>

IB_DESIGNABLE
@interface XPBaseView : UIView <XPBaseReactiveView>

@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

@end
