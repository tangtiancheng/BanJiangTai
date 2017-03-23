//
//  XPPlainWinningView.h
//  XPApp
//
//  Created by xinpinghuang on 1/25/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import "XPBaseView.h"

@interface XPPlainWinningView : XPBaseView

@property (nonatomic, weak) IBOutlet UILabel *sponsorLabel;
@property (nonatomic, weak) IBOutlet UIButton *gotoShakeResultButton;

+ (instancetype)loadFromNib;

@end
