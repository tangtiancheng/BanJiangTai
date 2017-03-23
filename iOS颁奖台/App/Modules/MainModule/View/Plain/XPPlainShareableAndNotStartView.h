//
//  XPPlainFinished.h
//  XPApp
//
//  Created by xinpinghuang on 1/24/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import "XPBaseView.h"

@interface XPPlainShareableAndNotStartView : XPBaseView

@property (nonatomic, weak) IBOutlet UILabel *activityTimeLabel;
@property (nonatomic, weak) IBOutlet UIButton *shareButton;

+ (instancetype)loadFromNib;

@end
