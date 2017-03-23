//
//  XPPlainResultNotWinView.h
//  XPApp
//
//  Created by xinpinghuang on 1/25/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import "XPBaseView.h"

@interface XPPlainResultNotWinView : XPBaseView

@property (nonatomic, weak) IBOutlet UIImageView *logoImageView;
@property (nonatomic, weak) IBOutlet UIButton *watchPrizeButton;
@property (nonatomic, weak) IBOutlet UIButton *popRootButton;

+ (instancetype)loadFromNib;

@end
