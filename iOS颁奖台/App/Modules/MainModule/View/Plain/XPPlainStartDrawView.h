//
//  XPPlainStartDrawView.h
//  XPApp
//
//  Created by 唐天成 on 16/3/24.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "XPBaseView.h"

@interface XPPlainStartDrawView : XPBaseView
@property (nonatomic, weak) IBOutlet UIButton *shareButton;

+ (instancetype)loadFromNib;
@end
