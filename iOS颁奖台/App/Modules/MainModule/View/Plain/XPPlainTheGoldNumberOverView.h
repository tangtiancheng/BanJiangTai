//
//  XPPlainTheGoldNumberOverView.h
//  XPApp
//
//  Created by 唐天成 on 16/3/27.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "XPBaseView.h"

@interface XPPlainTheGoldNumberOverView : XPBaseView
@property (weak, nonatomic) IBOutlet UILabel *goldNumberOverLabel;

@property (weak, nonatomic) IBOutlet UIButton *howToGetGoldBtn;
@property (weak, nonatomic) IBOutlet XPBaseView *backView;
+ (instancetype)loadFromNib;
@end
