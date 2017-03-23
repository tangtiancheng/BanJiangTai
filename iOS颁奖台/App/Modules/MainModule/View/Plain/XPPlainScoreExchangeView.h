//
//  XPPlainScoreExchangeView.h
//  XPApp
//
//  Created by xinpinghuang on 1/25/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import "XPBaseView.h"

@interface XPPlainScoreExchangeView : XPBaseView

@property (nonatomic, weak) IBOutlet UILabel *tipLabel;
@property (nonatomic, weak) IBOutlet UIButton *exchangeButton;

+ (instancetype)loadFromNib;

@end
