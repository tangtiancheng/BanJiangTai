//
//  XPPlainShareableAndNotStartScrapeView.h
//  XPApp
//
//  Created by 唐天成 on 16/4/3.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "XPBaseView.h"

@interface XPPlainShareableAndNotStartScrapeView : XPBaseView
@property (nonatomic, weak) IBOutlet UILabel *activityTimeLabel;
@property (nonatomic, weak) IBOutlet UIButton *shareButton;

+ (instancetype)loadFromNib;
@end
