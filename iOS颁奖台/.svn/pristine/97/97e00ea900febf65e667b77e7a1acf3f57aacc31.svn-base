//
//  XPRegionChoicePickViewController.h
//  XPApp
//
//  Created by xinpinghuang on 1/6/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import "XPRegionEntity.h"
#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, XPRegionChoiceStyle){
    XPRegionChoiceStyle_Province_City_District_Town = 4, // 省、市、区（县）、镇
    XPRegionChoiceStyle_Province_City_District = 3, // 省、市、区（县）
    XPRegionChoiceStyle_Province_City = 2, // 省、市
    XPRegionChoiceStyle_Province = 1, // 省
};

@class XPRegionChoicePickViewController;
@protocol XPRegionChoicePickViewDelegate <NSObject>

@optional
- (void)regionChoiceDidCanceled:(nullable XPRegionChoicePickViewController *)regionChoicePickView;

- (void)regionChoicePickView:(nullable XPRegionChoicePickViewController *)regionChoicePickView component:(NSInteger)component row:(NSInteger)row didSelectRegion:(nullable XPRegionEntity *)region;

@end

@interface XPRegionChoicePickViewController : UIWindow

- (nonnull instancetype)initWithDelegate:(nullable id<XPRegionChoicePickViewDelegate>)delegate regionChoiceStyle:(XPRegionChoiceStyle)regionChoiceStyle;

- (void)show;

- (nonnull instancetype)init __attribute__((unavailable("XPRegionChoicePickView cannot be created directly"))
                                           );
+ (nonnull instancetype)new __attribute__((unavailable("XPRegionChoicePickView cannot be created directly"))
                                          );
@end
